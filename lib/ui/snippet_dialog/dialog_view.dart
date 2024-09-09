
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:snippet/ui/snippet_dialog/dialog_controller.dart';

class CodeEditorScreen extends StatelessWidget {
  CodeEditorScreen({super.key});
  final DialogViewController controller = DialogViewController();
  final QuillController quillController = QuillController.basic();
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: SingleChildScrollView(
      
              child: Column(children: [
                Form(
                 key: controller.titleSnippetFormKey,
                  child: Column(children: [
                    TextFormField(
                    decoration: const InputDecoration(
                        label: Text('Enter title for your snippet'),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)))),
                    controller: controller.titleTextController,
                      validator: (value) {
                      return controller.validateTitle(value);
                     },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    maxLines: 10,
                    decoration: const InputDecoration(
                        label: Text('Enter your snippet'),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)))),
                    controller: controller.snippetTextController,
                      validator: (value) {
                      return controller.validateSnipperCode(value);
                     },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ],),
                ),
                Obx(() => Row(
                      children: [
                        Row(
                          children: [
                            Radio<String>(
                              value: controller.conditions[0],
                              groupValue: controller.selectedCondition.value,
                              onChanged: (String? value) {
                                if (value != null) {
                                  controller.selectedCondition.value = value;
                                }
                              },
                            ),
                            const Text('Image Output')
                          ],
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Row(
                          children: [
                            Radio<String>(
                              value: controller.conditions[1],
                              groupValue: controller.selectedCondition.value,
                              onChanged: (String? value) {
                                if (value != null) {
                                  controller.selectedCondition.value = value;
                                }
                              },
                            ),
                          ],
                        ),
                        const Text('Text Output')
                      ],
                    )),
                    const SizedBox(height: 20,),
                Obx(() => controller.selectedCondition.value == 'Text'
                    ? Form(
                       key: controller.outPutFormKey,
                      child: TextFormField(
                          maxLines: 10,
                          decoration: const InputDecoration(
                              label: Text('Enter out put'),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.0)))),
                          controller: controller.outPutextController,
                           validator: (value) {
                      return controller.validateTextOutput(value);
                     },
                        ),
                    )
                    : Align(
                      alignment: Alignment.centerLeft,
                      child: Stack(
                          children: [
                            controller.imageFile.value.buffer.lengthInBytes > 0
                                ? Column(
                                    children: [
                                      AspectRatio(
                                              aspectRatio: 5,
                                              child: controller
                                                          .imageFile
                                                          .value
                                                          .buffer
                                                          .lengthInBytes >
                                                      0
                                                  ? Image.memory(controller
                                                      .imageFile.value)
                                                  : const SizedBox())
                                          .paddingAll(8.0),
                                      TextButton(
                                          onPressed: () {
                                            controller.pickImage();
                                          },
                                          child: const Text('Replace'))
                                    ],
                                  )
                                : InkWell(
                                    onTap: () {
                                      controller.pickImage();
                                    },
                                    child: Column(
                                      children: [
                                        Stack(
                                          children: [
                                             Container(
                                          height: 260,
                                          width: 360,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20)),
                                            border: Border.all(
                                              color: Colors
                                                  .grey, // red as border color
                                            ),
                                          ),
                                    
                                        ),
                                         Positioned.fill(
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Image.asset(
                                              height: 50,
                                              width: 50,
                                              'assets/images/upload.png'),
                                          ),
                                        )
,
                                    
                                          ],
                                        )
                                         ],
                                    ),
                                  ),
                          ],
                        ),
                    )),
                const SizedBox(
                  height: 30,
                ),
                 Obx(()=>Visibility(
                  visible: (controller.selectedCondition.value == 'Image' && controller.imageFile.value.buffer.lengthInBytes < 1),
                   child: Column(children: [
                    Text(controller.errorText.value,style: const TextStyle(color: Colors.red),),
                    const SizedBox(height: 20,)
                   ],),
                 )),
                SizedBox(
                  height: 55,
                  width: 360,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.uploadSnippet();
                    },
                    style: ElevatedButton.styleFrom(),
                    child: const Text('Save Snippet'),
                  ),
                )
              ]),
    ));
  }
}
