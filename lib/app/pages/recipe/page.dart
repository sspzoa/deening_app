import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../core/theme/colors.dart';
import '../../core/theme/static.dart';
import '../../core/theme/typography.dart';
import '../../widgets/appBar.dart';
import '../../widgets/gestureDetector.dart';
import 'controller.dart';

class RecipePage extends GetView<RecipePageController> {
  const RecipePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<CustomColors>()!;
    final textTheme = Theme.of(context).extension<CustomTypography>()!;
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _RecipeHeader(controller: controller, colorTheme: colorTheme),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: CustomSpacing.spacing550,
                  vertical: CustomSpacing.spacing700,
                ),
                child: _RecipeContent(
                  colorTheme: colorTheme,
                  textTheme: textTheme,
                  controller: controller,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecipeHeader extends StatelessWidget {
  final RecipePageController controller;
  final CustomColors colorTheme;

  const _RecipeHeader({
    required this.controller,
    required this.colorTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.memory(
          height: 225,
          width: double.infinity,
          Uri.parse(controller.base64).data!.contentAsBytes(),
          fit: BoxFit.cover,
        ),
        Container(
          color: colorTheme.solidBlack.withOpacity(0.5),
          height: 225,
          width: double.infinity,
        ),
      ],
    );
  }
}

class _RecipeContent extends StatelessWidget {
  final CustomColors colorTheme;
  final CustomTypography textTheme;
  final RecipePageController controller;

  const _RecipeContent({
    required this.colorTheme,
    required this.textTheme,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleSection(),
        _buildDividerWithSpacing(),
        _buildNutritionSection(),
        _buildDividerWithSpacing(),
        _buildIngredientsSection(),
        _buildDividerWithSpacing(),
        _buildCookingStepsSection(),
      ],
    );
  }

  Widget _buildTitleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '해물 짬뽕',
              style: textTheme.title.copyWith(
                color: colorTheme.contentStandardPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            _buildCookingTime(),
          ],
        ),
        const SizedBox(height: CustomSpacing.spacing400),
        Text(
          '매콤하고 깊은 해물의 맛이 일품인 한국식 해물 짬뽕입니다.',
          style: textTheme.body.copyWith(
            color: colorTheme.contentStandardSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildCookingTime() {
    return Row(
      children: [
        Icon(Icons.schedule_rounded,
            color: colorTheme.contentStandardSecondary),
        const SizedBox(width: CustomSpacing.spacing150),
        Text(
          '15분',
          style: textTheme.body.copyWith(
            color: colorTheme.contentStandardSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildDividerWithSpacing() {
    return Column(
      children: [
        const SizedBox(height: CustomSpacing.spacing700),
        Divider(color: colorTheme.lineDivider),
        const SizedBox(height: CustomSpacing.spacing700),
      ],
    );
  }

  Widget _buildNutritionSection() {
    final nutritionItems = [
      NutritionItem('carbs', '탄수화물 800g'),
      NutritionItem('proteins', '단백질 35g'),
      NutritionItem('fats', '지방 15g'),
      NutritionItem('calories', '600kcal'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '영양 정보',
          style: textTheme.heading.copyWith(
            color: colorTheme.contentStandardPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: CustomSpacing.spacing400),
        GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          shrinkWrap: true,
          childAspectRatio: 3,
          children:
              nutritionItems.map((item) => _buildNutritionItem(item)).toList(),
        ),
      ],
    );
  }

  Widget _buildNutritionItem(NutritionItem item) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(CustomSpacing.spacing200),
          decoration: BoxDecoration(
            color: colorTheme.coreAccentTranslucent,
            borderRadius: BorderRadius.circular(CustomRadius.radius300),
          ),
          child: SvgPicture.asset(
            'assets/images/${item.icon}.svg',
            width: 24,
            height: 24,
          ),
        ),
        const SizedBox(width: CustomSpacing.spacing200),
        Text(item.label, style: textTheme.label),
      ],
    );
  }

  Widget _buildIngredientsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '식재료',
          style: textTheme.heading.copyWith(
            color: colorTheme.contentStandardPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: CustomSpacing.spacing100),
        Text(
          '식재료를 눌러 더 자세한 정보와 이미지를 볼 수 있어요',
          style: textTheme.footnote.copyWith(
            color: colorTheme.contentStandardTertiary,
          ),
        ),
        const SizedBox(height: CustomSpacing.spacing400),
        _buildIngredientsList(),
      ],
    );
  }

  Widget _buildIngredientsList() {
    final ingredients = [
      IngredientItem('오징어', '1마리', false),
      IngredientItem('바지락', '100g', true),
      IngredientItem('문어', '1마리', false),
    ];

    return Column(
      children: ingredients.map((item) {
        return Column(
          children: [
            _buildIngredientItem(item),
            const SizedBox(height: CustomSpacing.spacing200),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildIngredientItem(IngredientItem item) {
    if (item.hasDetails) {
      return _buildDetailedIngredientItem(item);
    }
    return _buildSimpleIngredientItem(item);
  }

  Widget _buildSimpleIngredientItem(IngredientItem item) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: _getIngredientContainerDecoration(),
              padding: const EdgeInsets.symmetric(
                horizontal: CustomSpacing.spacing300,
                vertical: CustomSpacing.spacing200,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item.name,
                    style: textTheme.label.copyWith(
                      color: colorTheme.contentStandardPrimary,
                    ),
                  ),
                  Text(
                    item.quantity,
                    style: textTheme.label.copyWith(
                      color: colorTheme.coreAccent,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: CustomSpacing.spacing100),
          _buildReplaceButton(),
        ],
      ),
    );
  }

  Widget _buildDetailedIngredientItem(IngredientItem item) {
    return IntrinsicHeight(
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: _getIngredientContainerDecoration(),
              padding: const EdgeInsets.symmetric(
                horizontal: CustomSpacing.spacing300,
                vertical: CustomSpacing.spacing200,
              ),
              child: _buildDetailedIngredientContent(item),
            ),
          ),
          const SizedBox(height: CustomSpacing.spacing100),
          _buildReplaceButtonWithLabel(),
        ],
      ),
    );
  }

  Widget _buildDetailedIngredientContent(IngredientItem item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              item.name,
              style: textTheme.label.copyWith(
                color: colorTheme.contentStandardPrimary,
              ),
            ),
            Text(
              item.quantity,
              style: textTheme.label.copyWith(
                color: colorTheme.coreAccent,
              ),
            ),
          ],
        ),
        const SizedBox(height: CustomSpacing.spacing200),
        Text(
          '바지락은 조개류의 일종으로, 해산물 요리에 자주 사용됩니다. 단백질이 풍부하고 저지방 식품으로 건강한 식단에 적합한 식재료입니다.',
          style: textTheme.footnote.copyWith(
            color: colorTheme.contentStandardSecondary,
          ),
        ),
        const SizedBox(height: CustomSpacing.spacing200),
        ClipRRect(
          borderRadius: BorderRadius.circular(CustomRadius.radius300),
          child: Image.memory(
            height: 180,
            width: double.infinity,
            Uri.parse(controller.base64).data!.contentAsBytes(),
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  Widget _buildReplaceButton() {
    return CustomGestureDetectorWithOpacityInteraction(
      onTap: () => {},
      child: CustomGestureDetectorWithScaleInteraction(
        onTap: () => {},
        child: Container(
          decoration: _getReplaceButtonDecoration(),
          padding: const EdgeInsets.all(CustomSpacing.spacing200),
          child: Icon(
            Icons.restart_alt_rounded,
            color: colorTheme.contentStandardTertiary,
          ),
        ),
      ),
    );
  }

  Widget _buildReplaceButtonWithLabel() {
    return CustomGestureDetectorWithOpacityInteraction(
      onTap: () => {},
      child: CustomGestureDetectorWithScaleInteraction(
        onTap: () => {},
        child: Container(
          decoration: _getReplaceButtonDecoration(),
          padding: const EdgeInsets.all(CustomSpacing.spacing200),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.restart_alt_rounded,
                color: colorTheme.contentStandardTertiary,
              ),
              const SizedBox(width: CustomSpacing.spacing200),
              Text(
                '다른 식재료로 바꾸기',
                style: textTheme.label.copyWith(
                  color: colorTheme.contentStandardSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCookingStepsSection() {
    final cookingSteps = [
      CookingStep(
        stepNumber: 1,
        description:
            '먼저 국물용 멸치와 다시마를 사용해 10분간 끓여서 육수를 만듭니다. 다시마는 끓기 시작한 후에 제거합니다.',
        details:
            '오징어는 내장을 빼고 씻은 뒤, 몸통에 칼집을 내어 썰고 다리는 자릅니다. 새우는 머리와 껍질을 벗기고 내장을 제거한 후 씻습니다. 바지락은 씻어서 소금물에 담가 해감하고, 열린 껍데기는 버립니다. 이렇게 준비한 해산물로 요리하면 신선한 맛을 즐길 수 있습니다.',
        imageBase64: controller.base64,
      ),
      CookingStep(
        stepNumber: 2,
        description:
            '오징어는 내장을 빼고 씻은 뒤, 몸통에 칼집을 내어 썰고 다리는 자릅니다. 새우는 머리와 껍질을 벗기고 내장을 제거한 후 씻습니다. 바지락은 씻어서 소금물에 담가 해감하고, 열린 껍데기는 버립니다. 이렇게 준비한 해산물로 요리하면 신선한 맛을 즐길 수 있습니다.',
        imageBase64: controller.base64,
      ),
      CookingStep(
        stepNumber: 3,
        description: '양배추, 양파, 대파, 청양고추, 마늘을 얇게 썰어 준비합니다.',
        imageBase64: controller.base64,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '조리법',
          style: textTheme.heading.copyWith(
            color: colorTheme.contentStandardPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: CustomSpacing.spacing100),
        Text(
          '조리법 단계를 눌러 더 자세한 정보와 이미지를 볼 수 있어요',
          style: textTheme.footnote.copyWith(
            color: colorTheme.contentStandardTertiary,
          ),
        ),
        const SizedBox(height: CustomSpacing.spacing400),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: cookingSteps.length,
          separatorBuilder: (context, index) =>
              const SizedBox(height: CustomSpacing.spacing200),
          itemBuilder: (context, index) =>
              _buildCookingStepItem(cookingSteps[index]),
        ),
      ],
    );
  }

  Widget _buildCookingStepItem(CookingStep step) {
    if (step.stepNumber == 1) {
      return _buildDetailedCookingStep(step);
    }
    return _buildSimpleCookingStep(step);
  }

  Widget _buildSimpleCookingStep(CookingStep step) {
    return CustomGestureDetectorWithScaleInteraction(
      onTap: () => {},
      child: CustomGestureDetectorWithOpacityInteraction(
          onTap: () => {},
          child: Container(
            decoration: _getStepContainerDecoration(),
            child: Padding(
              padding: const EdgeInsets.all(CustomSpacing.spacing300),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildStepNumber(step.stepNumber),
                  const SizedBox(width: CustomSpacing.spacing300),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          step.description,
                          style: textTheme.footnote.copyWith(
                            color: colorTheme.contentStandardSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Widget _buildDetailedCookingStep(CookingStep step) {
    return Container(
      decoration: _getStepContainerDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(CustomSpacing.spacing300),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStepNumber(step.stepNumber),
            const SizedBox(width: CustomSpacing.spacing300),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step.details ?? '',
                    style: textTheme.footnote.copyWith(
                      color: colorTheme.contentStandardSecondary,
                    ),
                    softWrap: true,
                  ),
                  const SizedBox(height: CustomSpacing.spacing300),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(CustomRadius.radius300),
                    child: Image.memory(
                      height: 180,
                      width: double.infinity,
                      Uri.parse(step.imageBase64).data!.contentAsBytes(),
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepNumber(int number) {
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        color: colorTheme.coreAccentTranslucent,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          number.toString(),
          style: textTheme.caption
              .copyWith(color: colorTheme.contentStandardSecondary),
        ),
      ),
    );
  }

  BoxDecoration _getIngredientContainerDecoration() {
    return BoxDecoration(
      color: colorTheme.componentsFillStandardPrimary,
      borderRadius: BorderRadius.circular(CustomRadius.radius300),
      border: Border.all(color: colorTheme.lineOutline),
    );
  }

  BoxDecoration _getReplaceButtonDecoration() {
    return BoxDecoration(
      color: colorTheme.coreAccentTranslucent,
      borderRadius: BorderRadius.circular(CustomRadius.radius300),
      border: Border.all(color: colorTheme.lineOutline),
    );
  }

  BoxDecoration _getStepContainerDecoration() {
    return BoxDecoration(
      color: colorTheme.componentsFillStandardPrimary,
      borderRadius: BorderRadius.circular(CustomRadius.radius300),
      border: Border.all(color: colorTheme.lineOutline),
    );
  }
}

class NutritionItem {
  final String icon;
  final String label;

  NutritionItem(this.icon, this.label);
}

class IngredientItem {
  final String name;
  final String quantity;
  final bool hasDetails;

  IngredientItem(this.name, this.quantity, this.hasDetails);
}

class CookingStep {
  final int stepNumber;
  final String description;
  final String? details;
  final String imageBase64;

  CookingStep({
    required this.stepNumber,
    required this.description,
    this.details,
    required this.imageBase64,
  });
}
