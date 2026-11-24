import 'package:flutter/material.dart';

class CatMascot extends StatelessWidget {
  const CatMascot({
    super.key,
    this.size = 190,
    this.expression = CatExpression.happy,
    this.withParcel = false,
  });

  final double size;
  final CatExpression expression;
  final bool withParcel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size * .92,
      child: CustomPaint(
        painter: _CatPainter(expression: expression, withParcel: withParcel),
      ),
    );
  }
}

enum CatExpression { happy, curious, excited, proud }

class _CatPainter extends CustomPainter {
  _CatPainter({required this.expression, required this.withParcel});

  final CatExpression expression;
  final bool withParcel;

  @override
  void paint(Canvas canvas, Size size) {
    final sx = size.width / 220;
    final sy = size.height / 202;
    canvas.save();
    canvas.scale(sx, sy);

    final shadow = Paint()..color = const Color(0x1F5B2542);
    canvas.drawOval(const Rect.fromLTWH(35, 178, 150, 15), shadow);

    final white = Paint()..color = const Color(0xFFFFFEFC);
    final outline = Paint()
      ..color = const Color(0xFF7D5266)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Tail
    final tail = Path()
      ..moveTo(165, 145)
      ..cubicTo(205, 150, 202, 105, 178, 112)
      ..cubicTo(163, 116, 179, 130, 187, 122);
    final tailPaint = Paint()..color = const Color(0xFFFFFEFC)..style = PaintingStyle.stroke..strokeWidth = 16..strokeCap = StrokeCap.round;
    canvas.drawPath(tail, tailPaint);
    canvas.drawPath(tail, outline);

    // Body and head
    canvas.drawOval(const Rect.fromLTWH(48, 98, 128, 86), white);
    canvas.drawOval(const Rect.fromLTWH(48, 98, 128, 86), outline);
    final leftEar = Path()
      ..moveTo(56, 68)..lineTo(47, 18)..quadraticBezierTo(78, 28, 91, 65)..close();
    final rightEar = Path()
      ..moveTo(132, 65)..quadraticBezierTo(148, 25, 179, 18)..lineTo(169, 76)..close();
    canvas.drawPath(leftEar, white); canvas.drawPath(rightEar, white);
    canvas.drawPath(leftEar, outline); canvas.drawPath(rightEar, outline);
    final pink = Paint()..color = const Color(0xFFFFB4CC);
    canvas.drawPath(
      Path()..moveTo(59, 59)..lineTo(55, 31)..quadraticBezierTo(75, 40, 82, 61)..close(),
      pink,
    );
    canvas.drawPath(
      Path()..moveTo(145, 60)..quadraticBezierTo(157, 38, 170, 31)..lineTo(164, 61)..close(),
      pink,
    );
    canvas.drawOval(const Rect.fromLTWH(34, 47, 154, 116), white);
    canvas.drawOval(const Rect.fromLTWH(34, 47, 154, 116), outline);

    // Bow
    final bow = Paint()..color = const Color(0xFFE83E83);
    canvas.drawOval(const Rect.fromLTWH(78, 36, 27, 22), bow);
    canvas.drawOval(const Rect.fromLTWH(107, 36, 27, 22), bow);
    canvas.drawCircle(const Offset(106, 47), 8, Paint()..color = const Color(0xFFFFD76A));
    canvas.drawPath(
      Path()..moveTo(84, 52)..lineTo(76, 68)..lineTo(98, 59)..close(),
      bow,
    );
    canvas.drawPath(
      Path()..moveTo(127, 52)..lineTo(137, 68)..lineTo(116, 59)..close(),
      bow,
    );

    final eye = Paint()..color = const Color(0xFF382632);
    if (expression == CatExpression.happy) {
      final p = Paint()..color = const Color(0xFF382632)..style = PaintingStyle.stroke..strokeWidth = 4;
      canvas.drawArc(const Rect.fromLTWH(68, 91, 25, 19), 0, 3.14, false, p);
      canvas.drawArc(const Rect.fromLTWH(130, 91, 25, 19), 0, 3.14, false, p);
    } else {
      canvas.drawOval(const Rect.fromLTWH(73, 89, 15, 23), eye);
      canvas.drawOval(const Rect.fromLTWH(135, 89, 15, 23), eye);
      canvas.drawCircle(const Offset(78, 96), 4, Paint()..color = Colors.white);
      canvas.drawCircle(const Offset(140, 96), 4, Paint()..color = Colors.white);
    }
    canvas.drawOval(const Rect.fromLTWH(57, 117, 24, 12), pink);
    canvas.drawOval(const Rect.fromLTWH(142, 117, 24, 12), pink);
    final nose = Paint()..color = const Color(0xFFDB6B87);
    canvas.drawOval(const Rect.fromLTWH(103, 113, 13, 9), nose);
    final mouth = Paint()
      ..color = const Color(0xFF563344)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.8
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(const Offset(109, 121), const Offset(109, 129), mouth);
    canvas.drawArc(const Rect.fromLTWH(94, 122, 15, 13), 0, 2.4, false, mouth);
    canvas.drawArc(const Rect.fromLTWH(109, 122, 15, 13), .7, 2.4, false, mouth);

    // Paws
    canvas.drawOval(const Rect.fromLTWH(60, 151, 39, 24), white);
    canvas.drawOval(const Rect.fromLTWH(122, 151, 39, 24), white);
    canvas.drawOval(const Rect.fromLTWH(60, 151, 39, 24), outline);
    canvas.drawOval(const Rect.fromLTWH(122, 151, 39, 24), outline);

    if (withParcel) {
      final boxPaint = Paint()..color = const Color(0xFFFFDFA8);
      canvas.drawRRect(
        RRect.fromRectAndRadius(const Rect.fromLTWH(143, 130, 65, 53), const Radius.circular(7)),
        boxPaint,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(const Rect.fromLTWH(143, 130, 65, 53), const Radius.circular(7)),
        outline,
      );
      canvas.drawRect(const Rect.fromLTWH(170, 130, 10, 53), Paint()..color = const Color(0xFFE83E83));
      const textStyle = TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Color(0xFFA52D63));
      final tp = TextPainter(text: const TextSpan(text: 'W&R', style: textStyle), textDirection: TextDirection.ltr)..layout();
      tp.paint(canvas, const Offset(159, 149));
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _CatPainter oldDelegate) =>
      oldDelegate.expression != expression || oldDelegate.withParcel != withParcel;
}
