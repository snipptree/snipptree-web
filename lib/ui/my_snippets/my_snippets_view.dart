import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snippet/common/app_constants.dart';
import 'package:snippet/common/border_radius.dart';
import 'package:snippet/common/colors.dart';
import 'package:snippet/common/image_constants.dart';
import 'package:snippet/common/routes.dart';
import 'package:snippet/ui/my_snippets/my_snippets_controller.dart';
import 'package:snippet/ui/search_result/view_snippet_dialog.dart';
import 'package:snippet/widgets/ellipsis_text_hover.dart';

class MySnippetsView extends StatefulWidget {
  const MySnippetsView({super.key});

  @override
  State<MySnippetsView> createState() => _MySnippetsViewState();
}

class _MySnippetsViewState extends State<MySnippetsView> {
  final MySnippetsController ctrl = MySnippetsController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ctrl.getMySnippets();
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
            const SizedBox(
              height: 50,
            ),
            Text(AppConstants.mySnippets,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 50),
            Expanded(
              child: Stack(
                children: [
                  Obx(() {
                    return (ctrl.mySnippetsResponse.value.data == null ||
                            ctrl.mySnippetsResponse.value.data?.isEmpty == null)
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppConstants.noSnippetsFound,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(height: 48),
                                SizedBox(
                                  height: 55,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 15),
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .inversePrimary,
                                    ),
                                    onPressed: () {
                                      Get.offAllNamed(Routes.homePage);
                                    },
                                    child: const Text(AppConstants.goHome),
                                  ),
                                )
                              ],
                            ),
                          )
                        : Obx(() => GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 16,
                                crossAxisCount: count,
                                    childAspectRatio: 16 /9,
                              ),
                              itemBuilder: (_, index) => InkWell(
                                onTap: () async {
                                  await Get.defaultDialog(
                                      backgroundColor: AppColors.dialogBgColor,
                                      barrierDismissible: true,
                                      title: '',
                                      titleStyle: const TextStyle(fontSize: 16),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 32, vertical: 16),
                                      titlePadding: EdgeInsets.zero,
                                      content: Expanded(
                                        child: SizedBox(
                                          width: 400,
                                          child: Stack(children: [
                                            ViewSnippetDialog(
                                              snippetData: ctrl
                                                  .mySnippetsResponse
                                                  .value
                                                  .data![index],
                                            ),
                                            Positioned(
                                                right: 0.0,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Get.back();
                                                  },
                                                  child: const Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: CircleAvatar(
                                                      radius: 14.0,
                                                      backgroundColor:
                                                          Colors.white,
                                                      child: Icon(Icons.close),
                                                    ),
                                                  ),
                                                ))
                                          ]),
                                        ),
                                      ));
                                },
                                child: Column(
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
                                            borderRadius:
                                                AppBorderRadius.k16px,
                                            child: Image.network(
                                              Uri.encodeFull(ctrl
                                                      .mySnippetsResponse
                                                      .value
                                                      .data![index]
                                                      .image ??
                                                  ImageConstants
                                                      .placeHolderImg),
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
                                              errorBuilder: (BuildContext
                                                      context,
                                                  Object error,
                                                  StackTrace? stackTrace) {
                                                return Image.network(
                                                  ImageConstants
                                                      .placeHolderImg,
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
                                        text: ctrl
                                                .mySnippetsResponse
                                                .value
                                                .data![index]
                                                .title
                                                ?.capitalize ??
                                            '',
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              itemCount:
                                  ctrl.mySnippetsResponse.value.data?.length ??
                                      0,
                            ));
                  }),
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
