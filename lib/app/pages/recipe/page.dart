import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../core/theme/colors.dart';
import '../../core/theme/static.dart';
import '../../core/theme/typography.dart';
import '../../services/recipe/model.dart';
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
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.errorMessage.value.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(controller.errorMessage.value),
                  ElevatedButton(
                    onPressed: controller.loadRecipe,
                    child: const Text('다시 시도'),
                  ),
                ],
              ),
            );
          }

          if (controller.recipe.value == null) {
            return const Center(child: Text('레시피 정보가 없습니다.'));
          }

          return SingleChildScrollView(
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
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorTheme.coreAccent,
        onPressed: controller.chatButtonTap,
        child: Image.asset(
          'assets/images/chef_logo.png',
          width: 24,
          height: 24,
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
    final recipe = controller.recipe.value!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                recipe.name,
                style: textTheme.title.copyWith(
                  color: colorTheme.contentStandardPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _buildCookingTime(recipe.cookTime),
          ],
        ),
        const SizedBox(height: CustomSpacing.spacing400),
        Text(
          recipe.description,
          style: textTheme.body.copyWith(
            color: colorTheme.contentStandardSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildCookingTime(String cookTime) {
    return Row(
      children: [
        Icon(Icons.schedule_rounded,
            color: colorTheme.contentStandardSecondary),
        const SizedBox(width: CustomSpacing.spacing150),
        Text(
          cookTime,
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
    final nutrition = controller.recipe.value!.nutrition;
    final nutritionItems = [
      NutritionItem('carbs', '탄수화물 ${nutrition.carbohydrates}'),
      NutritionItem('proteins', '단백질 ${nutrition.protein}'),
      NutritionItem('fats', '지방 ${nutrition.fat}'),
      NutritionItem('calories', '${nutrition.calories}kcal'),
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
    return Obx(() {
      final ingredients =
          controller.recipe.value!.ingredients.map((ingredient) {
        return IngredientItem(
          ingredient.name,
          '${ingredient.amount}${ingredient.unit}',
          controller.expandedIngredients[ingredient.name] ?? false,
        );
      }).toList();

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
    });
  }

  Widget _buildReplaceButton(IngredientItem item, {bool isExpanded = false}) {
    return Obx(() {
      final isReplacing = controller.replacingIngredients[item.name] ?? false;

      return CustomGestureDetectorWithOpacityInteraction(
        onTap:
            isReplacing ? null : () => controller.replaceIngredient(item.name),
        child: Container(
          width: isExpanded ? double.infinity : null,
          decoration: _getReplaceButtonDecoration(),
          padding: const EdgeInsets.all(CustomSpacing.spacing200),
          child: isReplacing
              ? Row(
                  mainAxisAlignment: isExpanded
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          colorTheme.contentStandardTertiary,
                        ),
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: isExpanded
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.restart_alt_rounded,
                      color: colorTheme.contentStandardTertiary,
                    ),
                    if (isExpanded) ...[
                      const SizedBox(width: CustomSpacing.spacing200),
                      Text(
                        '다른 식재료로 바꾸기',
                        style: textTheme.label.copyWith(
                          color: colorTheme.contentStandardSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
        ),
      );
    });
  }

  Widget _buildIngredientItem(IngredientItem item) {
    if (item.hasDetails) {
      return Column(
        children: [
          CustomGestureDetectorWithScaleInteraction(
            onTap: () => controller.toggleIngredientDetails(item.name),
            child: Container(
              decoration: _getIngredientContainerDecoration(),
              padding: const EdgeInsets.symmetric(
                horizontal: CustomSpacing.spacing300,
                vertical: CustomSpacing.spacing200,
              ),
              child: Column(
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
                  _buildExpandedIngredientContent(item.name),
                ],
              ),
            ),
          ),
          const SizedBox(height: CustomSpacing.spacing100),
          _buildReplaceButton(item, isExpanded: true),
        ],
      );
    } else {
      return Row(
        children: [
          Expanded(
            child: CustomGestureDetectorWithScaleInteraction(
              onTap: () => controller.toggleIngredientDetails(item.name),
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
          ),
          const SizedBox(width: CustomSpacing.spacing100),
          _buildReplaceButton(item),
        ],
      );
    }
  }

  Widget _buildExpandedIngredientContent(String ingredientName) {
    final details = controller.ingredientDetails[ingredientName];
    final imageBase64 = controller.ingredientImages[ingredientName];
    final replacementInfo = controller.replacementDetails[ingredientName];

    if (details == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          details.description,
          style: textTheme.footnote.copyWith(
            color: colorTheme.contentStandardSecondary,
          ),
        ),
        if (imageBase64 != null) ...[
          const SizedBox(height: CustomSpacing.spacing200),
          ClipRRect(
            borderRadius: BorderRadius.circular(CustomRadius.radius300),
            child: Image.memory(
              height: 180,
              width: double.infinity,
              Uri.parse(imageBase64).data!.contentAsBytes(),
              fit: BoxFit.cover,
            ),
          ),
        ],
        if (replacementInfo != null) ...[
          const SizedBox(height: CustomSpacing.spacing200),
          Container(
            width: double.infinity,
            decoration: _getReplacementInfoDecoration(),
            padding: const EdgeInsets.all(CustomSpacing.spacing300),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '대체 재료 정보',
                  style: textTheme.label.copyWith(
                    color: colorTheme.contentStandardPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: CustomSpacing.spacing200),
                Text(
                  replacementInfo,
                  style: textTheme.footnote.copyWith(
                    color: colorTheme.contentStandardSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildCookingStepsSection() {
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
        _buildCookingStepsList(),
      ],
    );
  }

  Widget _buildCookingStepsList() {
    return Obx(() {
      final instructions = controller.recipe.value!.instructions;

      return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: instructions.length,
        separatorBuilder: (context, index) =>
            const SizedBox(height: CustomSpacing.spacing200),
        itemBuilder: (context, index) {
          final instruction = instructions[index];
          return _buildCookingStepItem(instruction);
        },
      );
    });
  }

  Widget _buildCookingStepItem(Instruction instruction) {
    return Obx(() {
      final isExpanded = controller.expandedSteps[instruction.step] ?? false;
      final isLoading = controller.loadingSteps[instruction.step] ?? false;
      final details = controller.stepDetails[instruction.step];
      final imageBase64 = controller.stepImages[instruction.step];

      return CustomGestureDetectorWithScaleInteraction(
        onTap: () => controller.toggleStepDetails(instruction.step),
        child: Container(
          decoration: _getStepContainerDecoration(),
          padding: const EdgeInsets.all(CustomSpacing.spacing300),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStepNumber(instruction.step),
                  const SizedBox(width: CustomSpacing.spacing300),
                  Expanded(
                    child: Text(
                      instruction.description,
                      style: textTheme.footnote.copyWith(
                        color: colorTheme.contentStandardSecondary,
                      ),
                    ),
                  ),
                  const SizedBox(width: CustomSpacing.spacing200),
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: colorTheme.contentStandardTertiary,
                    size: 20,
                  ),
                ],
              ),
              if (isExpanded) ...[
                const SizedBox(height: CustomSpacing.spacing300),
                if (isLoading)
                  Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          colorTheme.contentStandardTertiary,
                        ),
                      ),
                    ),
                  )
                else if (details != null) ...[
                  Text(
                    details.description,
                    style: textTheme.footnote.copyWith(
                      color: colorTheme.contentStandardSecondary,
                    ),
                    softWrap: true,
                  ),
                  if (imageBase64 != null) ...[
                    const SizedBox(height: CustomSpacing.spacing300),
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(CustomRadius.radius300),
                      child: Image.memory(
                        height: 180,
                        width: double.infinity,
                        Uri.parse(imageBase64).data!.contentAsBytes(),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ],
              ],
            ],
          ),
        ),
      );
    });
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
          style: textTheme.caption.copyWith(
            color: colorTheme.contentStandardSecondary,
          ),
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

  BoxDecoration _getReplacementInfoDecoration() {
    return BoxDecoration(
      color: colorTheme.coreAccentTranslucent.withOpacity(0.1),
      borderRadius: BorderRadius.circular(CustomRadius.radius300),
      border: Border.all(color: colorTheme.coreAccent.withOpacity(0.3)),
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
