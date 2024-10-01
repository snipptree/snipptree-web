import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReusableElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final TextStyle? textStyle;

  const ReusableElevatedButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.backgroundColor,
    this.padding,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        backgroundColor:
            backgroundColor ?? Theme.of(context).colorScheme.inversePrimary,
      ),
      child: Text(
        buttonText,
        style: textStyle ?? const TextStyle(color: Colors.white),
      ),
    );
  }
}
