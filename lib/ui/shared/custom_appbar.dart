import 'package:auto_route/auto_route.dart';
import 'package:connectinno_case/ui/shared/styles/colors.dart';
import 'package:connectinno_case/ui/shared/styles/text_styles.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final String? titleText;
  final bool centerTitle;
  final Color? backgroundColor;
  final List<Widget>? actions;
  final Widget? leading;
  final bool showBottomBorder;
  final bool autoImplementLeading;

  const CustomAppBar({
    this.title,
    this.centerTitle = false,
    this.backgroundColor,
    this.actions,
    this.leading,
    this.showBottomBorder = true,
    this.titleText,
    this.autoImplementLeading = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 65,
      leading:
          !autoImplementLeading
              ? null
              : GestureDetector(onTap: () => context.maybePop(), child: leading ?? Icon(Icons.arrow_back, size: 24, color: AppColors.primaryBlackColor)),
      automaticallyImplyLeading: autoImplementLeading,
      backgroundColor: backgroundColor ?? Colors.white,
      elevation: 0,
      actions: actions,
      title: title ?? Text(titleText ?? "", style: AppTextStyles.p1Medium.copyWith(color: Colors.black)),
      surfaceTintColor: Colors.transparent,
      centerTitle: centerTitle,
      titleSpacing: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(65);
}
