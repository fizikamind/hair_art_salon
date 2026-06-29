import 'package:flutter/material.dart';

class AppAnimation {
  AppAnimation._();

  // ===========================
  // Duration
  // ===========================

  static const Duration fast =
  Duration(milliseconds: 200);

  static const Duration normal =
  Duration(milliseconds: 350);

  static const Duration slow =
  Duration(milliseconds: 600);

  static const Duration extraSlow =
  Duration(milliseconds: 1000);

  // ===========================
  // Curves
  // ===========================

  static const Curve ease = Curves.ease;

  static const Curve easeIn =
      Curves.easeIn;

  static const Curve easeOut =
      Curves.easeOut;

  static const Curve easeInOut =
      Curves.easeInOut;

  static const Curve bounce =
      Curves.easeOutBack;

  static const Curve elastic =
      Curves.elasticOut;
}