import 'package:get/get.dart';
import 'package:snippet/common/routes.dart';
import 'package:snippet/ui/home/home_page.dart';
import 'package:snippet/ui/my_snippets/my_snippets_view.dart';
import 'package:snippet/ui/search_result/search_result_view.dart';

class AppPages {
  static List<GetPage<dynamic>>? appPages = [
    GetPage(name: Routes.homePage, page: () => const HomePage()),
    GetPage(name: Routes.serp, page: () => const SearchResultView()),
    GetPage(name: Routes.mySnippets, page: () => const MySnippetsView()),
  ];
}
