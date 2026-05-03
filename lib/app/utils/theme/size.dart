import 'package:flutter/material.dart';
import 'app_colors.dart';

/// ─────────────────────────────────────────
///  SPACING TOKENS
/// ─────────────────────────────────────────
abstract class AppSpacing {
  static const double xs2 = 2.0;
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double xl2 = 24.0;
  static const double xl3 = 32.0;
  static const double xl4 = 40.0;
  static const double xl5 = 48.0;
  static const double xl6 = 64.0;
  static const double xl7 = 80.0;
  static const double xl8 = 96.0;

  // ── Named edge insets ────────────────────
  static const EdgeInsets pagePadding =
  EdgeInsets.symmetric(horizontal: lg, vertical: xl2);

  static const EdgeInsets cardPadding =
  EdgeInsets.symmetric(horizontal: lg, vertical: lg);

  static const EdgeInsets buttonPadding =
  EdgeInsets.symmetric(horizontal: xl2, vertical: md);

  static const EdgeInsets chipPadding =
  EdgeInsets.symmetric(horizontal: md, vertical: xs);

  static const EdgeInsets inputPadding =
  EdgeInsets.symmetric(horizontal: lg, vertical: md);

  static const EdgeInsets sectionPadding =
  EdgeInsets.symmetric(horizontal: lg);
}

/// ─────────────────────────────────────────
///  RADIUS TOKENS
/// ─────────────────────────────────────────
abstract class AppRadius {
  static const double none = 0;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xl2 = 24;
  static const double xl3 = 32;
  static const double full = 999;

  static const BorderRadius radiusXs = BorderRadius.all(Radius.circular(xs));
  static const BorderRadius radiusSm = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius radiusMd = BorderRadius.all(Radius.circular(md));
  static const BorderRadius radiusLg = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius radiusXl = BorderRadius.all(Radius.circular(xl));
  static const BorderRadius radiusXl2 = BorderRadius.all(Radius.circular(xl2));
  static const BorderRadius radiusFull =
  BorderRadius.all(Radius.circular(full));
}

/// ─────────────────────────────────────────
///  SHADOW TOKENS
/// ─────────────────────────────────────────
abstract class AppShadows {
  static List<BoxShadow> xs = [
    BoxShadow(
      color: Colors.black.withOpacity(0.04),
      blurRadius: 4,
      offset: const Offset(0, 1),
    ),
  ];

  static List<BoxShadow> sm = [
    BoxShadow(
      color: Colors.black.withOpacity(0.06),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.04),
      blurRadius: 4,
      offset: const Offset(0, 1),
    ),
  ];

  static List<BoxShadow> md = [
    BoxShadow(
      color: Colors.black.withOpacity(0.08),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.04),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> lg = [
    BoxShadow(
      color: Colors.black.withOpacity(0.10),
      blurRadius: 32,
      offset: const Offset(0, 8),
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.04),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> xl = [
    BoxShadow(
      color: Colors.black.withOpacity(0.12),
      blurRadius: 56,
      offset: const Offset(0, 16),
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.06),
      blurRadius: 24,
      offset: const Offset(0, 8),
    ),
  ];

  // Colored glow shadow (for primary buttons etc.)
  static List<BoxShadow> primaryGlow = [
    BoxShadow(
      color: AppColors.primary500.withOpacity(0.30),
      blurRadius: 20,
      offset: const Offset(0, 6),
    ),
  ];

  static List<BoxShadow> darkCard = [
    BoxShadow(
      color: Colors.black.withOpacity(0.25),
      blurRadius: 24,
      offset: const Offset(0, 8),
    ),
  ];
}

/// ─────────────────────────────────────────
///  ANIMATION DURATIONS
/// ─────────────────────────────────────────
abstract class AppDurations {
  static const Duration instant = Duration(milliseconds: 0);
  static const Duration fastest = Duration(milliseconds: 100);
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration slower = Duration(milliseconds: 700);
  static const Duration slowest = Duration(milliseconds: 1000);
}

abstract class AppCurves {
  static const Curve standard = Curves.easeInOut;
  static const Curve enter = Curves.easeOut;
  static const Curve exit = Curves.easeIn;
  static const Curve spring = Curves.elasticOut;
  static const Curve bounce = Curves.bounceOut;
  static const Curve decelerate = Curves.decelerate;
  static const Curve anticipate = Curves.easeInBack;
}