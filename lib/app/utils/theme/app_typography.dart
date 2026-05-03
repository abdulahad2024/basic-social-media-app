import 'package:flutter/material.dart';
import 'app_colors.dart';

abstract class AppTypography {
  // কমন স্টাইল মেথড যা সব জায়গায় ফন্ট ফ্যামিলি সেট করবে
  static TextStyle _poppins({
    required double fontSize,
    required FontWeight fontWeight,
    double? letterSpacing,
    double? height,
    Color? color,
  }) {
    return TextStyle(
      fontFamily: 'Poppins',
      fontSize: fontSize,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      height: height,
      color: color,
    );
  }

  // ── Display ─────────────────────────────
  static TextStyle displayLarge({Color? color}) => _poppins(
    fontSize: 57,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.25,
    height: 1.12,
    color: color,
  );

  static TextStyle displayMedium({Color? color}) => _poppins(
    fontSize: 45,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    height: 1.16,
    color: color,
  );

  static TextStyle displaySmall({Color? color}) => _poppins(
    fontSize: 36,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.22,
    color: color,
  );

  // ── Headline ─────────────────────────────
  static TextStyle headlineLarge({Color? color}) => _poppins(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    height: 1.25,
    color: color,
  );

  static TextStyle headlineMedium({Color? color}) => _poppins(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.29,
    color: color,
  );

  static TextStyle headlineSmall({Color? color}) => _poppins(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.33,
    color: color,
  );

  // ── Title ────────────────────────────────
  static TextStyle titleLarge({Color? color}) => _poppins(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.27,
    color: color,
  );

  static TextStyle titleMedium({Color? color}) => _poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.15,
    height: 1.50,
    color: color,
  );

  static TextStyle appBar({Color? color}) => _poppins(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: color,
  );

  static TextStyle titleSmall({Color? color}) => _poppins(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
    height: 1.43,
    color: color,
  );

  // ── Label ────────────────────────────────
  static TextStyle labelLarge({Color? color}) => _poppins(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
    height: 1.43,
    color: color,
  );

  static TextStyle labelMedium({Color? color}) => _poppins(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    height: 1.33,
    color: color,
  );

  static TextStyle labelSmall({Color? color}) => _poppins(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.45,
    color: color,
  );

  // ── Body ─────────────────────────────────
  static TextStyle bodyLarge({Color? color}) => _poppins(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    height: 1.50,
    color: color,
  );

  static TextStyle bodyMedium({Color? color}) => _poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.43,
    color: color,
  );

  static TextStyle bodySmall({Color? color}) => _poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    height: 1.33,
    color: color,
  );

  // ── Special ──────────────────────────────
  static TextStyle caption({Color? color}) => _poppins(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    height: 1.45,
    color: color ?? AppColors.neutral500,
  );

  static TextStyle overline({Color? color}) => _poppins(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.5,
    height: 1.6,
    color: color,
  ).copyWith(decoration: TextDecoration.none);

  static TextStyle code({Color? color}) => _poppins(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.5,
    color: color,
  );

  static TextTheme buildTextTheme({required bool isDark}) {
    final base = isDark ? AppColors.neutral50 : AppColors.neutral900;
    return TextTheme(
      displayLarge: displayLarge(color: base),
      displayMedium: displayMedium(color: base),
      displaySmall: displaySmall(color: base),
      headlineLarge: headlineLarge(color: base),
      headlineMedium: headlineMedium(color: base),
      headlineSmall: headlineSmall(color: base),
      titleLarge: titleLarge(color: base),
      titleMedium: titleMedium(color: base),
      titleSmall: titleSmall(color: base),
      labelLarge: labelLarge(color: base),
      labelMedium: labelMedium(color: base),
      labelSmall: labelSmall(color: base),
      bodyLarge: bodyLarge(color: base),
      bodyMedium: bodyMedium(color: base),
      bodySmall: bodySmall(color: base),
    );
  }
}