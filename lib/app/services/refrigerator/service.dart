import 'package:deening_app/app/services/refrigerator/model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'repository.dart';

class RefrigeratorService extends GetxController {
  final RefrigeratorRepository repository;

  RefrigeratorService({RefrigeratorRepository? repository})
      : repository = repository ?? RefrigeratorRepository();

  Future<List<String>> detectIngredients({required XFile image}) async {
    return await repository.detectIngredients(file: image);
  }

  Future<RefrigeratorResponse> getIngredients() async {
    return await repository.getIngredients();
  }

  Future<void> addIngredients(
      {required List<NewIngredient> ingredients}) async {
    await repository.addIngredients(ingredients: ingredients);
  }

  Future<void> deleteIngredients({required String ingredientId}) async {
    await repository.deleteIngredients(ingredientId: ingredientId);
  }

  Future<void> updateIngredients(
      {required String ingredientId, required NewIngredient ingredient}) async {
    await repository.updateIngredients(
        ingredientId: ingredientId, ingredient: ingredient);
  }
}
