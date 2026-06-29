import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ===========================
  // Brand Colors
  // ===========================

  static const Color primary = Color(0xFFD4AF37); // Luxury Gold
  static const Color secondary = Color(0xFF8B6B00);
  static const Color accent = Color(0xFFFFD54F);

  // ===========================
  // Background
  // ===========================

  static const Color background = Color(0xFF121212);
  static const Color surface = Color(0xFF1E1E1E);
  static const Color card = Color(0xFF242424);

  // ===========================
  // Text Colors
  // ===========================

  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFFBDBDBD);
  static const Color textHint = Color(0xFF757575);

  // ===========================
  // Status Colors
  // ===========================

  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);

  // ===========================
  // Booking Status
  // ===========================

  static const Color pending = Color(0xFFFFA726);
  static const Color confirmed = Color(0xFF4CAF50);
  static const Color completed = Color(0xFF2196F3);
  static const Color cancelled = Color(0xFFE53935);

  // ===========================
  // Divider & Border
  // ===========================

  static const Color divider = Color(0xFF333333);
  static const Color border = Color(0xFF424242);

  // ===========================
  // Icons
  // ===========================

  static const Color icon = Colors.white;
  static const Color iconSecondary = Color(0xFFBDBDBD);

  // ===========================
  // Shadows
  // ===========================

  static const Color shadow = Colors.black38;

  // ===========================
  // Gradients
  // ===========================

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [
      Color(0xFFD4AF37),
      Color(0xFFFFD54F),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkGradient = LinearGradient(
    colors: [
      Color(0xFF1E1E1E),
      Color(0xFF121212),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [
      Color(0xFF2A2A2A),
      Color(0xFF1E1E1E),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}