/*
*  util.dart
*
*  Created by Kiran Kumar Y on 13/8/21 12:33 PM
*  Copyright ©️ 2021 abhibus.com. All rights reserved.
*/



import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Util {
  Util._();

  static final Util _instance = Util._();

  factory Util() {
    return _instance;
  }

  // /*used to hide key board*/
  // void hideKeyBoard(BuildContext mContext) {
  //   FocusScope.of(mContext).requestFocus(FocusNode());
  // }

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
                      style:const TextStyle(color: Colors.black, fontSize:15),
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
                            style: TextStyle(color: Colors.black, fontSize:16),
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

}
