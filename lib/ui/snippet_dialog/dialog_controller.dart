import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snippet/common/utils.dart';
import 'package:snippet/domain/models/snippet_request.dart';
import 'package:snippet/domain/models/snippet_response.dart';
import 'package:snippet/domain/usecases/snippet_usecase.dart';


class DialogViewController extends GetxController{
  var byTicketSelected = true.obs;
  var byServiceSelected = false.obs;

  final byTicketFormKey = GlobalKey<FormState>();
  final byServiceFormKey = GlobalKey<FormState>();

  TextEditingController titleTextController = TextEditingController();
  TextEditingController snippetTextController = TextEditingController();

   var imageFile = Uint8List(0).obs;
   var fileName = '';

  var deptDate = 'Departure Date'.obs;
  var errorText = ''.obs;
  var isLoading = false.obs;
  var isDataLoaded = false.obs;

  var snippetResponse = SnippetResponse().obs;

   void resetData(){
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

  // void submitTicketData() {
  //   final isValid = byTicketFormKey.currentState?.validate();
  //   if (isValid == true) {
  //     getServiceDetails();
  //   }
  // }

  String? validateTicketNo(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter ticket number';
    } 
    return null;
  }


  // Future<void> formatTheDate(DateTime date) async{
  //   final desiredFormat = DateFormat('dd-MMM-yyyy');
  //   deptDate.value =  desiredFormat.format(date);
  // }

  // void submitServiceData() {

  //   final isValid = byServiceFormKey.currentState?.validate();
  //   if (isValid == true && deptDate.value !='Departure Date') {
  //     getServiceDetails();
  //   }else{
  //     errorText.value = 'Please select date';
  //     return;

  //   }
  // }

  Future<void> submitSnippetData() async {
    isLoading.value = true;
    isDataLoaded.value = false;
    snippetResponse.value = SnippetResponse();
    SnippetRequest ticketStatusReq = getServiceStatusRequest();
    final response = await SnippetUseCase().submitSnippetData(ticketStatusReq);
    response.fold((l) async {
      isLoading.value = false;
      Util().showToast(title:l.message??'Something wentwrong', subTitle: '',type: ToastType.error);
    }, (r) async {
      if(r.error == false){
        isDataLoaded.value = true;
        snippetResponse.value = r;
      }else{
      Util().showToast(title:r.message??'Something wentwrong', subTitle: '',type: ToastType.error);
      }
      isLoading.value = false;

    });
  }


  SnippetRequest getServiceStatusRequest() {

    var req =  SnippetRequest(
       title: 'flutter test',
       type: 'public',
       snippet: 'sample code',
       output: '1234'
    );
    // if(byServiceTextController.text.isNotEmpty) {
    //   req.serviceCode = byServiceTextController.text.removeAllWhitespace;
    // }
    // if (byTicketTextController.text.isNotEmpty) {
    //   req.bookingId =  byTicketTextController.text.removeAllWhitespace;
    // }
    // if (deptDate.isNotEmpty) {
    //   req.journeyDate =  deptDate.value;
    // }
    return req;
  }

pickImage() async{
FilePickerResult? resultFilePicker = await FilePicker.platform.pickFiles(
type: FileType.image,
allowMultiple: false,
);
if (resultFilePicker != null)
{
imageFile.value = resultFilePicker.files.first.bytes!;
fileName = resultFilePicker.files.first.name;
}

}
}