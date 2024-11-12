import 'package:get/get.dart';

import '../../routes/routes.dart';
import '../../services/recipe/model.dart';
import '../../services/recipe/service.dart';

class RecipePageController extends GetxController {
  final RecipeService _recipeService;

  final Rx<Recipe?> recipe = Rx<Recipe?>(null);
  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;
  final RxMap<String, bool> expandedIngredients = RxMap<String, bool>();
  final RxMap<int, bool> expandedSteps = RxMap<int, bool>();
  final RxMap<String, IngredientInfo?> ingredientDetails =
      RxMap<String, IngredientInfo?>();
  final RxMap<int, CookingStep?> stepDetails = RxMap<int, CookingStep?>();
  final RxMap<String, String> ingredientImages = RxMap<String, String>();
  final RxMap<int, String> stepImages = RxMap<int, String>();
  final RxMap<String, String> replacementDetails = RxMap<String, String>();
  final RxMap<String, bool> replacingIngredients = RxMap<String, bool>();
  final RxMap<int, bool> loadingSteps = RxMap<int, bool>();

  String base64 = '';
  late final String foodName = Get.arguments['foodName'] as String;
  late final bool useRefrigerator = Get.arguments['useRefrigerator'] as bool;

  RecipePageController({RecipeService? recipeService})
      : _recipeService = recipeService ?? RecipeService();

  @override
  void onInit() {
    super.onInit();
    loadRecipe();
  }

  Future<void> loadRecipe() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _recipeService.getRecipe(
        foodName: foodName,
        useRefrigerator: useRefrigerator,
      );

      recipe.value = response.recipe;
      base64 = response.imageBase64;

      for (var ingredient in response.recipe.ingredients) {
        expandedIngredients[ingredient.name] = false;
      }
      for (var instruction in response.recipe.instructions) {
        expandedSteps[instruction.step] = false;
      }
    } catch (e) {
      errorMessage.value = '레시피를 불러오는데 실패했습니다. 다시 시도해 주세요.';
      print('Error loading recipe: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> toggleIngredientDetails(String ingredientName) async {
    try {
      final currentState = expandedIngredients[ingredientName] ?? false;
      expandedIngredients[ingredientName] = !currentState;

      if (!currentState && ingredientDetails[ingredientName] == null) {
        final response = await _recipeService.getIngredientInfo(
          ingredientName: ingredientName,
        );
        ingredientDetails[ingredientName] = response.ingredient;
        ingredientImages[ingredientName] = response.imageBase64;
      }
    } catch (e) {
      print('Error loading ingredient details: $e');
      Get.snackbar(
        '오류',
        '재료 정보를 불러오는데 실패했습니다.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> toggleStepDetails(int stepNumber) async {
    try {
      if (recipe.value == null) return;

      final currentState = expandedSteps[stepNumber] ?? false;
      expandedSteps[stepNumber] = !currentState;

      if (!currentState && stepDetails[stepNumber] == null) {
        loadingSteps[stepNumber] = true;

        final response = await _recipeService.getCookingStepInfo(
          recipeId: recipe.value!.id,
          stepNumber: stepNumber,
        );

        stepDetails[stepNumber] = response.cookingStep;
        stepImages[stepNumber] = response.imageBase64;
      }
    } catch (e) {
      print('Error loading step details: $e');
      Get.snackbar(
        '오류',
        '조리 단계 정보를 불러오는데 실패했습니다.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      loadingSteps[stepNumber] = false;
    }
  }

  Future<void> replaceIngredient(String ingredientName) async {
    try {
      if (recipe.value == null) return;

      replacingIngredients[ingredientName] = true;

      final replacements = await _recipeService.replaceIngredient(
        recipeId: recipe.value!.id,
        ingredientName: ingredientName,
      );

      final replacedIngredient = replacements['replaced_ingredient'] ?? '';
      final tasteChangeDescription =
          replacements['taste_change_description'] ?? '';

      if (replacedIngredient.isNotEmpty) {
        replacementDetails[ingredientName] =
            '$replacedIngredient으로 대체하면 $tasteChangeDescription';

        final updatedIngredients = [...recipe.value!.ingredients];
        final index = updatedIngredients.indexWhere(
          (i) => i.name == ingredientName,
        );
        if (index != -1) {
          updatedIngredients[index] = Ingredient(
            name: replacedIngredient,
            amount: updatedIngredients[index].amount,
            unit: updatedIngredients[index].unit,
          );
          recipe.value = Recipe(
            id: recipe.value!.id,
            name: recipe.value!.name,
            description: recipe.value!.description,
            cookTime: recipe.value!.cookTime,
            nutrition: recipe.value!.nutrition,
            ingredients: updatedIngredients,
            instructions: recipe.value!.instructions,
          );

          expandedIngredients[replacedIngredient] = true;
          ingredientDetails[replacedIngredient] = IngredientInfo(
            name: replacedIngredient,
            description: tasteChangeDescription,
          );
        }
      }
    } catch (e) {
      print('Error replacing ingredient: $e');
      Get.snackbar(
        '오류',
        '대체 재료를 찾는데 실패했습니다.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      replacingIngredients[ingredientName] = false;
    }
  }

  void chatButtonTap() {
    Get.toNamed(Routes.CHAT, arguments: {
      'foodName': foodName,
      'recipeId': recipe.value!.id,
    });
  }
}
