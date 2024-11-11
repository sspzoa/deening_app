import 'package:deening_app/app/widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/colors.dart';
import '../../core/theme/static.dart';
import '../../core/theme/typography.dart';
import '../../widgets/button.dart';
import '../../widgets/gestureDetector.dart';
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
          padding: EdgeInsets.all(CustomSpacing.spacing550),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: colorTheme.lineOutline,
                          ),
                          borderRadius:
                              BorderRadius.circular(CustomRadius.radius600),
                        ),
                        padding: const EdgeInsets.all(CustomSpacing.spacing200),
                        child: Column(
                          children: [
                            Obx(() => StorageTypeSlider(
                                  selectedIndex:
                                      controller.selectedStorageIndex.value,
                                  onChanged: (index) => controller
                                      .selectedStorageIndex.value = index,
                                  colorTheme: colorTheme,
                                  textTheme: textTheme,
                                )),
                            SizedBox(height: CustomSpacing.spacing200),
                            TextField(
                              decoration: InputDecoration(
                                hintText: '식재료 이름',
                                hintStyle: textTheme.label.copyWith(
                                  color: colorTheme.contentStandardTertiary,
                                ),
                                filled: true,
                                fillColor:
                                    colorTheme.componentsFillStandardPrimary,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      CustomRadius.radius300),
                                  borderSide: BorderSide(
                                    color: colorTheme.lineOutline,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      CustomRadius.radius300),
                                  borderSide: BorderSide(
                                    color: colorTheme.coreAccent,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: CustomSpacing.spacing400,
                                  vertical: CustomSpacing.spacing300,
                                ),
                              ),
                              style: textTheme.label.copyWith(
                                color: colorTheme.contentStandardPrimary,
                              ),
                            ),
                            SizedBox(height: CustomSpacing.spacing200),
                            TextField(
                              decoration: InputDecoration(
                                hintText: '카테고리',
                                hintStyle: textTheme.label.copyWith(
                                  color: colorTheme.contentStandardTertiary,
                                ),
                                filled: true,
                                fillColor:
                                    colorTheme.componentsFillStandardPrimary,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      CustomRadius.radius300),
                                  borderSide: BorderSide(
                                    color: colorTheme.lineOutline,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      CustomRadius.radius300),
                                  borderSide: BorderSide(
                                    color: colorTheme.coreAccent,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: CustomSpacing.spacing400,
                                  vertical: CustomSpacing.spacing300,
                                ),
                              ),
                              style: textTheme.label.copyWith(
                                color: colorTheme.contentStandardPrimary,
                              ),
                            ),
                            SizedBox(height: CustomSpacing.spacing200),
                            TextField(
                              decoration: InputDecoration(
                                hintText: '용량',
                                hintStyle: textTheme.label.copyWith(
                                  color: colorTheme.contentStandardTertiary,
                                ),
                                filled: true,
                                fillColor:
                                    colorTheme.componentsFillStandardPrimary,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      CustomRadius.radius300),
                                  borderSide: BorderSide(
                                    color: colorTheme.lineOutline,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      CustomRadius.radius300),
                                  borderSide: BorderSide(
                                    color: colorTheme.coreAccent,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: CustomSpacing.spacing400,
                                  vertical: CustomSpacing.spacing300,
                                ),
                              ),
                              style: textTheme.label.copyWith(
                                color: colorTheme.contentStandardPrimary,
                              ),
                            ),
                            SizedBox(height: CustomSpacing.spacing200),
                            TextField(
                              decoration: InputDecoration(
                                hintText: '단위',
                                hintStyle: textTheme.label.copyWith(
                                  color: colorTheme.contentStandardTertiary,
                                ),
                                filled: true,
                                fillColor:
                                    colorTheme.componentsFillStandardPrimary,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      CustomRadius.radius300),
                                  borderSide: BorderSide(
                                    color: colorTheme.lineOutline,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      CustomRadius.radius300),
                                  borderSide: BorderSide(
                                    color: colorTheme.coreAccent,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: CustomSpacing.spacing400,
                                  vertical: CustomSpacing.spacing300,
                                ),
                              ),
                              style: textTheme.label.copyWith(
                                color: colorTheme.contentStandardPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: CustomSpacing.spacing400),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: colorTheme.lineOutline,
                          ),
                          borderRadius:
                              BorderRadius.circular(CustomRadius.radius600),
                        ),
                        padding: const EdgeInsets.all(CustomSpacing.spacing200),
                        child: Column(
                          children: [
                            Obx(() => StorageTypeSlider(
                                  selectedIndex:
                                      controller.selectedStorageIndex.value,
                                  onChanged: (index) => controller
                                      .selectedStorageIndex.value = index,
                                  colorTheme: colorTheme,
                                  textTheme: textTheme,
                                )),
                            SizedBox(height: CustomSpacing.spacing200),
                            TextField(
                              decoration: InputDecoration(
                                hintText: '식재료 이름',
                                hintStyle: textTheme.label.copyWith(
                                  color: colorTheme.contentStandardTertiary,
                                ),
                                filled: true,
                                fillColor:
                                    colorTheme.componentsFillStandardPrimary,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      CustomRadius.radius300),
                                  borderSide: BorderSide(
                                    color: colorTheme.lineOutline,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      CustomRadius.radius300),
                                  borderSide: BorderSide(
                                    color: colorTheme.coreAccent,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: CustomSpacing.spacing400,
                                  vertical: CustomSpacing.spacing300,
                                ),
                              ),
                              style: textTheme.label.copyWith(
                                color: colorTheme.contentStandardPrimary,
                              ),
                            ),
                            SizedBox(height: CustomSpacing.spacing200),
                            TextField(
                              decoration: InputDecoration(
                                hintText: '카테고리',
                                hintStyle: textTheme.label.copyWith(
                                  color: colorTheme.contentStandardTertiary,
                                ),
                                filled: true,
                                fillColor:
                                    colorTheme.componentsFillStandardPrimary,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      CustomRadius.radius300),
                                  borderSide: BorderSide(
                                    color: colorTheme.lineOutline,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      CustomRadius.radius300),
                                  borderSide: BorderSide(
                                    color: colorTheme.coreAccent,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: CustomSpacing.spacing400,
                                  vertical: CustomSpacing.spacing300,
                                ),
                              ),
                              style: textTheme.label.copyWith(
                                color: colorTheme.contentStandardPrimary,
                              ),
                            ),
                            SizedBox(height: CustomSpacing.spacing200),
                            TextField(
                              decoration: InputDecoration(
                                hintText: '용량',
                                hintStyle: textTheme.label.copyWith(
                                  color: colorTheme.contentStandardTertiary,
                                ),
                                filled: true,
                                fillColor:
                                    colorTheme.componentsFillStandardPrimary,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      CustomRadius.radius300),
                                  borderSide: BorderSide(
                                    color: colorTheme.lineOutline,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      CustomRadius.radius300),
                                  borderSide: BorderSide(
                                    color: colorTheme.coreAccent,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: CustomSpacing.spacing400,
                                  vertical: CustomSpacing.spacing300,
                                ),
                              ),
                              style: textTheme.label.copyWith(
                                color: colorTheme.contentStandardPrimary,
                              ),
                            ),
                            SizedBox(height: CustomSpacing.spacing200),
                            TextField(
                              decoration: InputDecoration(
                                hintText: '단위',
                                hintStyle: textTheme.label.copyWith(
                                  color: colorTheme.contentStandardTertiary,
                                ),
                                filled: true,
                                fillColor:
                                    colorTheme.componentsFillStandardPrimary,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      CustomRadius.radius300),
                                  borderSide: BorderSide(
                                    color: colorTheme.lineOutline,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      CustomRadius.radius300),
                                  borderSide: BorderSide(
                                    color: colorTheme.coreAccent,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: CustomSpacing.spacing400,
                                  vertical: CustomSpacing.spacing300,
                                ),
                              ),
                              style: textTheme.label.copyWith(
                                color: colorTheme.contentStandardPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: CustomSpacing.spacing400),
                      CustomGestureDetectorWithOpacityInteraction(
                        onTap: () => {},
                        child: CustomGestureDetectorWithScaleInteraction(
                          onTap: () => {},
                          child: Container(
                            padding:
                                const EdgeInsets.all(CustomSpacing.spacing200),
                            decoration: BoxDecoration(
                              color: colorTheme.coreAccentTranslucent,
                              borderRadius: BorderRadius.circular(
                                  CustomRadius.radiusFull),
                            ),
                            child: Icon(
                              Icons.add_rounded,
                              color: colorTheme.contentStandardSecondary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              CustomButton(
                text: '저장하기',
                onTap: () => {},
              ),
            ],
          ),
        ),
      ),
    );
  }
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
