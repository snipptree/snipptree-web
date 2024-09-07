import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:snippet/common/border_radius.dart';
import 'package:snippet/common/routes.dart';
import 'package:snippet/domain/models/search_response_list.dart';
import 'package:snippet/ui/search_result/search_result_controller.dart';

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
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 42),
            child: Column(
              children: [
                HeadingRow(ctrl: ctrl),
                Obx(
                  () => Expanded(
                    child: GridView.count(
                      childAspectRatio: 400 / 200,
                      shrinkWrap: true,
                      crossAxisCount: 4,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 12,
                      primary: false,
                      children: ctrl.searchResponse.value.data != null
                          ? ctrl.searchResponse.value.data!
                              .map((e) => GridChild(
                                    snippet: e,
                                  ))
                              .toList()
                          : [],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Obx(() => ctrl.isLoading.value ? const Center(child: CircularProgressIndicator()) : const SizedBox())
        ],
      ),
    );
  }

  List<Widget> getGridChild(BuildContext context) {
    return ctrl.gridViewItems.map((item) {
      return GestureDetector(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                item["image"]!,
                fit: BoxFit.contain,
                height: 0.12 * Get.size.height,
              ),
              Flexible(
                child: Text(
                  item["title"]!,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(fontSize: 12),
                ).paddingAll(8),
              )
            ],
          ),
        ),
      );
    }).toList();
  }
}

class HeadingRow extends StatelessWidget {
  final SearchResultController ctrl;

  const HeadingRow({required this.ctrl, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: InkWell(
            onTap: () {
              Get.offAllNamed(Routes.homePage);
            },
            child: Hero(
              tag: 'logo',
              child: Center(
                child: Image.asset(
                  width: 200,
                  height: 200,
                  'assets/images/snipptree.png',
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
              padding: const EdgeInsets.only(top: 24.0),
              child: Container(
                width: 400,
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
                        await ctrl.getSnippets(searchQuery: ctrl.searchKey.value);
                      }
                    },
                    child: TextField(
                      textInputAction: TextInputAction.search,
                      controller: ctrl.serpController,
                      onChanged: (val) {
                        ctrl.searchKey.value = val;
                      },
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                        hintText: 'Search for snippet',
                        contentPadding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const Expanded(flex: 1, child: SizedBox.shrink())
      ],
    );
  }
}

class GridChild extends StatelessWidget {
  final SearchResponseList snippet;

  const GridChild({required this.snippet, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: InkWell(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            color: Colors.green,
            border: Border.all(color: Colors.black12),
            borderRadius: AppBorderRadius.k8px,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 12),
              Text(
                snippet.title ?? "",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text(
                snippet.snippet ?? '',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: Theme.of(context).textTheme.titleLarge,
              ).paddingAll(8)
            ],
          ),
        ),
      ),
    );
  }
}
