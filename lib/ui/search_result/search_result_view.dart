import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
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
          Column(children: [
             HeadingRow(
            ctrl: ctrl,
          ),
          Obx(
            () => Expanded(
              child: GridView.count(
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
         

          ],),
          Obx(() => ctrl.isLoading.value
              ? const CircularProgressIndicator()
              : const SizedBox())
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
              color: Colors.white,
              border: Border.all(color: Colors.black12),
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              )),
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
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Hero(
                tag: 'logo',
                child: Center(
                  child: Image.asset(
                    width: 100,
                    height: 100,
                    'assets/images/snipptree.png',
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Hero(
                tag: 'hero',
                child: Container(
                  width: 400,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.grey[700]!),
                  ),
                  child:  Material(
                    child: Obx(() {
                        return TextField(
                          
                          controller: TextEditingController(text: ctrl.searchKey.value),
                           decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            border: InputBorder.none,
                            hintText: 'Search for snippet',
                            contentPadding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                          ),
                          // controller: controller.byTicketTextController,
                          // validator: (value) {
                          //  // return controller.validateTicketNo(value);
                          // },
                        );
                      }
                    ),
                  ),
                ),
              ),
            ),
            const Expanded(flex: 1, child: SizedBox.shrink())
          ],
        ),
      ],
    );
  }
}

class GridChild extends StatelessWidget {
  final SearchResponseList snippet;
  const GridChild({required this.snippet, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black12),
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              'assets/images/snipptree.png',
              fit: BoxFit.contain,
              height: 0.12 * Get.size.height,
            ),
            Flexible(
              child: Text(
                snippet.title ?? '',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(fontSize: 12),
              ).paddingAll(8),
            )
          ],
        ),
      ),
    );
  }
}
