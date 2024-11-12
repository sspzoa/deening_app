// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeResponse _$RecipeResponseFromJson(Map<String, dynamic> json) =>
    RecipeResponse(
      id: json['id'] as String,
      recipe: Recipe.fromJson(json['recipe'] as Map<String, dynamic>),
      imageBase64: json['image_base64'] as String,
    );

Map<String, dynamic> _$RecipeResponseToJson(RecipeResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'recipe': instance.recipe,
      'image_base64': instance.imageBase64,
    };

Recipe _$RecipeFromJson(Map<String, dynamic> json) => Recipe(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      cookTime: json['cookTime'] as String,
      nutrition: Nutrition.fromJson(json['nutrition'] as Map<String, dynamic>),
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((e) => Ingredient.fromJson(e as Map<String, dynamic>))
          .toList(),
      instructions: (json['instructions'] as List<dynamic>)
          .map((e) => Instruction.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RecipeToJson(Recipe instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'cookTime': instance.cookTime,
      'nutrition': instance.nutrition,
      'ingredients': instance.ingredients,
      'instructions': instance.instructions,
    };

Nutrition _$NutritionFromJson(Map<String, dynamic> json) => Nutrition(
      calories: (json['calories'] as num).toInt(),
      protein: json['protein'] as String,
      carbohydrates: json['carbohydrates'] as String,
      fat: json['fat'] as String,
    );

Map<String, dynamic> _$NutritionToJson(Nutrition instance) => <String, dynamic>{
      'calories': instance.calories,
      'protein': instance.protein,
      'carbohydrates': instance.carbohydrates,
      'fat': instance.fat,
    };

Ingredient _$IngredientFromJson(Map<String, dynamic> json) => Ingredient(
      name: json['name'] as String,
      amount: (json['amount'] as num).toDouble(),
      unit: json['unit'] as String,
    );

Map<String, dynamic> _$IngredientToJson(Ingredient instance) =>
    <String, dynamic>{
      'name': instance.name,
      'amount': instance.amount,
      'unit': instance.unit,
    };

Instruction _$InstructionFromJson(Map<String, dynamic> json) => Instruction(
      step: (json['step'] as num).toInt(),
      description: json['description'] as String,
    );

Map<String, dynamic> _$InstructionToJson(Instruction instance) =>
    <String, dynamic>{
      'step': instance.step,
      'description': instance.description,
    };

IngredientInfoResponse _$IngredientInfoResponseFromJson(
        Map<String, dynamic> json) =>
    IngredientInfoResponse(
      id: json['id'] as String,
      ingredient:
          IngredientInfo.fromJson(json['ingredient'] as Map<String, dynamic>),
      imageBase64: json['image_base64'] as String,
    );

Map<String, dynamic> _$IngredientInfoResponseToJson(
        IngredientInfoResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ingredient': instance.ingredient,
      'image_base64': instance.imageBase64,
    };

IngredientInfo _$IngredientInfoFromJson(Map<String, dynamic> json) =>
    IngredientInfo(
      name: json['name'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$IngredientInfoToJson(IngredientInfo instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
    };

CookingStepResponse _$CookingStepResponseFromJson(Map<String, dynamic> json) =>
    CookingStepResponse(
      id: json['id'] as String,
      cookingStep:
          CookingStep.fromJson(json['cooking_step'] as Map<String, dynamic>),
      imageBase64: json['image_base64'] as String,
    );

Map<String, dynamic> _$CookingStepResponseToJson(
        CookingStepResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cooking_step': instance.cookingStep,
      'image_base64': instance.imageBase64,
    };

CookingStep _$CookingStepFromJson(Map<String, dynamic> json) => CookingStep(
      recipeId: json['recipe_id'] as String,
      stepNumber: (json['step_number'] as num).toInt(),
      description: json['description'] as String,
    );

Map<String, dynamic> _$CookingStepToJson(CookingStep instance) =>
    <String, dynamic>{
      'recipe_id': instance.recipeId,
      'step_number': instance.stepNumber,
      'description': instance.description,
    };

RecipeSearchResponse _$RecipeSearchResponseFromJson(
        Map<String, dynamic> json) =>
    RecipeSearchResponse(
      searchResults: (json['search_results'] as List<dynamic>)
          .map((e) => RecipeSearchResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RecipeSearchResponseToJson(
        RecipeSearchResponse instance) =>
    <String, dynamic>{
      'search_results': instance.searchResults,
    };

RecipeSearchResult _$RecipeSearchResultFromJson(Map<String, dynamic> json) =>
    RecipeSearchResult(
      id: json['id'] as String,
      name: json['name'] as String,
      imageBase64: json['image_base64'] as String,
    );

Map<String, dynamic> _$RecipeSearchResultToJson(RecipeSearchResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image_base64': instance.imageBase64,
    };
