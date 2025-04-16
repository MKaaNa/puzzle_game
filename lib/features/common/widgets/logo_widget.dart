import 'package:flutter/material.dart';
import 'dart:math';

class LogoWidget extends StatelessWidget {
  final double size;
  final bool animate;

  const LogoWidget({
    super.key,
    this.size = 120,
    this.animate = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(size / 4),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Stack(
        children: [
          // Puzzle karakterinin yüzü
          Center(
            child: Container(
              width: size * 0.8,
              height: size * 0.8,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(size / 5),
              ),
              child: Stack(
                children: [
                  // Sol göz
                  Positioned(
                    left: size * 0.2,
                    top: size * 0.25,
                    child: _buildEye(animate),
                  ),
                  // Sağ göz
                  Positioned(
                    right: size * 0.2,
                    top: size * 0.25,
                    child: _buildEye(animate),
                  ),
                  // Gülümseyen ağız
                  Positioned(
                    bottom: size * 0.2,
                    left: size * 0.2,
                    right: size * 0.2,
                    child: Container(
                      height: size * 0.15,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(size * 0.1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Puzzle parçaları efekti
          if (animate)
            ...List.generate(4, (index) {
              final angle = index * (3.14159 / 2);
              return Positioned(
                left: size * 0.4 + (size * 0.2 * cos(angle)),
                top: size * 0.4 + (size * 0.2 * sin(angle)),
                child: TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: Duration(milliseconds: 1500 + index * 200),
                  curve: Curves.elasticOut,
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: value,
                      child: Container(
                        width: size * 0.15,
                        height: size * 0.15,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(size * 0.05),
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
        ],
      ),
    );
  }

  Widget _buildEye(bool animate) {
    return SizedBox(
      width: size * 0.15,
      height: size * 0.15,
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.black87,
              shape: BoxShape.circle,
            ),
          ),
          if (animate)
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(milliseconds: 1500),
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: Center(
                    child: Container(
                      width: size * 0.05,
                      height: size * 0.05,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
} 