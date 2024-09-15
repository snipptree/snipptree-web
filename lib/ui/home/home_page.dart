import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:snippet/common/app_constants.dart';
import 'package:snippet/common/colors.dart';
import 'package:snippet/common/routes.dart';
import 'package:snippet/common/strings.dart';
import 'package:snippet/common/utils.dart';
import 'package:snippet/ui/snippet_dialog/upload_snippet_dialog.dart';
import 'package:snippet/ui/home/home_controller.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';
import 'package:google_sign_in_web/google_sign_in_web.dart' as web;

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeController ctrl = HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 24),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 24, top: 16),
                    child: FutureBuilder(
                      future: (GoogleSignInPlatform.instance as web.GoogleSignInPlugin).initWithParams(
                        SignInInitParameters(
                          clientId: AppConstants.googleSignInOAuthClientId,
                          scopes: ctrl.scopes,
                        ),
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Row(
                            children: [
                              InkWell(
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: Text(
                                    "Donate ❤️",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(decoration: TextDecoration.underline),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 24),
                              (GoogleSignInPlatform.instance as web.GoogleSignInPlugin).renderButton(
                                configuration: web.GSIButtonConfiguration(shape: web.GSIButtonShape.pill),
                              ),
                            ],
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Hero(
                tag: 'logo',
                child: Center(
                  child: Image.asset(
                    'assets/images/snipptree.png',
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Hero(
                tag: 'search_bar',
                child: Container(
                  width: 600,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.grey[700]!),
                  ),
                  child: Material(
                    color: Colors.grey[900],
                    child: KeyboardListener(
                      focusNode: FocusNode(),
                      onKeyEvent: (event) async {
                        if (event.logicalKey == LogicalKeyboardKey.enter) {
                          navigateToSERP();
                        }
                      },
                      child: TextFormField(
                        textAlign: TextAlign.start,
                        controller: ctrl.searchSnippetController,
                        decoration: const InputDecoration(
                          prefixIcon: Align(
                            widthFactor: 0.0,
                            heightFactor: 0.0,
                            alignment: Alignment.center,
                            child: Icon(Icons.search),
                          ),
                          border: InputBorder.none,
                          hintText: 'Search for snippet',
                          contentPadding: EdgeInsets.fromLTRB(8.0, 11.0, 8.0, 8.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 55,
                    width: 180,
                    child: ElevatedButton(
                      onPressed: () {
                        navigateToSERP();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      ),
                      child: const Text(
                        'Search Snippet',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                    height: 55,
                    width: 180,
                    child: ElevatedButton(
                      onPressed: () async {
                        await Get.defaultDialog(
                            backgroundColor: AppColors.dialogBgColor,
                            barrierDismissible: true,
                            title: '',
                            titleStyle: const TextStyle(fontSize: 16),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                            titlePadding: EdgeInsets.zero,
                            content: Expanded(child: UploadSnippetDialog()));
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      ),
                      child: const Text(
                        "Upload Snippet",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: Text(
                  '© 2024 www.snipptree.com. All rights reserved.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  void navigateToSERP() {
    if (ctrl.searchSnippetController.text.isNotEmpty) {
      Get.toNamed(Routes.serp, parameters: {"searchKey": ctrl.searchSnippetController.text});
    } else {
      Util().showToast(
        title: AppStrings.enterASearchQuery,
        subTitle: AppStrings.weHaveSnippetsWaitingForYou,
        type: ToastType.info,
      );
    }
  }

  final OutlineInputBorder customBorder = OutlineInputBorder(
    borderSide: const BorderSide(
      color: Colors.grey,
      width: 0.5, // Set the border width here
    ),
    borderRadius: BorderRadius.circular(4.0), // Set the border radius here
  );
}
