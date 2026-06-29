import 'package:flutter/material.dart';

import '../../core/theme/app_animation.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_shadow.dart';

class PremiumCard extends StatelessWidget {
  final Widget child;

  final VoidCallback? onTap;

  final EdgeInsetsGeometry padding;

  final EdgeInsetsGeometry margin;

  final double? width;

  final double? height;

  final Gradient? gradient;

  final Color? color;

  const PremiumCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 8,
    ),
    this.width,
    this.height,
    this.gradient,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AppAnimation.normal,
      curve: AppAnimation.easeInOut,
      margin: margin,
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color ?? AppColors.card,
        gradient: gradient,
        borderRadius: AppRadius.large,
        border: Border.all(
          color: AppColors.border,
          width: 1,
        ),
        boxShadow: AppShadow.premium,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: AppRadius.large,
        child: InkWell(
          borderRadius: AppRadius.large,
          onTap: onTap,
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}