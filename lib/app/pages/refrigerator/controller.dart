import 'package:get/get.dart';

import '../../services/refrigerator/model.dart';
import '../../services/refrigerator/service.dart';

class RefrigeratorPageController extends GetxController {
  final RefrigeratorService _service = Get.find<RefrigeratorService>();

  final selectedStorageIndex = 0.obs;
  final _items = Rxn<Map<String, List<Ingredient>>>();

  Map<String, List<Ingredient>> get currentItems {
    if (_items.value == null) return {};

    var filteredItems = <String, List<Ingredient>>{};
    StorageType targetType;

    switch (selectedStorageIndex.value) {
      case 0:
        targetType = StorageType.refrigerated;
        break;
      case 1:
        targetType = StorageType.frozen;
        break;
      case 2:
        targetType = StorageType.roomTemp;
        break;
      default:
        return {};
    }

    _items.value!.forEach((category, ingredients) {
      final filteredIngredients = ingredients
          .where((ingredient) => ingredient.storageType == targetType)
          .toList();
      if (filteredIngredients.isNotEmpty) {
        filteredItems[category] = filteredIngredients;
      }
    });

    return filteredItems;
  }

  StorageType get currentStorageType {
    switch (selectedStorageIndex.value) {
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

  @override
  void onInit() {
    super.onInit();
    fetchIngredients();
  }

  Future<void> fetchIngredients() async {
    final response = await _service.getIngredients();
    final categorizedItems = <String, List<Ingredient>>{};

    for (var category in response.refrigerator.categories) {
      categorizedItems[category.category] = category.ingredients;
    }

    _items.value = categorizedItems;
  }

  Future<void> refreshIngredients() async {
    await fetchIngredients();
  }

  Future<void> updateIngredient(
      String ingredientId, NewIngredient ingredient) async {
    await _service.updateIngredients(
      ingredientId: ingredientId,
      ingredient: ingredient,
    );
    await refreshIngredients();
  }

  Future<void> deleteIngredient(String ingredientId) async {
    await _service.deleteIngredients(ingredientId: ingredientId);
    await refreshIngredients();
  }

  Future<void> addIngredients(List<NewIngredient> ingredients) async {
    await _service.addIngredients(ingredients: ingredients);
    await refreshIngredients();
  }
}
