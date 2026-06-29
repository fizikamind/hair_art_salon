import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppShadow {
  AppShadow._();

  // Small Shadow
  static List<BoxShadow> small = [
    BoxShadow(
      color: AppColors.shadow.withValues(alpha: 0.15),
      blurRadius: 6,
      offset: const Offset(0, 2),
    ),
  ];

  // Medium Shadow
  static List<BoxShadow> medium = [
    BoxShadow(
      color: AppColors.shadow.withValues(alpha: 0.20),
      blurRadius: 10,
      offset: const Offset(0, 4),
    ),
  ];

  // Large Shadow
  static List<BoxShadow> large = [
    BoxShadow(
      color: AppColors.shadow.withValues(alpha: 0.25),
      blurRadius: 18,
      offset: const Offset(0, 8),
    ),
  ];

  // Premium Card Shadow
  static List<BoxShadow> premium = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.30),
      blurRadius: 20,
      spreadRadius: 1,
      offset: const Offset(0, 10),
    ),
  ];

  // Gold Glow
  static List<BoxShadow> goldGlow = [
    BoxShadow(
      color: AppColors.primary.withValues(alpha: 0.35),
      blurRadius: 18,
      spreadRadius: 1,
      offset: const Offset(0, 0),
    ),
  ];
}