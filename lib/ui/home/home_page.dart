import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:snippet/common/colors.dart';
import 'package:snippet/common/routes.dart';
import 'package:snippet/common/shared_pref.dart';
import 'package:snippet/common/strings.dart';
import 'package:snippet/common/utils.dart';
import 'package:snippet/ui/home/home_controller.dart';
import 'package:snippet/ui/home/widgets/google_sign_in.dart';
import 'package:snippet/ui/home/widgets/my_profile_menu.dart';
import 'package:snippet/ui/snippet_dialog/upload_snippet_dialog.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeController ctrl =
      Get.put(HomeController()); // Ensure the controller is injected properly

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
                  child: Row(
                    children: [
                      Obx(() {
                        final authToken = SharedPrefs().getJwtToken();
                        if (ctrl.gUser.value != null &&
                            authToken?.isNotEmpty == true) {
                          return Row(
                            children: [
                              Text(
                                "Hello, ${ctrl.gUser.value?.displayName}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(width: 12),
                              MyProfileMenu(
                                  controller: ctrl), // User Profile Menu
                            ],
                          );
                        } else {
                          return GoogleSignInButton(
                              controller: ctrl); // Google Sign-In Button
                        }
                      }),
                      const SizedBox(width: 24),
                      InkWell(
                        onTap: () {
                          // Handle donation tap
                        },
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Text(
                            "Donate ❤️",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  decoration: TextDecoration.underline,
                                ),
                          ),
                        ),
                      ),
                    ],
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
                  'assets/images/snipptree.png', // Logo asset
                ),
              ),
            ),
            const SizedBox(height: 50),
            Hero(
              tag: 'search_bar',
              child: Container(
                width: 600,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                      controller: ctrl.searchSnippetController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                        hintText: 'Search for snippet',
                        contentPadding:
                            EdgeInsets.fromLTRB(8.0, 11.0, 8.0, 8.0),
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
                    onPressed: navigateToSERP,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      backgroundColor:
                          Theme.of(context).colorScheme.inversePrimary,
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
                      final authToken = SharedPrefs().getJwtToken();
                      if (authToken?.isNotEmpty == true) {
                        await Get.defaultDialog(
                          backgroundColor: AppColors.dialogBgColor,
                          barrierDismissible: true,
                          title: '',
                          titleStyle: const TextStyle(fontSize: 16),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                          titlePadding: EdgeInsets.zero,
                          content: Expanded(child: UploadSnippetDialog()),
                        );
                      } else {
                        Util().showToast(
                          title: "We'd love to have you, please stay with us!",
                          subTitle:
                              "Just one more step to complete your sign-up before you can upload your snippet.",
                          type: ToastType.success,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      backgroundColor:
                          Theme.of(context).colorScheme.inversePrimary,
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
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void navigateToSERP() {
    if (ctrl.searchSnippetController.text.isNotEmpty) {
      Get.toNamed(Routes.serp,
          parameters: {"searchKey": ctrl.searchSnippetController.text});
    } else {
      Util().showToast(
        title: AppStrings.enterASearchQuery,
        subTitle: AppStrings.weHaveSnippetsWaitingForYou,
        type: ToastType.info,
      );
    }
  }
}
