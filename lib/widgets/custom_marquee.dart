import 'package:flutter/material.dart';

class CustomMarquee extends StatefulWidget {
  final String text;

  const CustomMarquee({super.key, required this.text});

  @override
  _CustomMarqueeState createState() => _CustomMarqueeState();
}

class _CustomMarqueeState extends State<CustomMarquee> with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _animationController;
  late double textWidth;
  final double spaceBetween = 120; // Spacing between loops
  final double velocity = 60; // Pixels per second

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startScrolling();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _startScrolling() {
    // Measure the text width
    final textSize = _measureTextSize(widget.text, const TextStyle(fontSize: 14));
    textWidth = textSize.width;

    // Calculate the total distance to scroll (text width + space)
    final scrollDistance = textWidth + spaceBetween;

    // Create animation controller for infinite scroll
    _animationController = AnimationController(
      duration: Duration(milliseconds: (scrollDistance / velocity * 1000).round()),
      vsync: this,
    );

    // Repeat the scroll animation indefinitely
    _animationController.repeat();

    // Animate the scroll position using the controller
    _animationController.addListener(() {
      final position = _animationController.value * scrollDistance;
      _scrollController.jumpTo(position % scrollDistance);
    });
  }

  Size _measureTextSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Row(
            children: [
              Text(
                widget.text,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: spaceBetween), // Space between repeated text
            ],
          );
        },
        itemCount: 2, // We loop the text twice for continuous scrolling
      ),
    );
  }
}
