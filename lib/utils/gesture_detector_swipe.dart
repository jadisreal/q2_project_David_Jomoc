import 'package:flutter/material.dart';

typedef OnSwipeDirection = void Function(SwipeDirection direction);
enum SwipeDirection { left, right }

class SwipeDetector extends StatelessWidget {
  final Widget child;
  final OnSwipeDirection onSwipe;

  const SwipeDetector({
    Key? key,
    required this.child,
    required this.onSwipe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity == null) return;
        if (details.primaryVelocity! > 400) {
          onSwipe(SwipeDirection.left);
        } else if (details.primaryVelocity! < -400) {
          onSwipe(SwipeDirection.right);
        }
      },
      child: child,
    );
  }
}