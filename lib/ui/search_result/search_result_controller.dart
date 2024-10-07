import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:snippet/common/app_constants.dart';
import 'package:snippet/common/utils.dart';
import 'package:snippet/domain/models/search_response.dart';
import 'package:snippet/domain/usecases/snippet_usecase.dart';

class SearchResultController extends GetxController {
  var searchKey = ''.obs;
  var isLoading = false.obs;
  var isDataLoaded = false.obs;
  var snippetId = '';
  var errorMsg = ''.obs;
  TextEditingController serpController = TextEditingController();

  var searchResponse = SearchResponse().obs;

  @override
  void onInit() {
    super.onInit();
    getSnippets();
  }

  Future<void>? getSnippets({String? searchQuery}) async {
    snippetId = Get.parameters['snippetId'] ?? '';
    if ((searchQuery?.isEmpty == true || searchQuery == null) &&
        snippetId.isNotEmpty) {
      isLoading.value = true;
      isDataLoaded.value = false;
      searchResponse.value = SearchResponse();
      final response = await SnippetUseCase().getSnippetWithId(snippetId);
      response.fold((l) async {
        isLoading.value = false;
        Util().showToast(
            title: l.message ?? 'Something went wrong',
            subTitle: '',
            type: ToastType.error);
      }, (r) async {
        if (r.error == false) {
          isDataLoaded.value = true;
          searchResponse.value = r;
        } else {
          Util().showToast(
              title: r.message ?? 'Something went wrong',
              subTitle: '',
              type: ToastType.error);
          errorMsg.value = r.message ?? 'Something went wrong';
        }
        isLoading.value = false;
      });
    } else {
      if (searchQuery == null) {
        searchKey.value = Get.parameters['searchKey'] ?? '';
        serpController.text = searchKey.value;
      }

      if (searchKey.value.isEmpty) {
        Util().showToast(
            title: AppConstants.enterASearchQuery,
            subTitle: AppConstants.weHaveSnippetsWaitingForYou,
            type: ToastType.info);
        return;
      }

      isLoading.value = true;
      isDataLoaded.value = false;
      searchResponse.value = SearchResponse();
      final response =
          await SnippetUseCase().getSnippets(searchQuery ?? searchKey.value);
      response.fold((l) async {
        isLoading.value = false;
        Util().showToast(
            title: l.message ?? 'Something went wrong',
            subTitle: '',
            type: ToastType.error);
      }, (r) async {
        if (r.error == false) {
          isDataLoaded.value = true;
          searchResponse.value = r;
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

  Future<void>? updateLikeStatus(
      {required int index,
      required String snippetId}) async {
    bool isLiked = searchResponse.value.data![index].isLiked;
    if (isLiked) {
      final response = await SnippetUseCase().disLikeSnippet(snippetId);
      response.fold((l) async {
        Util().showToast(
            title: l.message ?? 'Something went wrong',
            subTitle: '',
            type: ToastType.error);
      }, (r) async {
        if (r.error == false) {
          updateSnippets(isLiked, index);
        } else {
          Util().showToast(
              title: r.message ?? 'Something went wrong',
              subTitle: '',
              type: ToastType.error);
          errorMsg.value = r.message ?? 'Something went wrong';
        }
      });
    } else {
      final response = await SnippetUseCase().likeSnippet(snippetId);
      response.fold((l) async {
        Util().showToast(
            title: l.message ?? 'Something went wrong',
            subTitle: '',
            type: ToastType.error);
      }, (r) async {
        if (r.error == false) {
          updateSnippets(isLiked, index);
        } else {
          Util().showToast(
              title: r.message ?? 'Something went wrong',
              subTitle: '',
              type: ToastType.error);
          errorMsg.value = r.message ?? 'Something went wrong';
        }
      });
    }
  }

  void updateSnippets(bool isLiked, int index) {
    searchResponse.value.data![index].isLiked = !isLiked;
    if (isLiked) {
      searchResponse.value.data![index].totalLikes =
          (searchResponse.value.data![index].totalLikes ?? 0) - 1;
    } else {
      searchResponse.value.data![index].totalLikes =
          (searchResponse.value.data![index].totalLikes ?? 0) + 1;
    }
    searchResponse.refresh();
  }


}
