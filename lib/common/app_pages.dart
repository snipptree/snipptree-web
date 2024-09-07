import 'package:get/get.dart';
import 'package:snippet/common/routes.dart';
import 'package:snippet/ui/search_result/search_result_view.dart';
import 'package:snippet/ui/snippet_screen/home_page.dart';

class AppPages {

static List<GetPage<dynamic>>? appPages = [
  

    GetPage(name: Routes.homePage, page: () => HomePage()),
        GetPage(name: Routes.serp, page: () =>  SearchResultView()),
   
   
  ];
    
}