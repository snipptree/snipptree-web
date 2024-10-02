import 'package:animated_hint_textfield/animated_hint_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:snippet/common/app_constants.dart';
import 'package:snippet/common/border_radius.dart';
import 'package:snippet/common/colors.dart';
import 'package:snippet/common/image_constants.dart';
import 'package:snippet/common/responsive_layout.dart';
import 'package:snippet/common/routes.dart';
import 'package:snippet/common/utils.dart';
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
            HeadingRow(ctrl: ctrl),
            Expanded(
              child: Stack(
                children: [
                  Obx(() => GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 16,
                          crossAxisCount: count,
                          childAspectRatio: 16 / 9,
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
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  Expanded(
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black12),
                                        borderRadius: AppBorderRadius.k8px,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 32, vertical: 8),
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
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: EllipsisTextWithHover(
                                      text: ctrl.searchResponse.value
                                              .data![index].title?.capitalize ??
                                          '',
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              ),
                              Positioned(
                                bottom: 35,
                                right: 90,
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.share,
                                      color: Colors.grey,
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
                              ),
                            ],
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

  const HeadingRow({required this.ctrl, super.key});

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
              ).paddingOnly(top: 10),
            ),
            Hero(
              tag: 'search_bar',
              child: Container(
                width: 300,
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
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
          ],
        ).paddingOnly(bottom: 16),
        tab: Row(
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
            const SizedBox(width: 60),
            Expanded(
              flex: 3,
              child: Hero(
                tag: 'search_bar',
                child: Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Container(
                    width: 400,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
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
            ),
            const Expanded(flex: 1, child: SizedBox.shrink())
          ],
        ).paddingOnly(bottom: 16),
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
            const SizedBox(width: 60),
            Expanded(
              flex: 3,
              child: Hero(
                tag: 'search_bar',
                child: Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Container(
                    width: 400,
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
            ),
            const Expanded(flex: 1, child: SizedBox.shrink())
          ],
        ).paddingOnly(bottom: 16));
  }
}
