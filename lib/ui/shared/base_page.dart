import 'package:connectinno_case/ui/shared/styles/colors.dart';
import 'package:flutter/material.dart';

class BasePage extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final bool enableTopSafeArea;
  final bool enableBottomSafeArea;
  final PreferredSizeWidget? appBar;
  final EdgeInsetsGeometry? contentPadding;
  final bool resizeToAvoidBottomInset;
  final Widget floatingActionButton;

  const BasePage({
    required this.child,
    this.backgroundColor,
    this.appBar,
    this.contentPadding,
    this.enableTopSafeArea = true,
    this.enableBottomSafeArea = true,
    this.resizeToAvoidBottomInset = true,
    this.floatingActionButton = const SizedBox.shrink(),
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: backgroundColor ?? AppColors.primaryWhiteColor,
      appBar: appBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: SafeArea(
        top: enableTopSafeArea,
        bottom: enableBottomSafeArea,
        child: Padding(
          padding: contentPadding ?? EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
          child: child,
        ),
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
