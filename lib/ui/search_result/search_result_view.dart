import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
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
    int count = MediaQuery.of(context).size.width ~/ 250;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              HeadingRow(ctrl: ctrl),
              Obx(() => Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: count),
                      itemBuilder: (_, index) => Column(
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  border: Border.all(color: Colors.black12),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(8),
                                  )),
                              child: Image.network(
                                Uri.encodeFull(ctrl.searchResponse.value.data![index].image ??
                                    "https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                                fit: BoxFit.fill,
                                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                          : null,
                                    ),
                                  );
                                },
                                errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                  return Image.network(
                                    "https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                                    fit: BoxFit.fill,
                                  );
                                },
                              ),
                            ),
                          ),
                          Text(
                            ctrl.searchResponse.value.data![index].title ?? '',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: const TextStyle(fontSize: 12),
                          ).paddingAll(8)
                        ],
                      ),
                      itemCount: ctrl.searchResponse.value.data?.length ?? 0,
                    ),
                  ))
            ],
          ),
          Obx(() => ctrl.isLoading.value ? const Center(child: CircularProgressIndicator()) : const SizedBox())
        ],
      ),
    );
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
          child: GestureDetector(
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


