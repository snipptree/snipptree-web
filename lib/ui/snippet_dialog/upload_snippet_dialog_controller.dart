import 'dart:html' as html;
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snippet/common/app_constants.dart';
import 'package:snippet/common/shared_pref.dart';
import 'package:snippet/common/utils.dart';
import 'package:snippet/domain/models/base_response.dart';

class UploadSnippetDialogController extends GetxController {
  var byTicketSelected = true.obs;
  var byServiceSelected = false.obs;

  final outPutFormKey = GlobalKey<FormState>();
  final titleSnippetFormKey = GlobalKey<FormState>();

  TextEditingController titleTextController = TextEditingController();
  TextEditingController snippetTextController = TextEditingController();
  TextEditingController outputTextController = TextEditingController();

  var imageFile = Uint8List(0).obs;
  var fileName = '';

  var errorText = ''.obs;
  var isLoading = false.obs;

  final conditions = ['Image', 'Text'];
  var selectedCondition = 'Image'.obs;

  var privateSnippet = false.obs;

  var snippetResponse = BaseResponse().obs;

  String? validateTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the title';
    }
    return null;
  }

  String? validateSnippetCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the snippet code';
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
    try {
      FilePickerResult? resultFilePicker = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );
      if (resultFilePicker != null) {
        imageFile.value = resultFilePicker.files.first.bytes!;
        bool isValid = _isValidImageFile();
        if (isValid) {
          fileName = resultFilePicker.files.first.name;
        } else {
          imageFile.value = Uint8List(0);
          Util().showToast(
              title:
                  'Invalid image format. Please select a PNG, JPEG, or GIF image.',
              subTitle: '',
              type: ToastType.warn);
        }
      }
    } catch (e) {
      imageFile.value = Uint8List(0);
      Util().showToast(
          title: 'Invalid image',
          subTitle: 'Please upload a valid image.',
          type: ToastType.error);
    }
  }

  Future<void> uploadSnippet() async {
    // Validate the form.
    final titleSnippetIsValid = titleSnippetFormKey.currentState?.validate();
    var outPutIsValid = false;

    if (selectedCondition.value == 'Text') {
      outPutIsValid = outPutFormKey.currentState?.validate() ?? false;
    } else {
      // Validate if an image is selected and has valid bytes.
      if (imageFile.value.buffer.lengthInBytes > 0) {
        // Check if the image is a valid format (PNG, JPEG, GIF).
        final isValidImage = _isValidImageFile();
        if (!isValidImage) {
          outPutIsValid = false;
          Util().showToast(
              title:
                  'Invalid image format. Please select a PNG, JPEG, or GIF image.',
              subTitle: '',
              type: ToastType.warn);
        } else {
          outPutIsValid = true;
        }
      } else {
        outPutIsValid = false;
        errorText.value = 'Please select an image.';
      }
    }

    // Proceed if validation succeeds.
    if (titleSnippetIsValid == true && outPutIsValid == true) {
      try {
        // Prepare form data.
        final html.FormData formData = html.FormData();

        if (selectedCondition.value == 'Image') {
          // Detect the MIME type dynamically based on the image file.
          final imageMimeType = _detectMimeType(imageFile.value);

          // Create a Blob with the detected MIME type.
          final blob = html.Blob([imageFile.value], imageMimeType);
          formData.appendBlob('image', blob, fileName);
          formData.append('output_type', 'image');
        } else {
          formData.append('output_type', 'text');
          formData.append('output', outputTextController.text);
        }

        formData.append('title', titleTextController.text);
        if (privateSnippet.value) {
          formData.append('type', 'private');
        } else {
          formData.append('type', 'public');
        }

        formData.append('snippet', snippetTextController.text);

        // Create an HttpRequest and configure it.
        final request = html.HttpRequest();
        request.open('POST', '${AppConstants.baseUrl}snippet-service/snippet');
        request.setRequestHeader(
            "Authorization", 'Bearer ${SharedPrefs().getJwtToken()}');

        // Handle the response.
        request.onLoadEnd.listen((event) {
          if (request.status == 200) {
            Get.back();
            Util().showToast(
                title: 'Snippet Submitted Successfully',
                subTitle: '',
                type: ToastType.success);
          } else {
            Util().showToast(
                title: 'Something went wrong',
                subTitle: request.responseText,
                type: ToastType.error);
          }
        });

        // Send the form data with the request.
        request.send(formData);
      } catch (e) {
        Util().showToast(
            title: 'Something went wrong',
            subTitle: e.toString(),
            type: ToastType.error);
      }
    }
  }

// Helper function to check if the image file is valid.
  bool _isValidImageFile() {
    final mimeType = _detectMimeType(imageFile.value);
    return mimeType == 'image/png' ||
        mimeType == 'image/jpeg' ||
        mimeType == 'image/gif';
  }

// Helper function to detect the MIME type of an image.
  String _detectMimeType(Uint8List imageData) {
    // Common MIME types for image formats based on the first few bytes (magic numbers).
    if (imageData.length >= 4) {
      final headerBytes = imageData.sublist(0, 4);
      // PNG signature: 89 50 4E 47
      if (headerBytes[0] == 0x89 &&
          headerBytes[1] == 0x50 &&
          headerBytes[2] == 0x4E &&
          headerBytes[3] == 0x47) {
        return 'image/png';
      }
      // JPEG signature: FF D8 FF
      else if (headerBytes[0] == 0xFF && headerBytes[1] == 0xD8) {
        return 'image/jpeg';
      }
      // GIF signature: 47 49 46 38
      else if (headerBytes[0] == 0x47 &&
          headerBytes[1] == 0x49 &&
          headerBytes[2] == 0x46 &&
          headerBytes[3] == 0x38) {
        return 'image/gif';
      }
    }
    return 'unknown';
  }
}
