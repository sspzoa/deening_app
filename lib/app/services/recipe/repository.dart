import 'package:get/get.dart';

import '../../provider/api_interface.dart';
import '../../provider/model/response.dart';
import 'model.dart';

class RecipeRepository {
  final ApiProvider api;

  RecipeRepository({ApiProvider? api}) : api = api ?? Get.find<ApiProvider>();

  // 레시피 검색/생성
  Future<RecipeResponse> getRecipe({
    required String foodName,
    bool useRefrigerator = false,
  }) async {
    String url = '/recipe';

    Map<String, dynamic> data = {
      'food_name': foodName,
      'use_refrigerator': useRefrigerator,
    };

    CustomHttpResponse response = await api.post(url, data: data);
    final responseData = response.data;

    // Recipe 객체를 생성할 때 RecipeResponse의 id를 전달
    if (responseData['recipe'] is Map<String, dynamic>) {
      responseData['recipe']['id'] = responseData['id'];
    }

    return RecipeResponse.fromJson(responseData);
  }

  // 재료 정보 조회/생성
  Future<IngredientInfoResponse> getIngredientInfo({
    required String ingredientName,
  }) async {
    String url = '/recipe/ingredient-info';

    Map<String, dynamic> data = {
      'ingredient_name': ingredientName,
    };

    CustomHttpResponse response = await api.post(url, data: data);
    return IngredientInfoResponse.fromJson(response.data);
  }

  // 조리 단계 상세 정보 조회/생성
  Future<CookingStepResponse> getCookingStepInfo({
    required String recipeId,
    required int stepNumber,
  }) async {
    String url = '/recipe/cooking-step';

    Map<String, dynamic> data = {
      'recipe_id': recipeId,
      'step_number': stepNumber,
    };

    CustomHttpResponse response = await api.post(url, data: data);
    return CookingStepResponse.fromJson(response.data);
  }

  // 레시피 관련 질문 답변
  Future<String> chatWithRecipe({
    required String recipeId,
    required String question,
  }) async {
    String url = '/recipe/chat';

    Map<String, dynamic> data = {
      'recipe_id': recipeId,
      'question': question,
    };

    CustomHttpResponse response = await api.post(url, data: data);
    return response.data['answer'];
  }

  // 레시피 검색
  Future<RecipeSearchResponse> searchRecipes({
    required String query,
  }) async {
    String url = '/recipe/search';

    Map<String, dynamic> params = {
      'query': query,
    };

    CustomHttpResponse response = await api.get(url, queryParameters: params);
    return RecipeSearchResponse.fromJson(response.data);
  }

  // 재료 대체 추천
  Future<Map<String, String>> replaceIngredient({
    required String recipeId,
    required String ingredientName,
  }) async {
    String url = '/recipe/replace-ingredient';

    Map<String, dynamic> data = {
      'recipe_id': recipeId,
      'ingredient_name': ingredientName,
    };

    CustomHttpResponse response = await api.post(url, data: data);
    return {
      'replaced_ingredient': response.data['replaced_ingredient'],
      'taste_change_description': response.data['taste_change_description'],
    };
  }
}
