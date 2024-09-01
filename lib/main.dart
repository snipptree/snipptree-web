import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snippet/common/theme.dart';
import 'package:snippet/injector.dart';
import 'package:snippet/ui/snippet_dialog/dialog_view.dart';
import 'package:snippet/ui/snippet_screen/create_snippet.dart';

void main() async{
  runApp(const MyApp());
   WidgetsFlutterBinding.ensureInitialized();
  await init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'SnippTree',
      theme: ThemeData(colorScheme: MaterialTheme.darkScheme()),
      debugShowCheckedModeBanner: false,

      home:  CodeEditorScreen(),
    );
  }
}


 