import 'package:flutter/material.dart';

class EllipsisTextWithHover extends StatelessWidget {
  final String text;

  const EllipsisTextWithHover({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Tooltip(
        message: text, // Full text to be shown on hover
        preferBelow: false, // Ensure tooltip appears above the text (optional)
        child: Container(
          constraints: const BoxConstraints(maxWidth: 200), // Set a max width to enforce ellipsis
          child: Text(text,
              overflow: TextOverflow.ellipsis, // Truncate text with ellipsis
              style: Theme.of(context).textTheme.bodyMedium),
        ),
      ),
    );
  }
}
