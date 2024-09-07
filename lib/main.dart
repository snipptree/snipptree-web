import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snippet/common/app_pages.dart';
import 'package:snippet/common/routes.dart';
import 'package:snippet/common/styles.dart';
import 'package:snippet/common/theme.dart';
import 'package:snippet/injector.dart';
import 'package:snippet/ui/snippet_screen/home_page.dart';
import 'package:toastification/toastification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  await init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: GetMaterialApp(
        title: 'SnippTree',
        theme: ThemeData(colorScheme: MaterialTheme.darkScheme()).copyWith(
          scrollbarTheme: Styles.scrollbarTheme,
        ),
        debugShowCheckedModeBanner: false,
        getPages: AppPages.appPages,
        initialRoute: Routes.homePage,
        home: SelectionArea(
          child: HomePage(),
        ),
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
            child: child!,
          );
        },
      ),
    );
  }
}
