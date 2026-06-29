import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class PremiumAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;

  final bool showBackButton;

  final List<Widget>? actions;

  final PreferredSizeWidget? bottom;

  final Widget? leading;

  const PremiumAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.actions,
    this.bottom,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      centerTitle: true,
      backgroundColor: AppColors.background,

      leading: leading ??
          (showBackButton
              ? IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.primary,
            ),
            onPressed: () => Navigator.pop(context),
          )
              : null),

      title: Text(
        title,
        style: AppTextStyles.appBarTitle,
      ),

      actions: actions,

      bottom: bottom,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(
        kToolbarHeight +
            (bottom?.preferredSize.height ?? 0),
      );
}