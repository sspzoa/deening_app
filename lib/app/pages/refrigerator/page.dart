import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/colors.dart';
import '../../core/theme/static.dart';
import '../../core/theme/typography.dart';
import '../../routes/routes.dart';
import '../../services/refrigerator/model.dart';
import '../../widgets/appBar.dart';
import '../../widgets/button.dart';
import '../../widgets/gestureDetector.dart';
import 'controller.dart';

class RefrigeratorPage extends GetView<RefrigeratorPageController> {
  const RefrigeratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<CustomColors>()!;
    final textTheme = Theme.of(context).extension<CustomTypography>()!;

    return Scaffold(
      appBar: CustomAppBar(
        title: '내 냉장고',
        actions: [
          Row(
            children: [
              CustomGestureDetectorWithOpacityInteraction(
                onTap: () =>
                    _showAddIngredientModal(context, colorTheme, textTheme),
                child: Icon(
                  Icons.add_rounded,
                  size: 24,
                  color: colorTheme.contentStandardSecondary,
                ),
              ),
              const SizedBox(width: CustomSpacing.spacing300),
              CustomGestureDetectorWithOpacityInteraction(
                onTap: () => {},
                child: Icon(
                  Icons.kitchen_rounded,
                  size: 24,
                  color: colorTheme.contentStandardSecondary,
                ),
              ),
              const SizedBox(width: CustomSpacing.spacing550),
            ],
          )
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: controller.refreshIngredients,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              CustomSpacing.spacing550,
              CustomSpacing.spacing550,
              CustomSpacing.spacing550,
              0,
            ),
            child: Column(
              children: [
                Obx(
                  () => StorageTypeSlider(
                    selectedIndex: controller.selectedStorageIndex.value,
                    onChanged: (index) =>
                        controller.selectedStorageIndex.value = index,
                    colorTheme: colorTheme,
                    textTheme: textTheme,
                  ),
                ),
                const SizedBox(height: CustomSpacing.spacing700),
                Expanded(
                  child: Obx(
                    () => IngredientsList(
                      items: controller.currentItems,
                      colorTheme: colorTheme,
                      textTheme: textTheme,
                      controller: controller,
                    ),
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

void _showAddIngredientModal(
  BuildContext context,
  CustomColors colorTheme,
  CustomTypography textTheme,
) {
  showModalBottomSheet(
    context: context,
    showDragHandle: true,
    backgroundColor: colorTheme.backgroundStandardPrimary,
    constraints: BoxConstraints(
      maxHeight: MediaQuery.of(context).size.height * 0.4,
    ),
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(CustomSpacing.spacing550),
        width: double.infinity,
        child: Column(
          children: [
            Text(
              '입력 방식 선택하기',
              style: textTheme.heading.copyWith(
                color: colorTheme.contentStandardPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: CustomSpacing.spacing200),
            Text(
              '사용할 식재료를 입력할 방식을 선택해주세요.',
              style: textTheme.footnote.copyWith(
                color: colorTheme.contentStandardTertiary,
              ),
            ),
            const Spacer(),
            CustomButton(
              text: '직접 입력하기',
              icon: Icons.mode_edit_outline_outlined,
              onTap: () => {Get.back(), Get.toNamed(Routes.ADD_INGREDIENTS)},
            ),
            const SizedBox(height: CustomSpacing.spacing200),
            CustomButton(
              text: '사진으로 입력하기',
              icon: Icons.camera_alt_outlined,
              onTap: () => {},
            ),
            const SizedBox(height: CustomSpacing.spacing550),
          ],
        ),
      );
    },
  );
}

class StorageTypeSlider extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onChanged;
  final CustomColors colorTheme;
  final CustomTypography textTheme;

  const StorageTypeSlider({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
    required this.colorTheme,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    final storageTypes = ['냉장보관', '냉동보관', '상온보관'];

    return Container(
      decoration: BoxDecoration(
        color: colorTheme.componentsTranslucentPrimary,
        borderRadius: BorderRadius.circular(CustomRadius.radius400),
      ),
      padding: const EdgeInsets.all(CustomSpacing.spacing100),
      child: Row(
        children: List.generate(
          storageTypes.length,
          (index) {
            final isSelected = selectedIndex == index;
            return Expanded(
              child: CustomGestureDetectorWithOpacityInteraction(
                onTap: () => onChanged(index),
                child: Container(
                  margin: EdgeInsets.only(
                    left: index == 0 ? 0 : CustomSpacing.spacing100,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? colorTheme.backgroundStandardPrimary
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(CustomRadius.radius300),
                  ),
                  height: 40,
                  child: Center(
                    child: Text(
                      storageTypes[index],
                      style: textTheme.label.copyWith(
                        color: isSelected
                            ? colorTheme.contentStandardPrimary
                            : colorTheme.contentStandardQuaternary,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class IngredientsList extends StatelessWidget {
  final Map<String, List<Ingredient>> items;
  final CustomColors colorTheme;
  final CustomTypography textTheme;
  final RefrigeratorPageController controller;

  const IngredientsList({
    super.key,
    required this.items,
    required this.colorTheme,
    required this.textTheme,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(colorTheme.coreAccent),
        ),
      );
    }

    return ListView.separated(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      itemCount: items.length,
      separatorBuilder: (context, index) =>
          const SizedBox(height: CustomSpacing.spacing700),
      itemBuilder: (context, index) {
        final category = items.keys.elementAt(index);
        final categoryItems = items[category]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category,
              style: textTheme.heading.copyWith(
                color: colorTheme.contentStandardPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: CustomSpacing.spacing400),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: categoryItems.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: CustomSpacing.spacing200),
              itemBuilder: (context, index) {
                final item = categoryItems[index];
                return IngredientItem(
                  ingredient: item,
                  colorTheme: colorTheme,
                  textTheme: textTheme,
                  onEdit: (newIngredient) =>
                      controller.updateIngredient(item.id, newIngredient),
                  onDelete: () => controller.deleteIngredient(item.id),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class IngredientItem extends StatelessWidget {
  final Ingredient ingredient;
  final CustomColors colorTheme;
  final CustomTypography textTheme;
  final Function(NewIngredient) onEdit;
  final Function() onDelete;

  const IngredientItem({
    super.key,
    required this.ingredient,
    required this.colorTheme,
    required this.textTheme,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: colorTheme.componentsFillStandardPrimary,
                borderRadius: BorderRadius.circular(CustomRadius.radius300),
                border: Border.all(
                  color: colorTheme.lineOutline,
                ),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: CustomSpacing.spacing300,
                vertical: CustomSpacing.spacing200,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    ingredient.name,
                    style: textTheme.label.copyWith(
                      color: colorTheme.contentStandardPrimary,
                    ),
                  ),
                  Text(
                    '${ingredient.amount}${ingredient.unit}',
                    style: textTheme.label.copyWith(
                      color: colorTheme.coreAccent,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: CustomSpacing.spacing100),
          CustomGestureDetectorWithOpacityInteraction(
            onTap: () => _showEditDialog(context),
            child: Container(
              decoration: BoxDecoration(
                color: colorTheme.coreAccentTranslucent,
                borderRadius: BorderRadius.circular(CustomRadius.radius300),
                border: Border.all(
                  color: colorTheme.lineOutline,
                ),
              ),
              padding: const EdgeInsets.all(CustomSpacing.spacing200),
              child: Center(
                child: Icon(
                  Icons.edit_rounded,
                  color: colorTheme.contentStandardTertiary,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => IngredientEditDialog(
        ingredient: ingredient,
        onEdit: onEdit,
        onDelete: onDelete,
        colorTheme: colorTheme,
        textTheme: textTheme,
      ),
    );
  }
}

class IngredientEditDialog extends StatefulWidget {
  final Ingredient ingredient;
  final Function(NewIngredient) onEdit;
  final Function() onDelete;
  final CustomColors colorTheme;
  final CustomTypography textTheme;

  const IngredientEditDialog({
    super.key,
    required this.ingredient,
    required this.onEdit,
    required this.onDelete,
    required this.colorTheme,
    required this.textTheme,
  });

  @override
  State<IngredientEditDialog> createState() => _IngredientEditDialogState();
}

class _IngredientEditDialogState extends State<IngredientEditDialog> {
  late TextEditingController _nameController;
  late TextEditingController _amountController;
  late TextEditingController _unitController;
  late String _selectedCategory;
  late StorageType _selectedStorageType;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.ingredient.name);
    _amountController =
        TextEditingController(text: widget.ingredient.amount.toString());
    _unitController = TextEditingController(text: widget.ingredient.unit);
    _selectedCategory = widget.ingredient.category;
    _selectedStorageType = widget.ingredient.storageType;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _unitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: widget.colorTheme.backgroundStandardPrimary,
      child: Container(
        padding: const EdgeInsets.all(CustomSpacing.spacing550),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '재료 수정하기',
              style: widget.textTheme.heading.copyWith(
                color: widget.colorTheme.contentStandardPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: CustomSpacing.spacing550),
            _buildTextField(
              controller: _nameController,
              label: '재료명',
            ),
            const SizedBox(height: CustomSpacing.spacing300),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: _buildTextField(
                    controller: _amountController,
                    label: '수량',
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: CustomSpacing.spacing300),
                Expanded(
                  child: _buildTextField(
                    controller: _unitController,
                    label: '단위',
                  ),
                ),
              ],
            ),
            const SizedBox(height: CustomSpacing.spacing300),
            _buildStorageTypeSelector(),
            const SizedBox(height: CustomSpacing.spacing550),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: '삭제하기',
                    onTap: () {
                      Get.back();
                      _showDeleteConfirmationDialog();
                    },
                  ),
                ),
                const SizedBox(width: CustomSpacing.spacing300),
                Expanded(
                  child: CustomButton(
                    text: '수정하기',
                    onTap: _handleEdit,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: widget.textTheme.body.copyWith(
        color: widget.colorTheme.contentStandardPrimary,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: widget.textTheme.footnote.copyWith(
          color: widget.colorTheme.contentStandardTertiary,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.colorTheme.lineOutline),
          borderRadius: BorderRadius.circular(CustomRadius.radius300),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.colorTheme.coreAccent),
          borderRadius: BorderRadius.circular(CustomRadius.radius300),
        ),
      ),
    );
  }

  Widget _buildStorageTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '보관 방법',
          style: widget.textTheme.footnote.copyWith(
            color: widget.colorTheme.contentStandardTertiary,
          ),
        ),
        const SizedBox(height: CustomSpacing.spacing200),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: widget.colorTheme.lineOutline),
            borderRadius: BorderRadius.circular(CustomRadius.radius300),
          ),
          padding: const EdgeInsets.all(CustomSpacing.spacing200),
          child: Row(
            children: StorageType.values.map((type) {
              final isSelected = type == _selectedStorageType;
              String label;
              switch (type) {
                case StorageType.refrigerated:
                  label = '냉장';
                  break;
                case StorageType.frozen:
                  label = '냉동';
                  break;
                case StorageType.roomTemp:
                  label = '상온';
                  break;
              }
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _selectedStorageType = type),
                  child: Container(
                    padding: const EdgeInsets.all(CustomSpacing.spacing200),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? widget.colorTheme.coreAccent
                          : Colors.transparent,
                      borderRadius:
                          BorderRadius.circular(CustomRadius.radius200),
                    ),
                    child: Center(
                      child: Text(
                        label,
                        style: widget.textTheme.label.copyWith(
                          color: isSelected
                              ? widget.colorTheme.backgroundStandardPrimary
                              : widget.colorTheme.contentStandardPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  void _handleEdit() {
    final newIngredient = NewIngredient(
      name: _nameController.text,
      amount: double.parse(_amountController.text),
      unit: _unitController.text,
      category: _selectedCategory,
      storageType: _selectedStorageType,
    );
    Get.back();
    widget.onEdit(newIngredient);
  }

  void _showDeleteConfirmationDialog() {
    Get.dialog(
      Dialog(
        backgroundColor: widget.colorTheme.backgroundStandardPrimary,
        child: Container(
          padding: const EdgeInsets.all(CustomSpacing.spacing550),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '재료를 삭제하시겠습니까?',
                style: widget.textTheme.heading.copyWith(
                  color: widget.colorTheme.contentStandardPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: CustomSpacing.spacing200),
              Text(
                '삭제된 재료는 복구할 수 없습니다.',
                style: widget.textTheme.footnote.copyWith(
                  color: widget.colorTheme.contentStandardTertiary,
                ),
              ),
              const SizedBox(height: CustomSpacing.spacing550),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: '취소',
                      onTap: () => Get.back(),
                    ),
                  ),
                  const SizedBox(width: CustomSpacing.spacing300),
                  Expanded(
                    child: CustomButton(
                      text: '삭제',
                      onTap: () {
                        Get.back();
                        widget.onDelete();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
