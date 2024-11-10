import 'package:deening_app/app/core/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../core/theme/colors.dart';
import '../../core/theme/static.dart';
import '../../widgets/appBar.dart';
import '../../widgets/button.dart';
import 'controller.dart';

class FindRecipePage extends GetView<FindRecipePageController> {
  const FindRecipePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<CustomColors>()!;
    final textTheme = Theme.of(context).extension<CustomTypography>()!;
    return Scaffold(
      appBar: const CustomAppBar(
        title: '레시피 찾아보기',
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: CustomSpacing.spacing550,
              vertical: CustomSpacing.spacing1000),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/chef.svg',
                width: 256,
                height: 256,
              ),
              Column(
                children: [
                  Obx(() => Row(
                        children: [
                          Checkbox(
                            value: controller.isChecked.value,
                            onChanged: (value) {
                              controller.isChecked.value = value ?? false;
                            },
                            activeColor: colorTheme.coreAccent,
                          ),
                          Text(
                            '냉장고에 있는 식재료만 사용하기',
                            style: textTheme.label.copyWith(
                              color: colorTheme.contentStandardSecondary,
                            ),
                          ),
                        ],
                      )),
                  const SizedBox(height: CustomSpacing.spacing200),
                  TextField(
                    decoration: InputDecoration(
                      hintText: '요리 이름으로 찾아보세요',
                      hintStyle: textTheme.label.copyWith(
                        color: colorTheme.contentStandardTertiary,
                      ),
                      filled: true,
                      fillColor: colorTheme.componentsFillStandardPrimary,
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(CustomRadius.radius300),
                        borderSide: BorderSide(
                          color: colorTheme.lineOutline,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(CustomRadius.radius300),
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
                    text: '찾아보기',
                    onTap: () => {},
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
