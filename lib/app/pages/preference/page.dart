import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/colors.dart';
import '../../core/theme/static.dart';
import '../../core/theme/typography.dart';
import '../../services/preferece/model.dart';
import '../../widgets/appBar.dart';
import '../../widgets/button.dart';
import '../../widgets/gestureDetector.dart';
import 'controller.dart';

class PreferencePage extends GetView<PreferencePageController> {
  const PreferencePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<CustomColors>()!;
    final textTheme = Theme.of(context).extension<CustomTypography>()!;

    return Scaffold(
      appBar: CustomAppBar(
        title: '선호 키워드',
        actions: [
          Row(
            children: [
              CustomGestureDetectorWithOpacityInteraction(
                onTap: () =>
                    _showAddKeywordModal(context, colorTheme, textTheme),
                child: Icon(
                  Icons.add_rounded,
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
              Obx(() => PreferenceTypeSlider(
                    selectedIndex: controller.selectedPreferenceIndex.value,
                    onChanged: (index) =>
                        controller.selectedPreferenceIndex.value = index,
                    colorTheme: colorTheme,
                    textTheme: textTheme,
                  )),
              const SizedBox(height: CustomSpacing.spacing700),
              Expanded(
                child: Obx(() => KeywordsList(
                      keywords: controller.currentKeywords,
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

void _showAddKeywordModal(
  BuildContext context,
  CustomColors colorTheme,
  CustomTypography textTheme,
) {
  final controller = Get.find<PreferencePageController>();

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
            Text('키워드 입력하기',
                style: textTheme.heading.copyWith(
                  color: colorTheme.contentStandardPrimary,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: CustomSpacing.spacing200),
            Text('키워드를 입력해 취향에 맞는 레시피를 추천받으세요 ',
                style: textTheme.footnote.copyWith(
                  color: colorTheme.contentStandardTertiary,
                )),
            const Spacer(),
            TextField(
              controller: controller.keywordController,
              decoration: InputDecoration(
                hintText: '키워드를 입력하세요',
                hintStyle: textTheme.label.copyWith(
                  color: colorTheme.contentStandardTertiary,
                ),
                filled: true,
                fillColor: colorTheme.componentsFillStandardPrimary,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(CustomRadius.radius300),
                  borderSide: BorderSide(
                    color: colorTheme.lineOutline,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(CustomRadius.radius300),
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
            const SizedBox(height: CustomSpacing.spacing200),
            CustomButton(
              text: '추가하기',
              icon: Icons.mode_edit_outline_outlined,
              onTap: () {
                controller.addKeyword(controller.keywordController.text);
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: CustomSpacing.spacing550),
          ],
        ),
      );
    },
  );
}

class PreferenceTypeSlider extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onChanged;
  final CustomColors colorTheme;
  final CustomTypography textTheme;

  const PreferenceTypeSlider({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
    required this.colorTheme,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    final preferenceTypes = ['선호 키워드', '비선호 키워드'];

    return Container(
      decoration: BoxDecoration(
        color: colorTheme.componentsTranslucentPrimary,
        borderRadius: BorderRadius.circular(CustomRadius.radius400),
      ),
      padding: const EdgeInsets.all(CustomSpacing.spacing100),
      child: Row(
        children: List.generate(preferenceTypes.length, (index) {
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
                    preferenceTypes[index],
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

class KeywordItem extends StatelessWidget {
  final Keyword keyword;
  final CustomColors colorTheme;
  final CustomTypography textTheme;

  const KeywordItem({
    super.key,
    required this.keyword,
    required this.colorTheme,
    required this.textTheme,
  });

  void _showEditDialog(BuildContext context) {
    final controller = Get.find<PreferencePageController>();
    final editingController = TextEditingController(text: keyword.name);

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: colorTheme.backgroundStandardPrimary,
        child: Container(
          padding: const EdgeInsets.all(CustomSpacing.spacing550),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '키워드 수정하기',
                style: textTheme.heading.copyWith(
                  color: colorTheme.contentStandardPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: CustomSpacing.spacing550),
              TextField(
                controller: editingController,
                decoration: InputDecoration(
                  labelText: '키워드',
                  labelStyle: textTheme.footnote.copyWith(
                    color: colorTheme.contentStandardTertiary,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: colorTheme.lineOutline),
                    borderRadius: BorderRadius.circular(CustomRadius.radius300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: colorTheme.coreAccent),
                    borderRadius: BorderRadius.circular(CustomRadius.radius300),
                  ),
                ),
                style: textTheme.body.copyWith(
                  color: colorTheme.contentStandardPrimary,
                ),
              ),
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
                      onTap: () {
                        if (editingController.text.isNotEmpty) {
                          controller.updateKeyword(
                            keyword.id,
                            editingController.text,
                          );
                        }
                        Get.back();
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

  void _showDeleteConfirmationDialog() {
    final controller = Get.find<PreferencePageController>();

    Get.dialog(
      Dialog(
        backgroundColor: colorTheme.backgroundStandardPrimary,
        child: Container(
          padding: const EdgeInsets.all(CustomSpacing.spacing550),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '키워드를 삭제하시겠습니까?',
                style: textTheme.heading.copyWith(
                  color: colorTheme.contentStandardPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: CustomSpacing.spacing200),
              Text(
                '삭제된 키워드는 복구할 수 없습니다.',
                style: textTheme.footnote.copyWith(
                  color: colorTheme.contentStandardTertiary,
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
                        controller.deleteKeyword(keyword.id);
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
              child: Text(
                keyword.name,
                style: textTheme.label.copyWith(
                  color: colorTheme.contentStandardPrimary,
                ),
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
              child: Icon(
                Icons.edit_rounded,
                color: colorTheme.contentStandardTertiary,
              ),
            ),
          ),
          const SizedBox(width: CustomSpacing.spacing100),
          CustomGestureDetectorWithOpacityInteraction(
            onTap: () => _showDeleteConfirmationDialog(),
            child: Container(
              decoration: BoxDecoration(
                color: colorTheme.coreAccentTranslucent,
                borderRadius: BorderRadius.circular(CustomRadius.radius300),
                border: Border.all(
                  color: colorTheme.lineOutline,
                ),
              ),
              padding: const EdgeInsets.all(CustomSpacing.spacing200),
              child: const Icon(
                Icons.delete_outline_rounded,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class KeywordsList extends StatelessWidget {
  final List<Keyword> keywords;
  final CustomColors colorTheme;
  final CustomTypography textTheme;

  const KeywordsList({
    super.key,
    required this.keywords,
    required this.colorTheme,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    if (keywords.isEmpty) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(colorTheme.coreAccent),
        ),
      );
    }

    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: keywords.length,
      separatorBuilder: (context, index) =>
          const SizedBox(height: CustomSpacing.spacing200),
      itemBuilder: (context, index) {
        return KeywordItem(
          keyword: keywords[index],
          colorTheme: colorTheme,
          textTheme: textTheme,
        );
      },
    );
  }
}
