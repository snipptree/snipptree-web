import 'package:flutter/material.dart';
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
        padding:  EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                label: Text('Enter title for your snippet'),
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12.0)))),
                 controller: controller.titleTextController,
            ),

            QuillToolbar.simple(
configurations: QuillSimpleToolbarConfigurations (
  decoration: BoxDecoration(
    color: Colors.red,
     border: Border.all(
      color: Colors.white,
      width: 8,
    ),
    borderRadius: BorderRadius.circular(12),
  ),
  showDividers: false,
showFontFamily: false,
showFontSize: false,
showBoldButton: false,
showItalicButton: false,
showSmallButton: false,
showUnderLineButton: false,
showStrikeThrough: false,
showInlineCode: true,
showColorButton: false,
showBackgroundColorButton: false,
showClearFormat: false,
showAlignmentButtons: false,
showLeftAlignment: false,
showCenterAlignment: false,
showRightAlignment: false,
showJustifyAlignment: false,
showHeaderStyle: false,
showListNumbers: false,
showListBullets: false,
showListCheck: false,
showCodeBlock: false,
showQuote: false,
showIndent: false,
showLink: false,
showUndo: false,
showRedo: false,
showDirection: false,
showSearchButton: false,
showSubscript: false,
showSuperscript: false,
showClipboardCut: false,
showClipboardCopy: false,
showClipboardPaste: false,
controller: quillController,
sharedConfigurations: const QuillSharedConfigurations(
locale: Locale('de'),
), // QuillShared Configurations
), // QuillSimpleToolbarConfigurations
),
       


            Expanded(child: QuillEditor.basic(configurations: QuillEditorConfigurations(controller: quillController))),

//            QuillSimpleToolbar(
//   controller: quillController,
//   configurations: const QuillSimpleToolbarConfigurations(),
// ),
// Expanded(
//   child: QuillEditor.basic(
//     controller: _controller,
//     configurations: const QuillEditorConfigurations(),
//   ),
// )
            const SizedBox(height: 30,),
      
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '#include <iostream>\nusing namespace std;\n\nint main() {\n    cout << "GFG!";\n    return 0;\n}',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Courier', // Monospace font for code
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                     controller.submitSnippetData();
                  },
                  style: ElevatedButton.styleFrom(),
                  child: const Text('Upload Output Image'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(),
                  child: const Text('Format'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(),
                  child: const Text('Save Snippet'),
                ),
              ],
            ),
          ],
        ),
    ));
  }
}