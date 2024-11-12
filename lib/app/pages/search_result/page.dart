import 'package:deening_app/app/core/theme/static.dart';
import 'package:deening_app/app/core/theme/typography.dart';
import 'package:deening_app/app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/colors.dart';
import '../../routes/routes.dart';
import '../../widgets/appBar.dart';
import '../../widgets/gestureDetector.dart';
import 'controller.dart';

class SearchResultPage extends GetView<SearchResultPageController> {
  const SearchResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<CustomColors>()!;
    final textTheme = Theme.of(context).extension<CustomTypography>()!;

    return Scaffold(
      appBar: const CustomAppBar(title: '레시피 검색 결과'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(CustomSpacing.spacing550,
              CustomSpacing.spacing550, CustomSpacing.spacing550, 0),
          child: Column(
            children: [
              CustomButton(
                text: "새로운 레시피 찾아보기",
                onTap: () => Get.toNamed(Routes.FIND_RECIPE),
              ),
              const SizedBox(height: CustomSpacing.spacing400),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.searchResults.isEmpty) {
                    return Center(
                      child: Text(
                        '검색 결과가 없습니다',
                        style: textTheme.body,
                      ),
                    );
                  }

                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: controller.searchResults.map((recipe) {
                        return Column(
                          children: [
                            RecipeCard(
                              imageBase64: recipe.imageBase64,
                              title: recipe.name,
                              colorTheme: colorTheme,
                              textTheme: textTheme,
                              onTap: () => controller.onRecipeTap(recipe.name),
                            ),
                            const SizedBox(height: CustomSpacing.spacing400),
                          ],
                        );
                      }).toList(),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RecipeCard extends StatelessWidget {
  final String imageBase64;
  final String title;
  final CustomColors colorTheme;
  final CustomTypography textTheme;
  final VoidCallback onTap;

  const RecipeCard({
    super.key,
    required this.imageBase64,
    required this.title,
    required this.colorTheme,
    required this.textTheme,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomGestureDetectorWithOpacityInteraction(
      onTap: () => {},
      child: CustomGestureDetectorWithScaleInteraction(
        onTap: onTap,
        child: Stack(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(CustomRadius.radius300),
                border: Border.all(color: colorTheme.lineOutline),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(CustomRadius.radius300),
                child: Image.memory(
                  Uri.parse(imageBase64).data!.contentAsBytes(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(CustomRadius.radius300),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    colorTheme.coreAccentTranslucent,
                    colorTheme.contentStandardPrimary,
                  ],
                ),
              ),
            ),
            Container(
              height: 250,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: CustomSpacing.spacing550,
                horizontal: CustomSpacing.spacing400,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    title,
                    style: textTheme.title.copyWith(
                      color: colorTheme.contentInvertedPrimary,
                      fontWeight: FontWeight.bold,
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
}
