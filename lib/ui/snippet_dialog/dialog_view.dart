import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:snippet/ui/snippet_dialog/dialog_controller.dart';

class CodeEditorScreen extends StatelessWidget {

   CodeEditorScreen({super.key});
    final DialogViewController controller = DialogViewController();
    final QuillController quillController = QuillController.basic();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:  const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                 Expanded(
                   child: TextFormField(
                                 decoration: const InputDecoration(
                                   label: Text('Enter title for your snippet'),
                                   border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12.0)))),
                   controller: controller.titleTextController,
                               ),
                 ),
                  Expanded(
                   child:   ElevatedButton(
                  onPressed: () {
                     controller.submitSnippetData();
                  },
                  style: ElevatedButton.styleFrom(),
                  child: const Text('Upload Image'),
                ),
                 ),
                 
              ],
            ),
            const SizedBox(height: 30,),
            Row(
              children: [
                 Expanded(
                  flex: 7,
                   child: TextFormField(
                                   maxLines: 10,
                                 decoration: const InputDecoration(
                                   label: Text('Enter your snippet'),
                                   border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12.0)))),
                   controller: controller.snippetTextController,
                               ),
                 ),
            const Expanded(
              flex: 3,
              child: SizedBox())

              ],
            ), 
            const SizedBox(height: 30,),            
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(),
                child: const Text('Save Snippet'),
              ),
            ),
          ],
        ),
    ));
  }
}