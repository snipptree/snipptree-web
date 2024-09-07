import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:snippet/common/strings.dart';
import 'package:snippet/common/utils.dart';
import 'package:snippet/domain/models/search_response.dart';
import 'package:snippet/domain/usecases/snippet_usecase.dart';

class SearchResultController extends GetxController {
  var searchKey = ''.obs;
  var isLoading = false.obs;
  var isDataLoaded = false.obs;
  TextEditingController serpController = TextEditingController();

  var searchResponse = SearchResponse().obs;

  var gridViewItems = [
    {"title": "Search for Bus Stop Near Me", "image": 'assets/images/snipptree.png'},
    {"title": "Search for Bus Stop Near Me", "image": 'assets/images/snipptree.png'},
    {"title": "Search for Bus Stop Near Me", "image": 'assets/images/snipptree.png'},
    {"title": "Search for Bus Stop Near Me", "image": 'assets/images/snipptree.png'},
  ];

  Future<void>? getSnippets({String? searchQuery}) async {
    if (searchQuery == null) {
      searchKey.value = Get.parameters['searchKey'] ?? '';
      serpController.text = searchKey.value;
    }

    if (searchKey.value.isEmpty) {
      Util().showToast(
          title: AppStrings.enterASearchQuery, subTitle: AppStrings.weHaveSnippetsWaitingForYou, type: ToastType.info);
      return;
    }

    isLoading.value = true;
    isDataLoaded.value = false;
    searchResponse.value = SearchResponse();
    final response = await SnippetUseCase().getSnippets(searchQuery ?? searchKey.value);
    response.fold((l) async {
      isLoading.value = false;
      Util().showToast(title: l.message ?? 'Something went wrong', subTitle: '', type: ToastType.error);
    }, (r) async {
      if (r.error == false) {
        isDataLoaded.value = true;
        searchResponse.value = r;
      } else {
        Util().showToast(title: r.message ?? 'Something went wrong', subTitle: '', type: ToastType.error);
      }
      isLoading.value = false;
    });
  }
}
