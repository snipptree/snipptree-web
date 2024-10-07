import 'package:animated_hint_textfield/animated_hint_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:snippet/common/app_constants.dart';
import 'package:snippet/common/border_radius.dart';
import 'package:snippet/common/colors.dart';
import 'package:snippet/common/image_constants.dart';
import 'package:snippet/common/responsive_layout.dart';
import 'package:snippet/common/routes.dart';
import 'package:snippet/common/shared_pref.dart';
import 'package:snippet/common/utils.dart';
import 'package:snippet/ui/home/home_controller.dart';
import 'package:snippet/ui/home/home_page.dart';
import 'package:snippet/ui/home/widgets/my_profile_menu.dart';
import 'package:snippet/ui/search_result/search_result_controller.dart';
import 'package:snippet/widgets/ellipsis_text_hover.dart';

import 'view_snippet_dialog.dart';

class SearchResultView extends StatefulWidget {
  const SearchResultView({super.key});

  @override
  State<SearchResultView> createState() => _SearchResultViewState();
}

class _SearchResultViewState extends State<SearchResultView> {
  final SearchResultController ctrl = SearchResultController();
  final HomeController homeCtrl = Get.find();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ctrl.getSnippets();
    });
  }

  @override
  Widget build(BuildContext context) {
    int count = MediaQuery.of(context).size.width ~/ 300;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          children: [
            HeadingRow(ctrl: ctrl, homeCtrl: homeCtrl),
            Expanded(
              child: Stack(
                children: [
                  Obx(() => GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          crossAxisCount: count,
                          childAspectRatio: 16 / 11.5,
                        ),
                        itemBuilder: (_, index) => InkWell(
                          customBorder: const RoundedRectangleBorder(
                            borderRadius: AppBorderRadius.k16px,
                          ),
                          onTap: () async {
                            await Get.defaultDialog(
                                backgroundColor: AppColors.dialogBgColor,
                                barrierDismissible: true,
                                title: '',
                                titleStyle: const TextStyle(fontSize: 16),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 32, vertical: 16),
                                titlePadding: EdgeInsets.zero,
                                content: Expanded(
                                  child: SizedBox(
                                    width: 400,
                                    child: Stack(children: [
                                      ViewSnippetDialog(
                                        snippetData: ctrl
                                            .searchResponse.value.data![index],
                                      ),
                                      Positioned(
                                          right: 0.0,
                                          child: GestureDetector(
                                            onTap: () {
                                              Get.back();
                                            },
                                            child: const Align(
                                              alignment: Alignment.topRight,
                                              child: CircleAvatar(
                                                radius: 14.0,
                                                backgroundColor: Colors.white,
                                                child: Icon(Icons.close),
                                              ),
                                            ),
                                          ))
                                    ]),
                                  ),
                                ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      DecoratedBox(
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black12),
                                          borderRadius: AppBorderRadius.k8px,
                                        ),
                                        child: ClipRRect(
                                          borderRadius: AppBorderRadius.k16px,
                                          child: Image.network(
                                            Uri.encodeFull(ctrl.searchResponse
                                                    .value.data![index].image ??
                                                ImageConstants.placeHolderImg),
                                            fit: BoxFit.fill,
                                            loadingBuilder:
                                                (BuildContext context,
                                                    Widget child,
                                                    ImageChunkEvent?
                                                        loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              }
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  value: loadingProgress
                                                              .expectedTotalBytes !=
                                                          null
                                                      ? loadingProgress
                                                              .cumulativeBytesLoaded /
                                                          loadingProgress
                                                              .expectedTotalBytes!
                                                      : null,
                                                ),
                                              );
                                            },
                                            errorBuilder: (BuildContext context,
                                                Object error,
                                                StackTrace? stackTrace) {
                                              return Image.network(
                                                ImageConstants.placeHolderImg,
                                                fit: BoxFit.fill,
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: EllipsisTextWithHover(
                                          text: ctrl
                                                  .searchResponse
                                                  .value
                                                  .data![index]
                                                  .title
                                                  ?.capitalize ??
                                              '',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: Obx(() => IconButton(
                                            icon: FaIcon(
                                              (ctrl.searchResponse.value
                                                      .data![index].isLiked)
                                                  ? FontAwesomeIcons.tree
                                                  : FontAwesomeIcons.tree,
                                              color: (ctrl.searchResponse.value
                                                      .data![index].isLiked)
                                                  ? Colors.green
                                                  : Colors.green.shade100,
                                            ),
                                            onPressed: () {
                                              final authToken =
                                                  SharedPrefs().getJwtToken();
                                              if (authToken?.isNotEmpty ==
                                                  true) {
                                                ctrl.updateLikeStatus(
                                                    index: index,
                                                    snippetId: ctrl
                                                            .searchResponse
                                                            .value
                                                            .data![index]
                                                            .id ??
                                                        '');
                                              } else {
                                                Util().showToast(
                                                  title: AppConstants
                                                      .loginToastTitle,
                                                  subTitle:
                                                      AppConstants.loginForLike,
                                                  type: ToastType.info,
                                                );
                                              }
                                            },
                                          )),
                                    ),
                                    Obx(
                                      () => Text(
                                          '${ctrl.searchResponse.value.data![index].totalLikes}'),
                                    ),
                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: IconButton(
                                        icon: FaIcon(
                                          FontAwesomeIcons.share,
                                          color: Colors.green.shade100,
                                        ),
                                        onPressed: () {
                                          Clipboard.setData(ClipboardData(
                                              text:
                                                  '${AppConstants.websiteUrl}#/serp?snippetId=${ctrl.searchResponse.value.data![index].id}'));
                                          Util().showToast(
                                              title: 'Copied to clip board',
                                              subTitle:
                                                  'You can share the snippet now',
                                              type: ToastType.info);
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        itemCount: ctrl.searchResponse.value.data?.length ?? 0,
                      )),
                  Obx(() => ctrl.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : const SizedBox())
                ],
              ),
            ),
          ],
        ),
      ).paddingOnly(bottom: 32),
    );
  }
}

class HeadingRow extends StatelessWidget {
  final SearchResultController ctrl;
  final HomeController homeCtrl;

  const HeadingRow({required this.ctrl, required this.homeCtrl, super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobile: Column(
          children: [
            GestureDetector(
                onTap: () {
                  Get.offAllNamed(Routes.homePage);
                },
                child: Hero(
                  tag: 'logo',
                  child: AspectRatio(
                    aspectRatio: 8 / 4,
                    child: Image.asset(
                      ImageConstants.snippTreeImg,
                    ),
                  ),
                )),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(() {
                  return homeCtrl.userName.value.isNotEmpty
                      ? InkWell(
                          onTap: () {
                            Get.toNamed(Routes.mySnippets);
                          },
                          child: Text(AppConstants.mySnippets,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w700)),
                        )
                      : const SizedBox();
                }),
                const SizedBox(width: 8),
                Obx(() {
                  return homeCtrl.userName.value.isNotEmpty
                      ? Row(
                          children: [
                            Text(
                              "${AppConstants.hello} ${homeCtrl.userName.value}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(width: 8),
                            MyProfileMenu(
                                controller: homeCtrl), // User Profile Menu
                          ],
                        )
                      : GoogleSignInButton(controller: homeCtrl);
                }),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Hero(
              tag: 'search_bar',
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: AppBorderRadius.k24px,
                  border: Border.all(color: Colors.grey[700]!),
                ),
                child: Material(
                  color: Colors.grey[900],
                  child: KeyboardListener(
                    focusNode: FocusNode(),
                    onKeyEvent: (event) async {
                      if (event.logicalKey == LogicalKeyboardKey.enter) {
                        await ctrl.getSnippets(
                            searchQuery: ctrl.searchKey.value);
                      }
                    },
                    child: AnimatedTextField(
                      onChanged: (val) {
                        ctrl.searchKey.value = val;
                      },
                      controller: ctrl.serpController,
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
                          contentPadding: EdgeInsets.only(bottom: 20)),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
        tab: Row(
          children: [
            Expanded(
              flex: 2,
              child: Hero(
                tag: 'search_bar',
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: AppBorderRadius.k24px,
                    border: Border.all(color: Colors.grey[700]!),
                  ),
                  child: Material(
                    color: Colors.grey[900],
                    child: KeyboardListener(
                      focusNode: FocusNode(),
                      onKeyEvent: (event) async {
                        if (event.logicalKey == LogicalKeyboardKey.enter) {
                          await ctrl.getSnippets(
                              searchQuery: ctrl.searchKey.value);
                        }
                      },
                      child: AnimatedTextField(
                        onChanged: (val) {
                          ctrl.searchKey.value = val;
                        },
                        controller: ctrl.serpController,
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
                            contentPadding: EdgeInsets.only(bottom: 20)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(() {
                    return homeCtrl.userName.value.isNotEmpty
                        ? InkWell(
                            onTap: () {
                              Get.toNamed(Routes.mySnippets);
                            },
                            child: Text(AppConstants.mySnippets,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.w700)),
                          )
                        : const SizedBox();
                  }),
                  const SizedBox(width: 24),
                  Obx(() {
                    return homeCtrl.userName.value.isNotEmpty
                        ? Row(
                            children: [
                              Text(
                                "${AppConstants.hello} ${homeCtrl.userName.value}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(width: 12),
                              MyProfileMenu(
                                  controller: homeCtrl), // User Profile Menu
                            ],
                          )
                        : GoogleSignInButton(controller: homeCtrl);
                  }),
                ],
              ),
            ),
          ],
        ).paddingOnly(top:24,bottom: 12),
        web: Row(
          children: [
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  Get.offAllNamed(Routes.homePage);
                },
                child: Hero(
                  tag: 'logo',
                  child: AspectRatio(
                    aspectRatio: 10 / 6,
                    child: Image.asset(
                      ImageConstants.snippTreeImg,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 50,
            ),
            Expanded(
              flex: 4,
              child: Hero(
                tag: 'search_bar',
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: AppBorderRadius.k24px,
                    border: Border.all(color: Colors.grey[700]!),
                  ),
                  child: Material(
                    color: Colors.grey[900],
                    child: KeyboardListener(
                      focusNode: FocusNode(),
                      onKeyEvent: (event) async {
                        if (event.logicalKey == LogicalKeyboardKey.enter) {
                          await ctrl.getSnippets(
                              searchQuery: ctrl.searchKey.value);
                        }
                      },
                      child: AnimatedTextField(
                        onChanged: (val) {
                          ctrl.searchKey.value = val;
                        },
                        controller: ctrl.serpController,
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
                            contentPadding: EdgeInsets.only(bottom: 20)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(() {
                    return homeCtrl.userName.value.isNotEmpty
                        ? InkWell(
                            onTap: () {
                              Get.toNamed(Routes.mySnippets);
                            },
                            child: Text(AppConstants.mySnippets,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.w700)),
                          )
                        : const SizedBox();
                  }),
                  const SizedBox(width: 24),
                  Obx(() {
                    return homeCtrl.userName.value.isNotEmpty
                        ? Row(
                            children: [
                              Text(
                                "${AppConstants.hello} ${homeCtrl.userName.value}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(width: 12),
                              MyProfileMenu(
                                  controller: homeCtrl), // User Profile Menu
                            ],
                          )
                        : GoogleSignInButton(controller: homeCtrl);
                  }),
                ],
              ),
            )
          ],
        ).paddingOnly(bottom: 12));
  }
}
