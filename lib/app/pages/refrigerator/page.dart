import 'package:deening_app/app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/colors.dart';
import '../../core/theme/static.dart';
import '../../core/theme/typography.dart';
import '../../widgets/appBar.dart';
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
        child: Padding(
          padding: const EdgeInsets.all(CustomSpacing.spacing550),
          child: Column(
            children: [
              Obx(() => StorageTypeSlider(
                    selectedIndex: controller.selectedStorageIndex.value,
                    onChanged: (index) =>
                        controller.selectedStorageIndex.value = index,
                    colorTheme: colorTheme,
                    textTheme: textTheme,
                  )),
              const SizedBox(height: CustomSpacing.spacing700),
              Expanded(
                child: Obx(() => IngredientsList(
                      items: controller.currentItems,
                      colorTheme: colorTheme,
                      textTheme: textTheme,
                    )),
              ),
            ],
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
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: CustomSpacing.spacing550),
          child: Column(
            children: [
              Text('입력 방식 선택하기',
                  style: textTheme.heading.copyWith(
                    color: colorTheme.contentStandardPrimary,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(height: CustomSpacing.spacing200),
              Text('사용할 식재료를 입력할 방식을 선택해주세요.',
                  style: textTheme.footnote.copyWith(
                    color: colorTheme.contentStandardTertiary,
                  )),
              const Spacer(),
              CustomButton(
                text: '직접 입력하기',
                icon: Icons.mode_edit_outline_outlined,
                onTap: () => {},
              ),
              const SizedBox(height: CustomSpacing.spacing200),
              CustomButton(
                  text: '사진으로 입력하기',
                  icon: Icons.camera_alt_outlined,
                  onTap: () => {}),
            ],
          ),
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
    Key? key,
    required this.selectedIndex,
    required this.onChanged,
    required this.colorTheme,
    required this.textTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final storageTypes = ['냉장보관', '냉동보관', '상온 보관'];

    return Container(
      decoration: BoxDecoration(
        color: colorTheme.componentsTranslucentPrimary,
        borderRadius: BorderRadius.circular(CustomRadius.radius400),
      ),
      padding: const EdgeInsets.all(CustomSpacing.spacing100),
      child: Row(
        children: List.generate(storageTypes.length, (index) {
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
        }),
      ),
    );
  }
}

class IngredientsList extends StatelessWidget {
  final Map<String, List<Ingredient>> items;
  final CustomColors colorTheme;
  final CustomTypography textTheme;

  const IngredientsList({
    Key? key,
    required this.items,
    required this.colorTheme,
    required this.textTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(
        child: Text(
          '재료가 없습니다',
          style: textTheme.body.copyWith(
            color: colorTheme.contentStandardTertiary,
          ),
        ),
      );
    }

    return ListView.separated(
      physics: const BouncingScrollPhysics(),
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
                  name: item.name,
                  amount: item.amount,
                  colorTheme: colorTheme,
                  textTheme: textTheme,
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
  final String name;
  final String amount;
  final CustomColors colorTheme;
  final CustomTypography textTheme;

  const IngredientItem({
    Key? key,
    required this.name,
    required this.amount,
    required this.colorTheme,
    required this.textTheme,
  }) : super(key: key);

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
                    name,
                    style: textTheme.label.copyWith(
                      color: colorTheme.contentStandardPrimary,
                    ),
                  ),
                  Text(
                    amount,
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
            onTap: () => {},
            child: CustomGestureDetectorWithScaleInteraction(
              onTap: () => {},
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
            ),
          )
        ],
      ),
    );
  }
}
