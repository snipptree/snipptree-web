import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snippet/common/utils.dart';
import 'package:snippet/domain/models/search_response.dart';
import 'package:snippet/domain/models/snippet_request.dart';
import 'package:snippet/domain/models/snippet_response.dart';
import 'package:snippet/domain/usecases/snippet_usecase.dart';


class SnippetController extends GetxController{
  var byTicketSelected = true.obs;
  var byServiceSelected = false.obs;

  final byTicketFormKey = GlobalKey<FormState>();
  final byServiceFormKey = GlobalKey<FormState>();

  TextEditingController searchSnippetController = TextEditingController();
  TextEditingController snippetTextController = TextEditingController();


  var deptDate = 'Departure Date'.obs;
  var errorText = ''.obs;
  var isLoading = false.obs;
  var isDataLoaded = false.obs;

  var searchResponse = SearchResponse().obs;

   void resetData(){
     deptDate.value = 'Departure Date';
     searchSnippetController.text = '';
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

}