import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:snippet/common/border_radius.dart';
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

  bool isAuthTokenValid(String token) {
    try {
      // Check if token is expired
      return JwtDecoder.isExpired(token);
    } catch (e) {
      return false;
    }
  }

  showToast(
      {required String? title,
      required String? subTitle,
      required ToastType type}) {
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
          showProgressBar: false,
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
          showProgressBar: false,
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
          showProgressBar: false,
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
