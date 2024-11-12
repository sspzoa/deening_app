import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../routes/routes.dart';

class FindRecipePageController extends GetxController {
  final isChecked = false.obs;
  final textController = TextEditingController();

  void findRecipe() {
    final recipeName = textController.text.trim();
    if (recipeName.isEmpty) return;

    Get.toNamed(
      Routes.RECIPE,
      arguments: {
        'foodName': recipeName,
        'useRefrigerator': isChecked.value,
      },
    );
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}
