import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:snippet/common/shared_pref.dart';
import 'package:snippet/common/utils.dart';
import 'package:snippet/domain/models/user.dart';
import 'package:snippet/domain/usecases/home_usecase.dart';

class HomeController extends GetxController {
  TextEditingController searchSnippetController = TextEditingController();
  var isLoading = false.obs;
  var gUser = Rxn<GoogleSignInAccount>();
  var googleSignIn = Rxn<GoogleSignIn>();
  var userName = ''.obs;

  HomeUseCase useCase = HomeUseCase();

  Future<void> authenticateUser(User user) async {
    isLoading.value = true;
    final response = await useCase.authenticateUser(user);
    response.fold(
      (l) async {
        isLoading.value = false;
        Util().showToast(
            title: l.message ?? 'Something went wrong',
            subTitle: '',
            type: ToastType.error);
      },
      (r) async {
        if (r.error == false) {
          SharedPrefs().setJwtToken(r.data?.token);
          SharedPrefs().setUserName('${user.displayName}');
        } else {
          Util().showToast(
              title: r.message ?? 'Something went wrong',
              subTitle: '',
              type: ToastType.error);
        }
        isLoading.value = false;
      },
    );
  }

  void handleLogout() {
    googleSignIn.value?.signOut().then(
      (value) {
        gUser.value = null;
        userName.value = "";
        SharedPrefs().setJwtToken("");
        SharedPrefs().setUserName("");
        Util().showToast(
            title: "SignOut Successful!",
            subTitle: "We miss you 🥺",
            type: ToastType.info);
      },
    );
  }

  // Sign-in with Google (regular flow)
  Future<void> signInWithGoogle() async {
    HomeUseCase useCase = HomeUseCase();
    try {
      gUser.value = await googleSignIn.value?.signIn();
      if (gUser.value != null && gUser.value?.email.isNotEmpty == true) {
        userName.value = gUser.value?.displayName ?? "";
        User user = useCase.getUserData(gUser.value);
        authenticateUser(user);
      }
    } catch (error) {
      // Handle sign-in errors
      debugPrint('Error during Google sign-in: $error');
      Util().showToast(
          title: "Google sign-in failed.",
          subTitle: "Please try again.",
          type: ToastType.error);
    }
  }
}
