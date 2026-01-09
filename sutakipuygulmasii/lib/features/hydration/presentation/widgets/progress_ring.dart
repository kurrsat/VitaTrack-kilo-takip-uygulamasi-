import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Custom circular progress ring widget
class ProgressRing extends StatefulWidget {
  final double progress; // 0.0 to 1.0
  final double size;
  final Color? backgroundColor;
  final Color? progressColor;
  final Color? completeColor;
  final Color? textColor;

  const ProgressRing({
    super.key,
    required this.progress,
    this.size = 200,
    this.backgroundColor,
    this.progressColor,
    this.completeColor,
    this.textColor,
  });

  @override
  State<ProgressRing> createState() => _ProgressRingState();
}

class _ProgressRingState extends State<ProgressRing>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: widget.progress).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _controller.forward();
  }

  @override
  void didUpdateWidget(ProgressRing oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.progress != widget.progress) {
      _animation = Tween<double>(
        begin: oldWidget.progress,
        end: widget.progress,
      ).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
      );
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final progress = _animation.value.clamp(0.0, 1.0);
          final isComplete = progress >= 1.0;
          final theme = Theme.of(context);
          final baseProgressColor =
              widget.progressColor ?? theme.colorScheme.primary;
          final completeColor =
              widget.completeColor ?? theme.colorScheme.secondary;
          final backgroundColor = widget.backgroundColor ??
              theme.colorScheme.onSurface.withOpacity(0.2);
          final textColor =
              widget.textColor ?? theme.colorScheme.onSurface;

          return CustomPaint(
            painter: _ProgressRingPainter(
              progress: progress,
              backgroundColor: backgroundColor,
              progressColor: isComplete ? completeColor : baseProgressColor,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${(progress * 100).toInt()}%',
                    style: TextStyle(
                      fontSize: widget.size * 0.15,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  if (isComplete)
                    Icon(
                      Icons.check_circle,
                      color: completeColor,
                      size: widget.size * 0.12,
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ProgressRingPainter extends CustomPainter {
  final double progress;
  final Color backgroundColor;
  final Color progressColor;

  _ProgressRingPainter({
    required this.progress,
    required this.backgroundColor,
    required this.progressColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;
    final strokeWidth = radius * 0.15;

    // Background circle
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius - strokeWidth / 2, backgroundPaint);

    // Progress arc
    if (progress > 0) {
      final progressPaint = Paint()
        ..color = progressColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      final sweepAngle = 2 * math.pi * progress;
      final startAngle = -math.pi / 2; // Start from top

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
        startAngle,
        sweepAngle,
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(_ProgressRingPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.progressColor != progressColor;
  }
}
