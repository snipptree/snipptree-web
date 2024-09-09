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
        child:Column(
          children: [
             Row(
            children: [
              Expanded(
                flex: 7,
                child: Column(children: [
                  TextFormField(
                    decoration: const InputDecoration(
                        label: Text('Enter title for your snippet'),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)))),
                    controller: controller.titleTextController,
                  ),
                  SizedBox(height: 30,),
                 TextFormField(
                    maxLines: 10,
                    decoration: const InputDecoration(
                        label: Text('Enter your snippet'),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)))),
                    controller: controller.snippetTextController,
                  ),
                ],),
              ),
              SizedBox(width: 30,), 
              Expanded(
                flex: 3,
                child: Column(children: [
                   Column(
                    children: [
                     Text('Output Type:'),
                     const SizedBox(height: 30,),
                     Obx(() => RadioGroup.builder(
                          direction: Axis.horizontal,
                          groupValue: controller.selectedCondition.value,
                          horizontalAlignment: MainAxisAlignment.center,
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
                        )),
                        SizedBox(height: 20,)
                    ],
                   ),
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
                        width: 360,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                        border: Border.all(
                         color: Colors.grey,  // red as border color
                          ),
                                    ),
                                        child: Icon(Icons.upload_rounded,size: 70,),
                                      ),
                                      
                      ],),
                    ),
                    ],
                   )
                    )
                ],),
              )
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
           
          ], )
        ),
    ));
  }
}
