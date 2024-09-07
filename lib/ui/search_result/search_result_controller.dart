import 'package:get/get.dart';
import 'package:snippet/common/utis.dart';
import 'package:snippet/domain/models/search_response.dart';
import 'package:snippet/domain/usecases/snippet_usecase.dart';

class SearchResultController extends GetxController{

   var searchKey = ''.obs;
     var isLoading = false.obs;
  var isDataLoaded = false.obs;


  var searchResponse = SearchResponse().obs;

  var gridViewItems = 
      [
    {
      "title": "Search for Bus Stop Near Me",
      "image": 'assets/images/snipptree.png'
    },
      {
      "title": "Search for Bus Stop Near Me",
      "image": 'assets/images/snipptree.png'
    },
      {
      "title": "Search for Bus Stop Near Me",
      "image": 'assets/images/snipptree.png'
    },
      {
      "title": "Search for Bus Stop Near Me",
      "image": 'assets/images/snipptree.png'
    },


   
   
  ];

   Future<void> getSnippets() async {
   searchKey.value =  Get.parameters['searchKey']??'';
    isLoading.value = true;
    isDataLoaded.value = false;
    searchResponse.value = SearchResponse();
    final response = await SnippetUseCase().getSnippets(searchKey.value);
    response.fold((l) async {
      isLoading.value = false;
      Util().showOkDialog(l.message??'Something wentwrong');
    }, (r) async {
      if(r.error == false){
        isDataLoaded.value = true;
        searchResponse.value = r;
         Util().showOkDialog(r.message??'Uploaded successfully');
      }else{
        Util().showOkDialog(r.message??'Something wentwrong');
      }
      isLoading.value = false;

    });
  }
}