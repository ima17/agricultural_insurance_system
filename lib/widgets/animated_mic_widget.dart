import 'package:flutter/material.dart';

class AnimatedMicWidget extends StatelessWidget {
  const AnimatedMicWidget({
    super.key,
    required AnimationController animationController,
  }) : _animationController = animationController;

  final AnimationController _animationController;

  @override
  Widget build(BuildContext context) {
    final double backgroundContainerSize = 200.0;
    final double iconContainerSize = 150.0;
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            RotationTransition(
              turns: _animationController,
              child: Container(
                width: backgroundContainerSize,
                height: backgroundContainerSize,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.greenAccent,
                      Colors.blue,
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Container(
              width: iconContainerSize,
              height: iconContainerSize,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.mic,
                  size: 80,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
