import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../services/refrigerator/model.dart';
import '../../services/refrigerator/service.dart';

class AddIngredientsPageController extends GetxController {
  final RefrigeratorService _service = Get.find<RefrigeratorService>();

  final ingredients = <IngredientForm>[].obs;

  @override
  void onInit() {
    super.onInit();
    // 초기 폼 하나 추가
    addNewForm();
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
