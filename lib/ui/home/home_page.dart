import 'package:animated_hint_textfield/animated_hint_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:snippet/common/app_constants.dart';
import 'package:snippet/common/colors.dart';
import 'package:snippet/common/image_constants.dart';
import 'package:snippet/common/responsive_layout.dart';
import 'package:snippet/common/routes.dart';
import 'package:snippet/common/shared_pref.dart';
import 'package:snippet/common/utils.dart';
import 'package:snippet/ui/home/home_controller.dart';
import 'package:snippet/ui/home/widgets/my_profile_menu.dart';
import 'package:snippet/ui/snippet_dialog/upload_snippet_dialog.dart';
import 'package:snippet/widgets/custom_marquee.dart';
import 'package:snippet/widgets/reusable_elevated_button.dart';
import 'dart:html' as html;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _ExState();
}

class _ExState extends State<HomePage> {
  final HomeController ctrl = Get.put(HomeController());
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    ctrl.userName.value = SharedPrefs().getUserName() ?? '';
    ctrl.googleSignIn.value = GoogleSignIn(
      clientId: AppConstants.googleSignInOAuthClientId,
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
  }

  @override
  void dispose() {
    _focusNode
        .dispose(); // Clean up the focus node when the widget is disposed.
    ctrl.searchSnippetController.dispose(); // Clean up the text controller.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 45),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Row(
                    children: [
                      // InkWell(
                      //   onTap: () async {
                      //     html.window.open("https://rzp.io/rzp/lekVOb8E", '_blank');
                      //   },
                      //   child: MouseRegion(
                      //     cursor: SystemMouseCursors.click,
                      //     child: Text(
                      //       "${AppConstants.donate} ❤️",
                      //       style: Theme.of(context)
                      //           .textTheme
                      //           .titleMedium
                      //           ?.copyWith(
                      //             decoration: TextDecoration.underline,
                      //           ),
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(width: 24),
                      Obx(() {
                        return ctrl.userName.value.isNotEmpty
                            ? InkWell(
                                onTap: () {
                                  Get.toNamed(Routes.mySnippets);
                                },
                                child: Text(AppConstants.mySnippets,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            fontWeight: FontWeight.w700)),
                              )
                            : const SizedBox();
                      }),
                      const SizedBox(width: 24),
                      Obx(() {
                        return ctrl.userName.value.isNotEmpty
                            ? Row(
                                children: [
                                  Text(
                                    "${AppConstants.hello} ${ctrl.userName.value}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(width: 12),
                                  MyProfileMenu(
                                      controller: ctrl), // User Profile Menu
                                ],
                              )
                            : GoogleSignInButton(controller: ctrl);
                      }),
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
                      child: ResponsiveLayout(
                          mobile: Image.asset(
                            ImageConstants.snippTreeImg,
                            width: 250,
                            height: 150,
                          ),
                          tab: Image.asset(ImageConstants.snippTreeImg),
                          web: Image.asset(ImageConstants.snippTreeImg)),
                    ),
                  ),
                  const ResponsiveLayout(
                      mobile: SizedBox(height: 0),
                      tab: SizedBox(height: 50),
                      web: SizedBox(height: 50)),
                  Hero(
                    tag: 'search_bar',
                    child: ResponsiveLayout(
                      mobile: Container(
                        width: 280,
                        height: 60,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
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
                              // Using an animated typewriter effect for the hint
                              if (event.logicalKey ==
                                  LogicalKeyboardKey.enter) {
                                navigateToSERP();
                              }
                            },
                            child: AnimatedTextField(
                              controller: ctrl.searchSnippetController,
                              animationType: Animationtype.typer,
                              hintTextStyle: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                              ),
                              hintTexts: const [
                                'Search for a code snippet...',
                                'Share your code snippets with the world 🌍',
                                'Every like plants a tree 🌳',
                              ],
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.search),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(bottom: 18)),
                            ),
                          ),
                        ),
                      ),
                      tab: Container(
                        width: 600,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Colors.grey[700]!),
                        ),
                        child: Material(
                          color: Colors.grey[900],
                          child: KeyboardListener(
                            focusNode: FocusNode(),
                            onKeyEvent: (event) async {
                              // Using an animated typewriter effect for the hint
                              if (event.logicalKey ==
                                  LogicalKeyboardKey.enter) {
                                navigateToSERP();
                              }
                            },
                            child: AnimatedTextField(
                              controller: ctrl.searchSnippetController,
                              animationType: Animationtype.typer,
                              hintTextStyle: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                              ),
                              hintTexts: const [
                                'Search for a code snippet...',
                                'Share your code snippets with the world 🌍',
                                'Every like plants a tree 🌳',
                              ],
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.search),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(bottom: 18)),
                            ),
                          ),
                        ),
                      ),
                      web: Container(
                        width: 600,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Colors.grey[700]!),
                        ),
                        child: Material(
                          color: Colors.grey[900],
                          child: KeyboardListener(
                            focusNode: FocusNode(),
                            onKeyEvent: (event) async {
                              // Using an animated typewriter effect for the hint
                              if (event.logicalKey ==
                                  LogicalKeyboardKey.enter) {
                                navigateToSERP();
                              }
                            },
                            child: AnimatedTextField(
                              controller: ctrl.searchSnippetController,
                              animationType: Animationtype.typer,
                              hintTextStyle: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                              ),
                              hintTexts: const [
                                'Search for a code snippet...',
                                'Share your code snippets with the world 🌍',
                                'Every like plants a tree 🌳',
                              ],
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.search),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(bottom: 18)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  ResponsiveLayout(
                      mobile: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 40,
                              width: 124,
                              child: ReusableElevatedButton(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 8),
                                  textStyle: const TextStyle(fontSize: 12),
                                  onPressed: navigateToSERP,
                                  buttonText: AppConstants.searchSnippet)),
                          const SizedBox(width: 10),
                          SizedBox(
                            height: 40,
                            width: 124,
                            child: ReusableElevatedButton(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
                              textStyle: const TextStyle(fontSize: 12),
                              onPressed: () async {
                                final authToken = SharedPrefs().getJwtToken();
                                if (authToken?.isNotEmpty == true) {
                                  await Get.defaultDialog(
                                    backgroundColor: AppColors.dialogBgColor,
                                    barrierDismissible: true,
                                    title: '',
                                    titleStyle: const TextStyle(fontSize: 16),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    titlePadding: EdgeInsets.zero,
                                    content:
                                        Expanded(child: UploadSnippetDialog()),
                                  );
                                } else {
                                  Util().showToast(
                                    title: AppConstants.loginToastTitle,
                                    subTitle: AppConstants.toastSubTitle,
                                    type: ToastType.success,
                                  );
                                }
                              },
                              buttonText: AppConstants.uploadSnippet,
                            ),
                          ),
                        ],
                      ),
                      tab: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 55,
                              width: 180,
                              child: ReusableElevatedButton(
                                  onPressed: navigateToSERP,
                                  buttonText: AppConstants.searchSnippet)),
                          const SizedBox(width: 20),
                          SizedBox(
                            height: 55,
                            width: 180,
                            child: ReusableElevatedButton(
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
                                    content:
                                        Expanded(child: UploadSnippetDialog()),
                                  );
                                } else {
                                  Util().showToast(
                                    title: AppConstants.loginToastTitle,
                                    subTitle: AppConstants.toastSubTitle,
                                    type: ToastType.success,
                                  );
                                }
                              },
                              buttonText: AppConstants.uploadSnippet,
                            ),
                          ),
                        ],
                      ),
                      web: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 55,
                              width: 180,
                              child: ReusableElevatedButton(
                                  onPressed: navigateToSERP,
                                  buttonText: AppConstants.searchSnippet)),
                          const SizedBox(width: 20),
                          SizedBox(
                            height: 55,
                            width: 180,
                            child: ReusableElevatedButton(
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
                                    content:
                                        Expanded(child: UploadSnippetDialog()),
                                  );
                                } else {
                                  Util().showToast(
                                    title: AppConstants.loginToastTitle,
                                    subTitle: AppConstants.toastSubTitle,
                                    type: ToastType.success,
                                  );
                                }
                              },
                              buttonText: AppConstants.uploadSnippet,
                            ),
                          ),
                        ],
                      )),
                  const Spacer(),
                   Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          AppConstants.copyRightText,
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        const SizedBox(width: 2),
                        InkWell(
                          onTap: (){
                            html.window.open("https://www.snipptree.com/home", '_blank');
                          },
                          child: const Text(
                            AppConstants.privacyPolicy,
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Material(
          child: CustomMarquee(
            text:
                '🌱 Code. Share. Plant on snipptree.com! 🌟 For every 100 tree-likes on your snippets, we plant a tree on your behalf 🌳. Let’s build a greener future! 💻🌍 #GoGreen',
          ),
        ),
      ],
    );
  }

  void navigateToSERP() {
    if (ctrl.searchSnippetController.text.isNotEmpty) {
      Get.toNamed(Routes.serp, parameters: {
        AppConstants.searchKey: ctrl.searchSnippetController.text
      });
    } else {
      Util().showToast(
        title: AppConstants.enterASearchQuery,
        subTitle: AppConstants.weHaveSnippetsWaitingForYou,
        type: ToastType.info,
      );
    }
  }
}

class GoogleSignInButton extends StatelessWidget {
  final HomeController controller;

  const GoogleSignInButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.white),
        padding:
            WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: 12)),
      ),
      onPressed: () {
        controller.signInWithGoogle();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 16),
            Image.asset(
              ImageConstants.googleLogoImg, // Add a Google logo in your assets
              height: 24,
            ),
            const SizedBox(width: 10),
            const Text(
              AppConstants.signInWithGoogle,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
