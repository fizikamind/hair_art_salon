import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_text_styles.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final String? hint;

  final IconData? prefixIcon;
  final IconData? suffixIcon;

  final VoidCallback? onSuffixTap;

  final TextInputType keyboardType;

  final bool obscureText;

  final int maxLines;

  final bool readOnly;

  final FormFieldValidator<String>? validator;

  final ValueChanged<String>? onChanged;

  const CustomTextField({
    super.key,
    this.controller,
    required this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.maxLines = 1,
    this.readOnly = false,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      readOnly: readOnly,
      validator: validator,
      onChanged: onChanged,

      style: AppTextStyles.bodyLarge,

      decoration: InputDecoration(
        labelText: label,
        hintText: hint,

        prefixIcon: prefixIcon == null
            ? null
            : Icon(
          prefixIcon,
          color: AppColors.primary,
        ),

        suffixIcon: suffixIcon == null
            ? null
            : IconButton(
          onPressed: onSuffixTap,
          icon: Icon(
            suffixIcon,
            color: AppColors.primary,
          ),
        ),

        filled: true,
        fillColor: AppColors.surface,

        border: OutlineInputBorder(
          borderRadius: AppRadius.medium,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.medium,
          borderSide: const BorderSide(
            color: AppColors.border,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.medium,
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 2,
          ),
        ),
      ),
    );
  }
}