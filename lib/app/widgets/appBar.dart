import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/theme/colors.dart';
import '../core/theme/typography.dart';
import '../widgets/gestureDetector.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final bool hasBackButton;
  final VoidCallback? onBackPressed;
  final double height;

  const CustomAppBar({
    super.key,
    this.title,
    this.actions,
    this.hasBackButton = true,
    this.onBackPressed,
    this.height = kToolbarHeight,
  });

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<CustomColors>()!;
    final textTheme = Theme.of(context).extension<CustomTypography>()!;

    return AppBar(
      leading: hasBackButton
          ? CustomGestureDetectorWithOpacityInteraction(
              onTap: onBackPressed ?? Get.back,
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 20,
                color: colorTheme.contentStandardTertiary,
              ),
            )
          : null,
      title: Text(
        title ?? '',
        style: textTheme.heading.copyWith(
          color: colorTheme.contentStandardPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
