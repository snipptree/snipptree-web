import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:snippet/ui/snippet_dialog/dialog_controller.dart';

class CodeEditorScreen extends StatelessWidget {
  CodeEditorScreen({super.key});
  final DialogViewController controller = DialogViewController();
  final QuillController quillController = QuillController.basic();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 6,
                  child: TextFormField(
                    decoration: const InputDecoration(
                        label: Text('Enter title for your snippet'),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)))),
                    controller: controller.titleTextController,
                  ),
                ),
                const Expanded(
                  flex:2,child: Padding(
                    padding: EdgeInsets.only(left: 16,right: 16),
                    child: Text('Output Type:'),
                  )),
                 Expanded(
                  flex: 2,
                    child: Obx(() => RadioGroup.builder(
                          direction: Axis.horizontal,
                          groupValue: controller.selectedCondition.value,
                          horizontalAlignment: MainAxisAlignment.spaceEvenly,
                          onChanged: (value) {
                            controller.selectedCondition.value =
                                value ?? 'Image';
                            controller.isDataLoaded.value = false;
                          //  controller.resetData();
                          },
                          items: controller.conditions,
                          itemBuilder: (item) => RadioButtonBuilder(
                            item,
                          ),
                        ))),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(
                  flex: 7,
                  child: TextFormField(
                    maxLines: 10,
                    decoration: const InputDecoration(
                        label: Text('Enter your snippet'),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)))),
                    controller: controller.snippetTextController,
                  ),
                ),
                const Expanded(flex: 1,child: SizedBox()),
                Expanded(
                    flex: 3,
                   child:
                  Obx(()=> controller.selectedCondition.value == 'Text'? 
                   TextFormField(
                    maxLines: 10,
                    decoration: const InputDecoration(
                        label: Text('Enter out put'),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)))),
                    controller: controller.outPutextController,
                  ):
                   Stack(
                    children: [
                      controller.imageFile.value.buffer
                                          .lengthInBytes > 0?
                                         Column(children: [
                                           AspectRatio(
                              aspectRatio: 16 / 9,
                              child: controller.imageFile.value.buffer
                                          .lengthInBytes > 0
                                  ? Image.memory(controller.imageFile.value)
                                  : const SizedBox())
                          .paddingAll(8.0),
                           TextButton(onPressed: (){
                                         controller.pickImage();
                                      }, child: const Text('Replace'))
                                         ],):
                    
                    InkWell(
                      onTap: (){
                        controller.pickImage();
                      },
                      child: Column(children: [
                        Container(
                        height: 260,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                        border: Border.all(
                         color: Colors.grey,  // red as border color
                          ),
                                    ),
                                        child: Image.asset(
                      'assets/images/snipptree.png',fit: BoxFit.fill ,
                                        ),
                                      ),
                                      
                      ],),
                    ),
                    ],
                   )
                    ))
                
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  controller.uploadSnippet();
                },
                style: ElevatedButton.styleFrom(),
                child: const Text('Save Snippet'),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
