import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet/common/app_constants.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart'
    show GoogleSignInPlatform, SignInInitParameters;
import 'package:google_sign_in_web/google_sign_in_web.dart' as web;

class HomeController extends GetxController {
  TextEditingController searchSnippetController = TextEditingController();
  List<String> scopes = <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ];
  GoogleSignIn? googleSignIn;
  // user.data?.authentication ==> future data ==> idToken
  // user.data?.authentication.==> future data ==> accessToken
  Rx<GoogleSignInAccount?> user = Rx<GoogleSignInAccount?>(null);

  late final SharedPreferences prefs;

  @override
  Future<void> onInit() async {

    super.onInit();
    prefs = await SharedPreferences.getInstance();
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
      user.value = account;
    });
    await _canAccessBirthday();
  }

  Future<void> _canAccessBirthday() async {
    String accessToken = prefs.getString('googleAccessToken') ?? '';
    if (googleSignIn != null) {
      await googleSignIn!.canAccessScopes(
        ['https://www.googleapis.com/auth/user.birthday.read'],
        accessToken: accessToken,
      );
      try {
        await googleSignIn!.requestScopes(['https://www.googleapis.com/auth/user.birthday.read']);
      } catch (e) {
        debugPrint('Error: $e');
      }
    }
  }

  Future<void> handleSignIn() async {
    try {
      await googleSignIn?.signInSilently();
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
