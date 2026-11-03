
import 'package:flutter/material.dart';

class NovaColors {
  NovaColors._();

  // Main background colors
  static const Color background = Color(0xFF190609);
  static const Color deepMaroon = Color(0xFF26080E);
  static const Color darkMaroon = Color(0xFF350A13);

  // Brand colors
  static const Color crimson = Color(0xFFB71935);
  static const Color red = Color(0xFFE52D4D);
  static const Color coral = Color(0xFFFF6B75);

  // Supporting colors
  static const Color navy = Color(0xFF10182B);
  static const Color white = Color(0xFFFFFFFF);
  static const Color softWhite = Color(0xFFEDE6E8);
  static const Color mutedWhite = Color(0xFFA99BA0);

  // Glass colors
  static const Color glassWhite = Color(0x26FFFFFF);
  static const Color glassBorder = Color(0x40FFFFFF);

  // Status colors
  static const Color success = Color(0xFF68D6A3);
  static const Color negative = Color(0xFFFF6879);

  // Main background gradient
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF681326),
      Color(0xFF360B18),
      Color(0xFF190609),
      Color(0xFF100509),
    ],
  );

  // Card gradient
  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFE9445B),
      Color(0xFFB71935),
      Color(0xFF570D22),
    ],
  );

  // Button gradient
  static const LinearGradient buttonGradient = LinearGradient(
    colors: [
      Color(0xFFFF6978),
      Color(0xFFCE2443),
    ],
  );
}
