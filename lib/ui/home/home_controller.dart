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
          //TODO: @satheesh handle shared prefs here and jwt token handling
          SharedPrefs().setJwtToken(r.data?.token);
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
        SharedPrefs().setJwtToken("");
        Util().showToast(
            title: "SignOut Successful!",
            subTitle: "We miss you 🥺",
            type: ToastType.info);
      },
    );
  }
}
