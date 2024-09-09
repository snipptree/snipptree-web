import 'dart:html';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snippet/common/app_constants.dart';
import 'package:snippet/common/utils.dart';
import 'package:snippet/domain/models/snippet_response.dart';

class DialogViewController extends GetxController {
  var byTicketSelected = true.obs;
  var byServiceSelected = false.obs;

  final outPutFormKey = GlobalKey<FormState>();
  final titleSnippetFormKey = GlobalKey<FormState>();

  TextEditingController titleTextController = TextEditingController();
  TextEditingController snippetTextController = TextEditingController();
  TextEditingController outPutextController = TextEditingController();

  var imageFile = Uint8List(0).obs;
  var fileName = '';

  var deptDate = 'Departure Date'.obs;
  var errorText = ''.obs;
  var isLoading = false.obs;
  var isDataLoaded = false.obs;

  final conditions = ['Image', 'Text'];
  var selectedCondition = 'Image'.obs;

  var snippetResponse = SnippetResponse().obs;

  void resetData() {
    deptDate.value = 'Departure Date';
    titleTextController.text = '';
    snippetTextController.text = '';
  }

 



  String? validateTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the title';
    }
    return null;
  }

 String? validateSnipperCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the snipper code';
    }
    return null;
  }

  String? validateTextOutput(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the output';
    }
    return null;
  }

 

  pickImage() async {
    FilePickerResult? resultFilePicker = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    if (resultFilePicker != null) {
      imageFile.value = resultFilePicker.files.first.bytes!;
      fileName = resultFilePicker.files.first.name;
    }
  }



  Future<void> uploadSnippet() async {

      final titleSnippetIsValid = titleSnippetFormKey.currentState?.validate();
      var outPutIsValid = false;
      if(selectedCondition.value == 'Text'){
         outPutIsValid = outPutFormKey.currentState?.validate()??false;
      }else{
        if(imageFile.value.buffer.lengthInBytes > 0){
          outPutIsValid = true;
        }else{
          outPutIsValid = false;
           errorText.value = 'Please select the image';
        }
      }

    if (titleSnippetIsValid == true && outPutIsValid == true ) {
    

  // Prepare the form data
  final html.FormData formData = html.FormData();
  
  if (selectedCondition.value == 'Image') {

    final blob = Blob(imageFile.value);
    formData.appendBlob('image', blob, fileName);
    formData.append('output_type', 'image');

  } else {

    formData.append('output_type', 'text');
    formData.append('output', outPutextController.text);

  }

  formData.append('title', titleTextController.text);
  formData.append('type', 'public');
  formData.append('snippet', snippetTextController.text);


  try {
    // Use html.HttpRequest to send the request
    final request = html.HttpRequest();
    request.open('POST', '${AppConstants.baseUrl}/snippet-service/snippet');

    request.onLoadEnd.listen((event) {
      if (request.status == 200) {

        Util().showToast(
            title: 'Snippet Submitted Successfully',
            subTitle: '',
            type: ToastType.success);
      } else {

        Util().showToast(
            title: 'Something went wrong',
            subTitle: '',
            type: ToastType.error);
      }
    });

    // Sending the request with form data
    request.send(formData);

    
  } catch (e) {

    Util().showToast(
        title: 'Something went wrong', subTitle: '', type: ToastType.error);
  }
  
    }
}

}
