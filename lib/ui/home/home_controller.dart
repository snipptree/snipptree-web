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
    // Initialize Google Sign-In plugin before using it
    if (GoogleSignInPlatform.instance is web.GoogleSignInPlugin) {
      (GoogleSignInPlatform.instance as web.GoogleSignInPlugin).initWithParams(
        SignInInitParameters(
          clientId: AppConstants.googleSignInOAuthClientId,
          scopes: scopes,
        ),
      );
    }
    googleSignIn = GoogleSignIn(
      scopes: scopes,
      clientId: AppConstants.googleSignInOAuthClientId,
    );

    googleSignIn?.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      User user = useCase.getUserData(account);
      authenticateUser(user);
    });
  }

  Future<void> handleSignIn() async {
    try {
      await googleSignIn?.signInSilently();
    } catch (error) {
      debugPrint(error.toString());
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
