import 'package:flutter/material.dart';
import 'package:snippet/common/app_constants.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({super.key,
    required this.mobile,
    required this.tab,
    required this.web});

  final Widget mobile;
  final Widget tab;
  final Widget web;

  @override
  Widget build(BuildContext context) {
    return  LayoutBuilder(
        builder: (context,dimens){
          if(dimens.maxWidth > AppConstants.tabDimens){
            return web;
          }else if(dimens.maxWidth > AppConstants.mobileDimens){
            return tab;
          }else{
            return mobile;
          }
        });
  }
}
