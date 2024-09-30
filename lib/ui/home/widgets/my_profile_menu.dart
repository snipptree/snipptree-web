import 'package:flutter/material.dart';
import 'package:snippet/common/app_constants.dart';
import 'package:snippet/ui/home/home_controller.dart';

class MyProfileMenu extends StatelessWidget {
  final HomeController controller;

  const MyProfileMenu({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      icon: const Icon(Icons.account_circle_outlined),
      onSelected: (value) {
        switch (value) {
          case 1:
            controller.handleLogout();
            break;
        }
      },
      itemBuilder: (BuildContext context) => [
        const PopupMenuItem(
          value: 1,
          child: Text(AppConstants.logOut),
        ),
      ],
    );
  }
}
