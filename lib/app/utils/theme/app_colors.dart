import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color primary50 = Color(0xFFEEF2FF);
  static const Color primary100 = Color(0xFFE0E7FF);
  static const Color primary200 = Color(0xFFC7D2FE);
  static const Color primary300 = Color(0xFFA5B4FC);
  static const Color primary400 = Color(0xFF818CF8);
  static const Color primary500 = Color(0xFF6366F1);
  static const Color primary600 = Color(0xFF4F46E5);// Main
  static const Color primary700 = Color(0xFF4338CA);
  static const Color primary800 = Color(0xFF3730A3);
  static const Color primary900 = Color(0xFF312E81);
  static const Color white = Colors.white;

  static const Color secondary50 = Color(0xFFF0FDFA);
  static const Color secondary100 = Color(0xFFCCFBF1);
  static const Color secondary300 = Color(0xFF5EEAD4);
  static const Color secondary400 = Color(0xFF2DD4BF);
  static const Color secondary500 = Color(0xFF14B8A6); // Main accent
  static const Color secondary600 = Color(0xFF0D9488);
  static const Color secondary700 = Color(0xFF0F766E);

  static const Color success50 = Color(0xFFF0FDF4);
  static const Color success500 = Color(0xFF22C55E);
  static const Color success700 = Color(0xFF15803D);

  static const Color warning50 = Color(0xFFFFFBEB);
  static const Color warning500 = Color(0xFFF59E0B);
  static const Color warning700 = Color(0xFFB45309);

  static const Color error50 = Color(0xFFFFF1F2);
  static const Color error500 = Color(0xFFF43F5E);
  static const Color error700 = Color(0xFFBE123C);

  static const Color info50 = Color(0xFFEFF6FF);
  static const Color info500 = Color(0xFF3B82F6);
  static const Color info700 = Color(0xFF1D4ED8);

  static const Color neutral0 = Color(0xFFFFFFFF);
  static const Color neutral50 = Color(0xFFF8FAFC);
  static const Color neutral100 = Color(0xFFF1F5F9);
  static const Color neutral200 = Color(0xFFE2E8F0);
  static const Color neutral300 = Color(0xFFCBD5E1);
  static const Color neutral400 = Color(0xFF94A3B8);
  static const Color neutral500 = Color(0xFF64748B);
  static const Color neutral600 = Color(0xFF475569);
  static const Color neutral700 = Color(0xFF334155);
  static const Color neutral800 = Color(0xFF1E293B);
  static const Color neutral900 = Color(0xFF0F172A);
  static const Color neutral950 = Color(0xFF020617);

  static const Color transparent = Colors.transparent;
  static Color black12 = Colors.black.withValues(alpha: 0.12);
  static Color black26 = Colors.black.withValues(alpha: 0.26);
  static Color white10 = Colors.white.withValues(alpha: 0.10);
  static Color white20 = Colors.white.withValues(alpha: 0.20);

  static const primaryBlue = Color(0xFF1877F2); // ফেসবুকের ডিফল্ট নীল কালার
  static const bgGrey = Color(0xFFF0F2F5);     // হালকা ব্যাকগ্রাউন্ড গ্রে
  static const borderGrey = Color(0xFFCED0D4);  // বর্ডার এবং লাইনের জন্য கிரே
  static const darkGrey = Color(0xFF65676B);     // টেক্সট এবং আইকনের জন্য ডার্ক গ্রে

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary500, primary700],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient shimmerGradient = LinearGradient(
    colors: [neutral200, neutral100, neutral200],
    stops: [0.0, 0.5, 1.0],
    begin: Alignment(-1, 0),
    end: Alignment(2, 0),
  );

  static const LinearGradient darkSurface = LinearGradient(
    colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
