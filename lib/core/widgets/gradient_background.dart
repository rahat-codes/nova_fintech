
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../app/theme/nova_colors.dart';

class GradientBackground extends StatelessWidget {
  const GradientBackground({
    super.key,
    required this.child,
  });

  final Widget child;

  Widget _buildBlob({
    required double size,
    required Color color,
  }) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(
        sigmaX: 65,
        sigmaY: 65,
      ),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withValues(alpha: 0.55),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: NovaColors.backgroundGradient,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: -100,
            left: -100,
            child: _buildBlob(
              size: 300,
              color: NovaColors.red,
            ),
          ),
          Positioned(
            top: 220,
            right: -140,
            child: _buildBlob(
              size: 280,
              color: NovaColors.coral,
            ),
          ),
          Positioned(
            bottom: -150,
            left: 30,
            child: _buildBlob(
              size: 320,
              color: NovaColors.crimson,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
