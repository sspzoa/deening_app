import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

// Recipe Response Models
@JsonSerializable()
class RecipeResponse {
  RecipeResponse({
    required this.id,
    required this.recipe,
    required this.imageBase64,
  });

  final String id;
  final Recipe recipe;
  @JsonKey(name: 'image_base64')
  final String imageBase64;

  factory RecipeResponse.fromJson(Map<String, dynamic> json) =>
      _$RecipeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeResponseToJson(this);
}

@JsonSerializable()
class Recipe {
  Recipe({
    required this.id,
    required this.name,
    required this.description,
    required this.cookTime,
    required this.nutrition,
    required this.ingredients,
    required this.instructions,
  });

  final String id;
  final String name;
  final String description;
  final String cookTime;
  final Nutrition nutrition;
  final List<Ingredient> ingredients;
  final List<Instruction> instructions;

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeToJson(this);
}

@JsonSerializable()
class Nutrition {
  Nutrition({
    required this.calories,
    required this.protein,
    required this.carbohydrates,
    required this.fat,
  });

  final int calories;
  final String protein;
  final String carbohydrates;
  final String fat;

  factory Nutrition.fromJson(Map<String, dynamic> json) =>
      _$NutritionFromJson(json);

  Map<String, dynamic> toJson() => _$NutritionToJson(this);
}

@JsonSerializable()
class Ingredient {
  Ingredient({
    required this.name,
    required this.amount,
    required this.unit,
  });

  final String name;
  final double amount;
  final String unit;

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientToJson(this);
}

@JsonSerializable()
class Instruction {
  Instruction({
    required this.step,
    required this.description,
  });

  final int step;
  final String description;

  factory Instruction.fromJson(Map<String, dynamic> json) =>
      _$InstructionFromJson(json);

  Map<String, dynamic> toJson() => _$InstructionToJson(this);
}

// Ingredient Info Detail Models
@JsonSerializable()
class IngredientInfoResponse {
  IngredientInfoResponse({
    required this.id,
    required this.ingredient,
    required this.imageBase64,
  });

  final String id;
  final IngredientInfo ingredient;
  @JsonKey(name: 'image_base64')
  final String imageBase64;

  factory IngredientInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$IngredientInfoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientInfoResponseToJson(this);
}

@JsonSerializable()
class IngredientInfo {
  IngredientInfo({
    required this.name,
    required this.description,
  });

  final String name;
  final String description;

  factory IngredientInfo.fromJson(Map<String, dynamic> json) =>
      _$IngredientInfoFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientInfoToJson(this);
}

// Cooking Step Detail Models
@JsonSerializable()
class CookingStepResponse {
  CookingStepResponse({
    required this.id,
    required this.cookingStep,
    required this.imageBase64,
  });

  final String id;
  @JsonKey(name: 'cooking_step')
  final CookingStep cookingStep;
  @JsonKey(name: 'image_base64')
  final String imageBase64;

  factory CookingStepResponse.fromJson(Map<String, dynamic> json) =>
      _$CookingStepResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CookingStepResponseToJson(this);
}

@JsonSerializable()
class CookingStep {
  CookingStep({
    required this.recipeId,
    required this.stepNumber,
    required this.description,
  });

  @JsonKey(name: 'recipe_id')
  final String recipeId;
  @JsonKey(name: 'step_number')
  final int stepNumber;
  final String description;

  factory CookingStep.fromJson(Map<String, dynamic> json) =>
      _$CookingStepFromJson(json);

  Map<String, dynamic> toJson() => _$CookingStepToJson(this);
}

// Recipe Search Models
@JsonSerializable()
class RecipeSearchResponse {
  RecipeSearchResponse({
    required this.searchResults,
  });

  @JsonKey(name: 'search_results')
  final List<RecipeSearchResult> searchResults;

  factory RecipeSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$RecipeSearchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeSearchResponseToJson(this);
}

@JsonSerializable()
class RecipeSearchResult {
  RecipeSearchResult({
    required this.id,
    required this.name,
    required this.imageBase64,
  });

  final String id;
  final String name;
  @JsonKey(name: 'image_base64')
  final String imageBase64;

  factory RecipeSearchResult.fromJson(Map<String, dynamic> json) =>
      _$RecipeSearchResultFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeSearchResultToJson(this);
}
