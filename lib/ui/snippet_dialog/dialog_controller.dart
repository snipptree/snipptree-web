import 'dart:html';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snippet/common/app_constants.dart';
import 'package:snippet/common/utils.dart';
import 'package:snippet/domain/models/snippet_request.dart';
import 'package:snippet/domain/models/snippet_response.dart';
import 'package:snippet/domain/usecases/snippet_usecase.dart';

class DialogViewController extends GetxController {
  var byTicketSelected = true.obs;
  var byServiceSelected = false.obs;

  final byTicketFormKey = GlobalKey<FormState>();
  final byServiceFormKey = GlobalKey<FormState>();

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

  String? validateServiceCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter service code';
    }
    return null;
  }



  String? validateTicketNo(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter ticket number';
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

  // Future<void> uploadSnippet() async {
  //   // Prepare the form data
  //   final html.FormData formData = html.FormData();
  //   if (selectedCondition.value == 'Image') {
  //     final blob = Blob(imageFile.value);
  //     formData.appendBlob('image', blob, fileName);
  //     formData.append('output_type', 'image');
  //   } else {
  //     formData.append('output_type', 'text');
  //     formData.append('output', outPutextController.text);
  //   }

  //   formData.append('title', titleTextController.text);
  //   formData.append('type', 'public');
  //   formData.append('snippet', snippetTextController.text);

  //   try {
  //     // Use html.HttpRequest to send the request
  //     final request = html.HttpRequest();
  //     request.open('POST', '${AppConstants.baseUrl}/snippet-service/snippet');
  //     request.onLoadEnd.listen((event) {
  //       if (request.status == 200) {
  //         Util().showToast(
  //             title: 'Snipper Submitted Successfully',
  //             subTitle: '',
  //             type: ToastType.error);
  //       } else {
  //         Util().showToast(
  //             title: 'Something wentwrong',
  //             subTitle: '',
  //             type: ToastType.error);
  //       }
  //     });
  //     print(formData.get('title'));
  //        print(formData.get('image'));
  //     request.send(formData);
  //   } catch (e) {
  //     Util().showToast(
  //         title: 'Something wentwrong', subTitle: '', type: ToastType.error);
  //   }
  // }

  Future<void> uploadSnippet() async {
  print('uploadSnippet() started');

  // Prepare the form data
  final html.FormData formData = html.FormData();
  
  if (selectedCondition.value == 'Image') {
    print('Condition: Image');
    final blob = Blob(imageFile.value);
    formData.appendBlob('image', blob, fileName);
    formData.append('output_type', 'image');
    print('Image file added to formData');
  } else {
    print('Condition: Text');
    formData.append('output_type', 'text');
    formData.append('output', outPutextController.text);
    print('Text output added to formData');
  }

  formData.append('title', titleTextController.text);
  formData.append('type', 'public');
  formData.append('snippet', snippetTextController.text);

  // Manually logging form data
  print('Form Data:');
  print('Title: ${formData.get('title')}');
  print('Type: ${formData.get('type')}');
  print('Snippet: ${formData.get('snippet')}');
  print('Output Type: ${formData.get('output_type')}');
  
  if (selectedCondition.value == 'Image') {
    print('Image: ${formData.get('image')}');
  } else {
    print('Output: ${formData.get('output')}');
  }

  try {
    // Use html.HttpRequest to send the request
    final request = html.HttpRequest();
    request.open('POST', '${AppConstants.baseUrl}/snippet-service/snippet');

    request.onLoadEnd.listen((event) {
      if (request.status == 200) {
        print('Request completed successfully with status 200');
        Util().showToast(
            title: 'Snippet Submitted Successfully',
            subTitle: '',
            type: ToastType.success);
      } else {
        print('Request failed with status ${request.status}');
        Util().showToast(
            title: 'Something went wrong',
            subTitle: '',
            type: ToastType.error);
      }
    });

    // Sending the request with form data
    request.send(formData);
    print('Request sent successfully with formData');
    
  } catch (e) {
    print('Error occurred: $e');
    Util().showToast(
        title: 'Something went wrong', subTitle: '', type: ToastType.error);
  }
  
  print('uploadSnippet() execution finished');
}

}
