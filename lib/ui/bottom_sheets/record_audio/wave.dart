import 'dart:math' as math;
import 'package:flutter/material.dart';
import '/ui/common/app_colors.dart';

class CircleWave extends StatefulWidget {
  const CircleWave({super.key});

  @override
  CircleWaveState createState() => CircleWaveState();
}

class CircleWaveState extends State<CircleWave>
    with SingleTickerProviderStateMixin {
  double waveRadius = 0.0;
  double waveGap = 10;
  Animation<double>? _animation;
  AnimationController? controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);

    controller!.forward();

    controller!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller!.reset();
      } else if (status == AnimationStatus.dismissed) {
        controller!.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _animation = Tween(begin: 0.0, end: waveGap).animate(controller!)
      ..addListener(() {
        setState(() {
          waveRadius = _animation!.value;
        });
      });

    return Scaffold(
      backgroundColor: transparent,
      body: Container(
        alignment: Alignment.center,
        child: CustomPaint(
          size: const Size(60, 60),
          painter: CircleWavePainter(waveRadius),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }
}

class CircleWavePainter extends CustomPainter {
  final double waveRadius;
  Paint? wavePaint;
  CircleWavePainter(this.waveRadius) {
    wavePaint = Paint()
      ..color = secondaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..isAntiAlias = true;
  }
  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double maxRadius = hypot(centerX, centerY);

    var currentRadius = waveRadius;
    while (currentRadius < maxRadius) {
      canvas.drawCircle(Offset(centerX, centerY), currentRadius, wavePaint!);
      currentRadius += 10;
    }
  }

  @override
  bool shouldRepaint(CircleWavePainter oldDelegate) {
    return oldDelegate.waveRadius != waveRadius;
  }

  double hypot(double x, double y) {
    return math.sqrt(x * x + y * y);
  }
}
