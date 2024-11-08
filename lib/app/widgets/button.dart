import 'package:flutter/material.dart';

import '../core/theme/colors.dart';
import '../core/theme/static.dart';
import '../core/theme/typography.dart';
import '../widgets/gestureDetector.dart';

enum CustomButtonVariant { primary, secondary }

class CustomButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback onTap;
  final CustomButtonVariant variant;
  final bool disabled;

  const CustomButton({
    Key? key,
    required this.text,
    this.icon,
    required this.onTap,
    this.variant = CustomButtonVariant.primary,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<CustomColors>()!;
    final textTheme = Theme.of(context).extension<CustomTypography>()!;

    final bool isPrimary = variant == CustomButtonVariant.primary;

    return CustomGestureDetectorWithOpacityInteraction(
      onTap: () => {},
      child: CustomGestureDetectorWithScaleInteraction(
        onTap: disabled ? null : onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: CustomSpacing.spacing200,
          ),
          decoration: BoxDecoration(
            color: disabled
                ? colorTheme.componentsTranslucentPrimary
                : isPrimary
                    ? colorTheme.coreAccent
                    : colorTheme.backgroundStandardPrimary,
            border: Border(
              bottom: BorderSide(
                color: colorTheme.lineOutline,
              ),
            ),
            borderRadius: BorderRadius.circular(CustomRadius.radius300),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 24,
                  color: disabled
                      ? colorTheme.contentStandardTertiary
                      : isPrimary
                          ? colorTheme.contentInvertedPrimary
                          : colorTheme.contentStandardPrimary,
                ),
                const SizedBox(width: CustomSpacing.spacing300),
              ],
              Text(
                text,
                style: textTheme.label.copyWith(
                  color: disabled
                      ? colorTheme.contentStandardTertiary
                      : isPrimary
                          ? colorTheme.contentInvertedPrimary
                          : colorTheme.contentStandardPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
