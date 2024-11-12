import 'package:get/get.dart';

import 'model.dart';
import 'repository.dart';

class RecipeService extends GetxController {
  final RecipeRepository repository;

  RecipeService({RecipeRepository? repository})
      : repository = repository ?? RecipeRepository();

  // 레시피 검색/생성
  Future<RecipeResponse> getRecipe({
    required String foodName,
    bool useRefrigerator = false,
  }) async {
    return await repository.getRecipe(
      foodName: foodName,
      useRefrigerator: useRefrigerator,
    );
  }

  // 재료 정보 조회/생성
  Future<IngredientInfoResponse> getIngredientInfo({
    required String ingredientName,
  }) async {
    return await repository.getIngredientInfo(
      ingredientName: ingredientName,
    );
  }

  // 조리 단계 상세 정보 조회/생성
  Future<CookingStepResponse> getCookingStepInfo({
    required String recipeId,
    required int stepNumber,
  }) async {
    return await repository.getCookingStepInfo(
      recipeId: recipeId,
      stepNumber: stepNumber,
    );
  }

  // 레시피 관련 질문 답변
  Future<String> chatWithRecipe({
    required String recipeId,
    required String question,
  }) async {
    return await repository.chatWithRecipe(
      recipeId: recipeId,
      question: question,
    );
  }

  // 레시피 검색
  Future<RecipeSearchResponse> searchRecipes({
    required String query,
  }) async {
    return await repository.searchRecipes(query: query);
  }

  // 재료 대체 추천
  Future<Map<String, String>> replaceIngredient({
    required String recipeId,
    required String ingredientName,
  }) async {
    return await repository.replaceIngredient(
      recipeId: recipeId,
      ingredientName: ingredientName,
    );
  }
}
