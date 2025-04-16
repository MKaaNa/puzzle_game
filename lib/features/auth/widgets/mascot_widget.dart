import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MascotWidget extends StatefulWidget {
  const MascotWidget({super.key});

  @override
  State<MascotWidget> createState() => _MascotWidgetState();
}

class _MascotWidgetState extends State<MascotWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 10 * _controller.value),
          child: Lottie.asset(
            'assets/animations/mascot.json',
            width: 200,
            height: 200,
            fit: BoxFit.contain,
          ),
        );
      },
    );
  }
} 