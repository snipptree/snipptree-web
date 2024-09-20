import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:snippet/common/strings.dart';
import 'package:snippet/common/utils.dart';
import 'package:snippet/domain/models/search_response.dart';
import 'package:snippet/domain/usecases/snippet_usecase.dart';

class MySnippetsController extends GetxController {
  var searchKey = ''.obs;
  var isLoading = false.obs;
  var isDataLoaded = false.obs;
  TextEditingController serpController = TextEditingController();

  var mySnippetsResponse = SearchResponse().obs;

  @override
  void onInit() {
    super.onInit();
    getMySnippets();
  }

  Future<void>? getMySnippets() async {
    isLoading.value = true;
    isDataLoaded.value = false;
    mySnippetsResponse.value = mySnippetsResponse();
    final response = await SnippetUseCase().getMySnippets();
    response.fold((l) async {
      isLoading.value = false;
      Util().showToast(
          title: l.message ?? 'Something went wrong',
          subTitle: '',
          type: ToastType.error);
    }, (r) async {
      if (r.error == false) {
        isDataLoaded.value = true;
        mySnippetsResponse.value = r;
      } else {
        Util().showToast(
            title: r.message ?? 'Something went wrong',
            subTitle: '',
            type: ToastType.error);
      }
      isLoading.value = false;
    });
  }
}
