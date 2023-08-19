import 'package:agricultural_insurance_system/configs/palette.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math show sin, pi, sqrt;

class WaveAnimation extends StatefulWidget {
  final double size;
  final Color color;
  final Widget centerChild;
  final bool isAnimating;

  const WaveAnimation({
    this.size = 20.0,
    this.color = Palette.kPrimaryColor,
    required this.centerChild,
    Key? key,
    required this.isAnimating,
  }) : super(key: key);

  @override
  WaveAnimationState createState() => WaveAnimationState();
}

class WaveAnimationState extends State<WaveAnimation>
    with TickerProviderStateMixin {
  late AnimationController animCtr;
  bool isAnimationStarted = false;

  @override
  void initState() {
    super.initState();
    animCtr = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    if (widget.isAnimating) {
      animCtr.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    animCtr.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant WaveAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isAnimating != oldWidget.isAnimating) {
      if (widget.isAnimating) {
        animCtr.repeat(reverse: true);
      } else {
        animCtr.stop();
      }
    }
  }

  Widget getAnimatedWidget() {
    print(widget.size);
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.size),
          gradient: RadialGradient(
            colors: [
              widget.color,
              Color.lerp(widget.color, Colors.black, .05)!
            ],
          ),
        ),
        child: ScaleTransition(
          scale: Tween(begin: 0.95, end: 1.0).animate(
            CurvedAnimation(
              parent: animCtr,
              curve: CurveWave(),
            ),
          ),
          child: Container(
            width: widget.size * 0.5,
            height: widget.size * 0.5,
            margin: const EdgeInsets.all(6),
            child: widget.centerChild,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CirclePainter(animCtr, color: widget.color),
      child: SizedBox(
        width: widget.size * 1.6,
        height: widget.size * 1.6,
        child: getAnimatedWidget(),
      ),
    );
  }
}

class CurveWave extends Curve {
  @override
  double transform(double t) {
    if (t == 0 || t == 1) {
      return 0.01;
    }
    return math.sin(t * math.pi);
  }
}

class CirclePainter extends CustomPainter {
  final Animation<double> animation;
  final Color color;

  CirclePainter(this.animation, {required this.color})
      : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.shortestSide * 0.5;
    final progress = animation.value;

    final paint = Paint()
      ..color = color.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius * progress, paint);
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) {
    return color != oldDelegate.color;
  }
}
