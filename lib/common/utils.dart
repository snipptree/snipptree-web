import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snippet/common/border_radius.dart';
import 'package:snippet/common/colors.dart';
import 'package:snippet/common/strings.dart';
import 'package:toastification/toastification.dart';

enum ToastType {
  info,
  error,
  warn,
  success,
}

class Util {
  Util._();

  static final Util _instance = Util._();

  factory Util() {
    return _instance;
  }

  // /*used to hide key board*/
  void hideKeyBoard(BuildContext mContext) {
    FocusScope.of(mContext).requestFocus(FocusNode());
  }

  /// Show Single Button dialog
  bool value = false;

  showOkDialog(String msg, {String? title, Function? onTapOk, Function? onClose}) async {
    await showDialog<void>(
      context: Get.context!,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.35), // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: title != null ? Text(title) : Container(),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.0))),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    Text(
                      msg,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.black, fontSize: 15),
                    )
                  ],
                ).paddingOnly(left: 16, top: 16, bottom: 8, right: 16),
                const Divider(
                  color: Colors.grey,
                ),
                Row(
                  children: [
                    Expanded(
                        child: SizedBox(
                      height: 40,
                      child: TextButton(
                          onPressed: () {
                            if (onTapOk != null) {
                              onTapOk();
                            }
                            Get.back();
                          },
                          child: const Text(
                            'OK',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          )),
                    )),
                  ],
                )
              ],
            ),
          ),
          titlePadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          actionsPadding: EdgeInsets.zero,
          actionsAlignment: MainAxisAlignment.center,
        );
      },
    ).then((value) {
      if (onClose != null) {
        onClose();
      }
    });
  }

  showToast({required String? title, required String? subTitle, required ToastType type}) {
    switch (type) {
      case ToastType.info:
        toastification.show(
          type: ToastificationType.info,
          showProgressBar: false,
          style: ToastificationStyle.flatColored,
          title: Text(title ?? ""),
          description: Text(subTitle ?? ""),
          alignment: Alignment.topRight,
          autoCloseDuration: const Duration(seconds: 4),
          primaryColor: const Color(0xFF4682B4),
          backgroundColor: const Color(0xffe8e8e8),
          borderRadius: AppBorderRadius.k12px,
          boxShadow: lowModeShadow,
        );
      case ToastType.error:
        toastification.show(
          type: ToastificationType.error,
          style: ToastificationStyle.flatColored,
          title: Text(title ?? ""),
          description: Text(subTitle ?? ""),
          alignment: Alignment.topRight,
          autoCloseDuration: const Duration(seconds: 4),
          primaryColor: const Color(0xffff0000),
          backgroundColor: const Color(0xffe8e8e8),
          borderRadius: AppBorderRadius.k12px,
          boxShadow: lowModeShadow,
        );
      case ToastType.warn:
        toastification.show(
          type: ToastificationType.warning,
          style: ToastificationStyle.flatColored,
          title: Text(title ?? ""),
          description: Text(subTitle ?? ""),
          alignment: Alignment.topRight,
          autoCloseDuration: const Duration(seconds: 4),
          primaryColor: const Color(0xffff7f50),
          backgroundColor: const Color(0xffe8e8e8),
          borderRadius: AppBorderRadius.k12px,
          boxShadow: lowModeShadow,
        );
      case ToastType.success:
        toastification.show(
          type: ToastificationType.success,
          style: ToastificationStyle.flatColored,
          title: Text(title ?? ""),
          description: Text(subTitle ?? ""),
          alignment: Alignment.topRight,
          autoCloseDuration: const Duration(seconds: 4),
          primaryColor: const Color(0xff199f19),
          backgroundColor: const Color(0xffe8e8e8),
          borderRadius: AppBorderRadius.k12px,
          boxShadow: lowModeShadow,
        );
      default:
        toastification.show(
          type: ToastificationType.info,
          showProgressBar: false,
          style: ToastificationStyle.flatColored,
          title: Text(title ?? ""),
          description: Text(subTitle ?? ""),
          alignment: Alignment.topRight,
          autoCloseDuration: const Duration(seconds: 4),
          primaryColor: const Color(0xFF4682B4),
          backgroundColor: const Color(0xffe8e8e8),
          borderRadius: AppBorderRadius.k12px,
          boxShadow: lowModeShadow,
        );
    }
  }
}
