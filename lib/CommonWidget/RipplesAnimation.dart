import 'dart:math' as math show sin, pi, sqrt;
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:spotme/utils/color.dart';

class Ripples extends StatefulWidget {
  const Ripples({
    required Key key,
    this.size = 180.0,
    this.color = AppColor.TextColorGray,
    required this.onPressed,
    required this.child,
  }) : super(key: key);

  final double size;
  final Color color;
  final Widget child;
  final VoidCallback onPressed;

  @override
  _RipplesState createState() => _RipplesState();
}

class _CirclePainter extends CustomPainter {
  final Color color;
  final Animation<double> _animation;

  _CirclePainter(
      this._animation, {
        required this.color,
      }) : super(repaint: _animation);



  void circle(Canvas canvas, Rect rect, double value) {
    final double opacity = (1.0 - (value / 4.0)).clamp(0.0, 1.0);
    final Color _color = color.withOpacity(opacity);

    final double size = rect.width / 2;
    final double area = size * size;
    final double radius = math.sqrt(area * value / 4);

    final Paint paint = Paint()..color = _color;
    canvas.drawCircle(rect.center, radius, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTRB(0.0, 0.0, size.width, size.height);

    for (int wave = 5; wave >= 0; wave--) {
      circle(canvas, rect, wave + _animation.value);
    }
  }

  @override
  bool shouldRepaint(_CirclePainter oldDelegate) => true;
}

class _RipplesState extends State<Ripples> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _button() {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.size),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: <Color>[
                widget.color,
                Color.lerp(widget.color, Colors.black, .05)!
              ],
            ),
          ),
          child: ScaleTransition(
            scale: Tween(begin: 0.95, end: 1.0).animate(
              CurvedAnimation(
                parent: _controller,
                curve: const _PulsateCurve(),
              ),
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CirclePainter(
        _controller,
        color: widget.color,
      ),
      child: SizedBox(
        width: widget.size * 2.125,
        height: widget.size * 2.125,
        child: _button(),
      ),
    );
  }
}

class _PulsateCurve extends Curve {
  const _PulsateCurve();

  @override
  double transform(double t) {
    if (t == 0 || t == 1) {
      return 0.01;
    }
    return math.sin(t * math.pi);
  }
}



//
// class CircleWaveAnimation extends StatefulWidget {
//   @override
//   _CircleWaveAnimationState createState() => _CircleWaveAnimationState();
// }
//
//
// class _CircleWaveAnimationState extends State<CircleWaveAnimation>  with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   double _circleRadius = 20.0;
//   int _numCircles = 5;
//
//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 2),
//     )..repeat();
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Circle Wave Animation')),
//       body: Center(
//         child: CustomPaint(
//           painter: CircleWavePainter(
//             animation: _animationController,
//             numCircles: _numCircles,
//             circleRadius: _circleRadius,
//           ),
//           child: Container(),
//         ),
//       ),
//     );
//   }
// }
//
// class CircleWavePainter extends CustomPainter {
//   final Animation<double> animation;
//   final int numCircles;
//   final double circleRadius;
//
//   CircleWavePainter({required this.animation, required this.numCircles, required this.circleRadius})
//       : super(repaint: animation);
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.blue
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 1.0;
//
//     for (int i = 0; i < numCircles; i++) {
//       final radius = circleRadius * (i + 1);
//       final offset = Offset(size.width / 2, size.height / 2);
//
//       final progress = animation.value * 360.0;
//       final startAngle = radians(progress);
//       final endAngle = radians(progress + 360.0);
//
//       canvas.drawArc(Rect.fromCircle(center: offset, radius: radius), startAngle,
//           endAngle, false, paint);
//     }
//   }
//
//   @override
//   bool shouldRepaint(CircleWavePainter oldDelegate) => true;
// }
//
