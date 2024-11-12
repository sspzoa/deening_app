import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/refrigerator/model.dart';
import '../../services/refrigerator/service.dart';

class AddIngredientsPageController extends GetxController {
  final RefrigeratorService _service = Get.find<RefrigeratorService>();

  final ingredients = <IngredientForm>[].obs;

  @override
  void onInit() {
    super.onInit();

    // 감지된 재료 목록 가져오기
    final List<String>? detectedIngredients = Get.arguments;

    if (detectedIngredients != null && detectedIngredients.isNotEmpty) {
      // 감지된 각 재료에 대해 폼 생성
      for (var ingredientName in detectedIngredients) {
        final form = IngredientForm();
        form.nameController.text = ingredientName;
        ingredients.add(form);
      }
    } else {
      // 감지된 재료가 없는 경우 빈 폼 하나 추가
      addNewForm();
    }
  }

  void addNewForm() {
    ingredients.add(IngredientForm());
  }

  StorageType getStorageType(int index) {
    switch (index) {
      case 0:
        return StorageType.refrigerated;
      case 1:
        return StorageType.frozen;
      case 2:
        return StorageType.roomTemp;
      default:
        return StorageType.refrigerated;
    }
  }

  Future<void> saveIngredients() async {
    final List<NewIngredient> newIngredients = ingredients.map((form) {
      return NewIngredient(
        name: form.nameController.text,
        category: form.categoryController.text,
        amount: double.parse(form.amountController.text),
        unit: form.unitController.text,
        storageType: getStorageType(form.selectedStorageIndex.value),
      );
    }).toList();

    await _service.addIngredients(ingredients: newIngredients);
    Get.back();
  }

  @override
  void onClose() {
    // 모든 컨트롤러 dispose
    for (var form in ingredients) {
      form.dispose();
    }
    super.onClose();
  }
}

class IngredientForm {
  final nameController = TextEditingController();
  final categoryController = TextEditingController();
  final amountController = TextEditingController();
  final unitController = TextEditingController();
  final selectedStorageIndex = 0.obs;

  void dispose() {
    nameController.dispose();
    categoryController.dispose();
    amountController.dispose();
    unitController.dispose();
  }
}
