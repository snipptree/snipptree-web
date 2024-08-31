import 'package:flutter/material.dart';

class CreateSnippet extends StatelessWidget {
  const CreateSnippet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Google Doodle placeholder
            Center(
              child: Image.asset(
            'assets/images/snipptree.png',
                        ),
            ),
            const SizedBox(height: 30),
            // Search Bar
            Container(
              width: 600,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.grey[700]!),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.grey[600]),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Search Google or type a URL',
                      style: TextStyle(color: Colors.grey[600], fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            // Google Search and I'm Feeling Lucky buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: const Text(
                    'Search Snippet',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: const Text(
                    "Upload Snippet",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ));
  }
}



