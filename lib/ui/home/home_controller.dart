import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart'
    show GoogleSignInPlatform, SignInInitParameters;
import 'package:google_sign_in_web/google_sign_in_web.dart' as web;
import 'package:snippet/common/app_constants.dart';
import 'package:snippet/common/shared_pref.dart';
import 'package:snippet/common/utils.dart';
import 'package:snippet/domain/models/user.dart';
import 'package:snippet/domain/usecases/home_usecase.dart';

class HomeController extends GetxController {
  TextEditingController searchSnippetController = TextEditingController();
  List<String> scopes = <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ];
  GoogleSignIn? googleSignIn;

  // user.data?.authentication ==> future data ==> idToken
  // user.data?.authentication.==> future data ==> accessToken
  var isLoading = false.obs;

  HomeUseCase useCase = HomeUseCase();

  @override
  Future<void> onInit() async {
    super.onInit();

    // Initialize Google Sign-In plugin
    if (GoogleSignInPlatform.instance is web.GoogleSignInPlugin) {
      try {
        (GoogleSignInPlatform.instance as web.GoogleSignInPlugin).initWithParams(
          SignInInitParameters(
            clientId: AppConstants.googleSignInOAuthClientId,
            scopes: scopes,
          ),
        );
        debugPrint('Google Sign-In Web initialized successfully.');
      } catch (error) {
        debugPrint('Error initializing Google Sign-In Web: $error');
      }
    }

    googleSignIn = GoogleSignIn(
      scopes: scopes,
      clientId: AppConstants.googleSignInOAuthClientId,
    );

    // Listen for user sign-in state
    googleSignIn?.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      if (account != null) {
        // Call authenticateUser once sign-in is successful
        User user = useCase.getUserData(account);
        authenticateUser(user);
      } else {
        debugPrint('No user signed in');
      }
    });

    // Optionally call signInSilently() to check if a user is already signed in
    try {
      await googleSignIn?.signInSilently();
    } catch (error) {
      debugPrint('Error in silent sign-in: $error');
    }
  }

  Future<void> handleSignIn() async {
    try {
      await googleSignIn?.signInSilently() ?? googleSignIn?.signIn();
      debugPrint('User signed in successfully.');
    } catch (error) {
      debugPrint('Error signing in: $error');
      Util().showToast(title: 'Error', subTitle: error.toString(), type: ToastType.error);
    }
  }

  Future<void> authenticateUser(User user) async {
    isLoading.value = true;
    final response = await useCase.authenticateUser(user);
    response.fold((l) async {
      isLoading.value = false;
      Util().showToast(title: l.message ?? 'Something went wrong', subTitle: '', type: ToastType.error);
    }, (r) async {
      if (r.error == false) {
        SharedPrefs().setUserName(r.data?.firstName);
        SharedPrefs().setImageUrl(r.data?.profilePicUrl);
        SharedPrefs().setJwtToken(r.data?.token);
      } else {
        Util().showToast(title: r.message ?? 'Something went wrong', subTitle: '', type: ToastType.error);
      }
      isLoading.value = false;
    });
  }
}
