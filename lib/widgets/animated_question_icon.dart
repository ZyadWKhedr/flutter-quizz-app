import 'package:flutter/material.dart';

class AnimatedQuestionIcon extends StatefulWidget {
  final double size;
  final Color color;
  final EdgeInsetsGeometry padding;

  const AnimatedQuestionIcon({
    super.key,
    this.size = 64.0,
    this.color = Colors.white,
    this.padding = const EdgeInsets.all(8.0),
  });

  @override
  State<AnimatedQuestionIcon> createState() => _AnimatedQuestionIconState();
}

class _AnimatedQuestionIconState extends State<AnimatedQuestionIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.rotate(
            angle: _animationController.value * 2.0 * 3.1415926535897932,
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.blueAccent, Colors.purpleAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: const Offset(0, 4),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  Icons.question_mark,
                  size: widget.size,
                  color: widget.color,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
