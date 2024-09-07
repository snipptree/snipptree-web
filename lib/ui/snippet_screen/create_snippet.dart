import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:snippet/common/routes.dart';
import 'package:snippet/ui/search_result/search_result_controller.dart';
import 'package:snippet/ui/search_result/search_result_view.dart';
import 'package:snippet/ui/snippet_screen/snipper_controller.dart';

class CreateSnippet extends StatelessWidget {
   CreateSnippet({super.key});

   final SnippetController ctrl = SnippetController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Google Doodle placeholder
            Hero(
              tag: 'logo',
              child: Center(
                child: Image.asset(
              'assets/images/snipptree.png',
                          ),
              ),
            ),
            const SizedBox(height: 30),
            // Search Bar
            Hero(
              tag: 'hero',
              child: Container(
                width: 600,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.grey[700]!),
                ),
                child:  Material(
                  child: TextField(
                    
                       controller: ctrl.searchSnippetController,
                                
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          border: InputBorder.none,
                          hintText: 'Search for snippet',
                          contentPadding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                        
                        ),
                       // controller: controller.byTicketTextController,
                      //  validator: (value) {
                         // return controller.validateTicketNo(value);
                       // },
                      ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            // Google Search and I'm Feeling Lucky buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                 Get.toNamed(Routes.serp,
                    parameters: {"searchKey": ctrl.searchSnippetController.text});

                  },
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
  
     final OutlineInputBorder customBorder = OutlineInputBorder(
     borderSide: const BorderSide(
       color: Colors.grey,
       width: 0.5, // Set the border width here
     ),
     borderRadius: BorderRadius.circular(4.0), // Set the border radius here
   );
}



