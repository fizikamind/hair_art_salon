import 'package:flutter/widgets.dart';

class AppSpacing {
  AppSpacing._();

  // Padding / Margin Values
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;
  static const double huge = 40;

  // EdgeInsets
  static const EdgeInsets pagePadding = EdgeInsets.all(lg);

  static const EdgeInsets cardPadding = EdgeInsets.all(lg);

  static const EdgeInsets screenPadding = EdgeInsets.symmetric(
    horizontal: lg,
    vertical: md,
  );

  static const EdgeInsets horizontalPadding = EdgeInsets.symmetric(
    horizontal: lg,
  );

  static const EdgeInsets verticalPadding = EdgeInsets.symmetric(
    vertical: lg,
  );

  // SizedBox Heights
  static const SizedBox h4 = SizedBox(height: xs);
  static const SizedBox h8 = SizedBox(height: sm);
  static const SizedBox h12 = SizedBox(height: md);
  static const SizedBox h16 = SizedBox(height: lg);
  static const SizedBox h20 = SizedBox(height: xl);
  static const SizedBox h24 = SizedBox(height: xxl);
  static const SizedBox h32 = SizedBox(height: xxxl);
  static const SizedBox h40 = SizedBox(height: huge);

  // SizedBox Widths
  static const SizedBox w4 = SizedBox(width: xs);
  static const SizedBox w8 = SizedBox(width: sm);
  static const SizedBox w12 = SizedBox(width: md);
  static const SizedBox w16 = SizedBox(width: lg);
  static const SizedBox w20 = SizedBox(width: xl);
  static const SizedBox w24 = SizedBox(width: xxl);
  static const SizedBox w32 = SizedBox(width: xxxl);
}