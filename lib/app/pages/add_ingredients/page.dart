import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/colors.dart';
import '../../core/theme/static.dart';
import '../../core/theme/typography.dart';
import '../../widgets/appBar.dart';
import '../../widgets/button.dart';
import '../../widgets/gestureDetector.dart';
import '../refrigerator/page.dart';
import 'controller.dart';

class AddIngredientsPage extends GetView<AddIngredientsPageController> {
  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<CustomColors>()!;
    final textTheme = Theme.of(context).extension<CustomTypography>()!;

    return Scaffold(
      appBar: CustomAppBar(
        title: '식재료 입력하기',
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(CustomSpacing.spacing550),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Obx(() => Column(
                        children: [
                          ...controller.ingredients
                              .map((form) => _buildIngredientForm(
                                    form: form,
                                    colorTheme: colorTheme,
                                    textTheme: textTheme,
                                  ))
                              .toList(),
                          const SizedBox(height: CustomSpacing.spacing400),
                          _buildAddButton(colorTheme),
                        ],
                      )),
                ),
              ),
              CustomButton(
                text: '저장하기',
                onTap: controller.saveIngredients,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIngredientForm({
    required IngredientForm form,
    required CustomColors colorTheme,
    required CustomTypography textTheme,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: CustomSpacing.spacing400),
      decoration: BoxDecoration(
        border: Border.all(color: colorTheme.lineOutline),
        borderRadius: BorderRadius.circular(CustomRadius.radius600),
      ),
      padding: const EdgeInsets.all(CustomSpacing.spacing200),
      child: Column(
        children: [
          Obx(() => StorageTypeSlider(
                selectedIndex: form.selectedStorageIndex.value,
                onChanged: (index) => form.selectedStorageIndex.value = index,
                colorTheme: colorTheme,
                textTheme: textTheme,
              )),
          const SizedBox(height: CustomSpacing.spacing200),
          _buildTextField(
            controller: form.nameController,
            hintText: '식재료 이름',
            colorTheme: colorTheme,
            textTheme: textTheme,
          ),
          const SizedBox(height: CustomSpacing.spacing200),
          _buildTextField(
            controller: form.categoryController,
            hintText: '카테고리',
            colorTheme: colorTheme,
            textTheme: textTheme,
          ),
          const SizedBox(height: CustomSpacing.spacing200),
          _buildTextField(
            controller: form.amountController,
            hintText: '용량',
            keyboardType: TextInputType.number,
            colorTheme: colorTheme,
            textTheme: textTheme,
          ),
          const SizedBox(height: CustomSpacing.spacing200),
          _buildTextField(
            controller: form.unitController,
            hintText: '단위',
            colorTheme: colorTheme,
            textTheme: textTheme,
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType? keyboardType,
    required CustomColors colorTheme,
    required CustomTypography textTheme,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: textTheme.label.copyWith(
          color: colorTheme.contentStandardTertiary,
        ),
        filled: true,
        fillColor: colorTheme.componentsFillStandardPrimary,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(CustomRadius.radius300),
          borderSide: BorderSide(color: colorTheme.lineOutline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(CustomRadius.radius300),
          borderSide: BorderSide(color: colorTheme.coreAccent),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: CustomSpacing.spacing400,
          vertical: CustomSpacing.spacing300,
        ),
      ),
      style: textTheme.label.copyWith(
        color: colorTheme.contentStandardPrimary,
      ),
    );
  }

  Widget _buildAddButton(CustomColors colorTheme) {
    return CustomGestureDetectorWithOpacityInteraction(
      onTap: controller.addNewForm,
      child: CustomGestureDetectorWithScaleInteraction(
        onTap: controller.addNewForm,
        child: Container(
          padding: const EdgeInsets.all(CustomSpacing.spacing200),
          decoration: BoxDecoration(
            color: colorTheme.coreAccentTranslucent,
            borderRadius: BorderRadius.circular(CustomRadius.radiusFull),
          ),
          child: Icon(
            Icons.add_rounded,
            color: colorTheme.contentStandardSecondary,
          ),
        ),
      ),
    );
  }
}
