import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CodeEditorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(
                label: Text('Enter title for your snippet'),
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12.0)))),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
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
            SizedBox(height: 20),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Upload Output Image'),
                  style: ElevatedButton.styleFrom(),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Format'),
                  style: ElevatedButton.styleFrom(),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Save Snippet'),
                  style: ElevatedButton.styleFrom(),
                ),
              ],
            ),
          ],
        ),
    ));
  }
}