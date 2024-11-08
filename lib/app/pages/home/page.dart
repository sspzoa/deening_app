import 'package:deening_app/app/routes/routes.dart';
import 'package:deening_app/app/widgets/gestureDetector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../core/theme/colors.dart';
import '../../core/theme/static.dart';
import '../../core/theme/typography.dart';
import 'controller.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<CustomColors>()!;
    final textTheme = Theme.of(context).extension<CustomTypography>()!;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: CustomSpacing.spacing550),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              SvgPicture.asset(
                'assets/images/logo_with_text.svg',
                height: 64,
              ),
              const SizedBox(height: CustomSpacing.spacing550),
              SearchBarWidget(controller: controller),
              const SizedBox(height: CustomSpacing.spacing550),
              Divider(color: colorTheme.lineDivider),
              const SizedBox(height: CustomSpacing.spacing550),
              const Row(
                children: [
                  Expanded(child: IngredientsButton()),
                  SizedBox(width: CustomSpacing.spacing200),
                  Expanded(child: PreferenceButton()),
                ],
              ),
              const Spacer(),
              Text('© 2024 sspzoa. All rights reserved.',
                  style: textTheme.label
                      .copyWith(color: colorTheme.contentStandardTertiary)),
              const SizedBox(height: CustomSpacing.spacing550),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchBarWidget extends StatelessWidget {
  final HomePageController controller;

  const SearchBarWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<CustomColors>()!;
    final textTheme = Theme.of(context).extension<CustomTypography>()!;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: CustomSpacing.spacing300,
        vertical: CustomSpacing.spacing200,
      ),
      decoration: BoxDecoration(
        color: colorTheme.componentsFillStandardPrimary,
        borderRadius: BorderRadius.circular(CustomRadius.radius300),
        border: Border.all(
          color: colorTheme.lineOutline,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller.searchController,
              style: textTheme.label.copyWith(
                color: colorTheme.contentStandardSecondary,
              ),
              decoration: InputDecoration(
                hintText: '식재료 또는 요리로 검색하세요',
                hintStyle: textTheme.label.copyWith(
                  color: colorTheme.contentStandardTertiary,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
              textAlignVertical: TextAlignVertical.center,
              onChanged: controller.onSearchChanged,
              onSubmitted: controller.onSearchSubmitted,
            ),
          ),
          CustomGestureDetectorWithOpacityInteraction(
            onTap: () => {},
            child: Icon(
              Icons.search_rounded,
              size: 24,
              color: colorTheme.contentStandardSecondary,
            ),
          )
        ],
      ),
    );
  }
}

class IngredientsButton extends StatelessWidget {
  const IngredientsButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<CustomColors>()!;
    final textTheme = Theme.of(context).extension<CustomTypography>()!;

    return CustomGestureDetectorWithScaleInteraction(
      onTap: () => {},
      child: CustomGestureDetectorWithOpacityInteraction(
        onTap: () => {Get.toNamed(Routes.REFRIGERATOR)},
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            color: colorTheme.solidTranslucentIndigo,
            borderRadius: BorderRadius.circular(CustomRadius.radius300),
            border: Border.all(
              color: colorTheme.lineOutline,
              width: 1,
            ),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.kitchen_rounded,
                  size: 24,
                  color: colorTheme.contentStandardSecondary,
                ),
                const SizedBox(width: CustomSpacing.spacing300),
                Text(
                  '내 냉장고',
                  style: textTheme.label.copyWith(
                    color: colorTheme.contentStandardSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PreferenceButton extends StatelessWidget {
  const PreferenceButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<CustomColors>()!;
    final textTheme = Theme.of(context).extension<CustomTypography>()!;

    return CustomGestureDetectorWithScaleInteraction(
      onTap: () => {},
      child: CustomGestureDetectorWithOpacityInteraction(
        onTap: () => {Get.toNamed(Routes.PREFERENCE)},
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            color: colorTheme.solidTranslucentGreen,
            borderRadius: BorderRadius.circular(CustomRadius.radius300),
            border: Border.all(
              color: colorTheme.lineOutline,
              width: 1,
            ),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite_border_rounded,
                  size: 24,
                  color: colorTheme.contentStandardSecondary,
                ),
                const SizedBox(width: CustomSpacing.spacing300),
                Text(
                  '선호 키워드',
                  style: textTheme.label.copyWith(
                    color: colorTheme.contentStandardSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
