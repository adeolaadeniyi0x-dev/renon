import 'package:flutter/material.dart';

class RenonLogo extends StatelessWidget {
  const RenonLogo({
    super.key,
    this.size = 82,
    this.showWordmark = false,
    this.onDark = false,
  });

  final double size;
  final bool showWordmark;
  final bool onDark;

  @override
  Widget build(BuildContext context) {
    final logo = SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _RenonLogoPainter(
          onDark: onDark,
        ),
      ),
    );

    if (!showWordmark) {
      return logo;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        logo,
        const SizedBox(width: 12),
        Text(
          'RENON',
          style: TextStyle(
            color: onDark ? Colors.white : const Color(0xFF171B18),
            fontSize: size * 0.34,
            fontWeight: FontWeight.w800,
            letterSpacing: size * 0.025,
            height: 1,
          ),
        ),
      ],
    );
  }
}

class _RenonLogoPainter extends CustomPainter {
  _RenonLogoPainter({
    required this.onDark,
  });

  final bool onDark;

  @override
  void paint(Canvas canvas, Size size) {
    final lime = const Color(0xFFC6F135);
    final dark = const Color(0xFF171B18);

    final backgroundPaint = Paint()
      ..color = onDark ? const Color(0xFF202520) : lime
      ..style = PaintingStyle.fill;

    final center = Offset(
      size.width / 2,
      size.height / 2,
    );

    // Rounded-square background.
    final rect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: center,
        width: size.width * 0.88,
        height: size.height * 0.88,
      ),
      Radius.circular(size.width * 0.23),
    );

    canvas.drawRRect(rect, backgroundPaint);

    // Stylised RENON "R" mark.
    final path = Path();

    final left = size.width * 0.29;
    final right = size.width * 0.70;
    final top = size.height * 0.23;
    final bottom = size.height * 0.77;

    path.moveTo(left, bottom);
    path.lineTo(left, top);

    path.lineTo(size.width * 0.53, top);

    path.cubicTo(
      size.width * 0.67,
      top,
      right,
      size.height * 0.31,
      right,
      size.height * 0.43,
    );

    path.cubicTo(
      right,
      size.height * 0.54,
      size.width * 0.64,
      size.height * 0.58,
      size.width * 0.51,
      size.height * 0.58,
    );

    path.moveTo(
      size.width * 0.50,
      size.height * 0.58,
    );

    path.lineTo(
      size.width * 0.72,
      bottom,
    );

    // Use dark mark on lime and lime mark on dark.
    final markPaint = Paint()
      ..color = onDark ? lime : dark
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.105
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(path, markPaint);

    // Small diagonal accent representing movement / connection.
    final accent = Path()
      ..moveTo(
        size.width * 0.58,
        size.height * 0.30,
      )
      ..lineTo(
        size.width * 0.69,
        size.height * 0.30,
      );

    canvas.drawPath(accent, markPaint);
  }

  @override
  bool shouldRepaint(covariant _RenonLogoPainter oldDelegate) {
    return oldDelegate.onDark != onDark;
  }
}