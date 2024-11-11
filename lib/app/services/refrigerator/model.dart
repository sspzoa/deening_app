import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

enum StorageType {
  @JsonValue("REFRIGERATED")
  refrigerated,
  @JsonValue("FROZEN")
  frozen,
  @JsonValue("ROOM_TEMP")
  roomTemp
}

@JsonSerializable()
class Ingredient {
  Ingredient({
    required this.id,
    required this.name,
    required this.amount,
    required this.unit,
    required this.category,
    required this.storageType,
  });

  final String id;
  final String name;
  final double amount;
  final String unit;
  final String category;
  @JsonKey(name: 'storage_type')
  final StorageType storageType;

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientToJson(this);
}

@JsonSerializable()
class NewIngredient {
  NewIngredient({
    required this.name,
    required this.amount,
    required this.unit,
    required this.category,
    required this.storageType,
  });

  final String name;
  final double amount;
  final String unit;
  final String category;
  @JsonKey(name: 'storage_type')
  final StorageType storageType;

  factory NewIngredient.fromJson(Map<String, dynamic> json) =>
      _$NewIngredientFromJson(json);

  Map<String, dynamic> toJson() => _$NewIngredientToJson(this);
}

@JsonSerializable()
class Category {
  Category({
    required this.category,
    required this.ingredients,
  });

  final String category;
  final List<Ingredient> ingredients;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

@JsonSerializable()
class RefrigeratorData {
  RefrigeratorData({
    required this.categories,
  });

  final List<Category> categories;

  factory RefrigeratorData.fromJson(Map<String, dynamic> json) =>
      _$RefrigeratorDataFromJson(json);

  Map<String, dynamic> toJson() => _$RefrigeratorDataToJson(this);
}

@JsonSerializable()
class RefrigeratorResponse {
  RefrigeratorResponse({
    required this.refrigerator,
  });

  final RefrigeratorData refrigerator;

  factory RefrigeratorResponse.fromJson(Map<String, dynamic> json) =>
      _$RefrigeratorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RefrigeratorResponseToJson(this);
}
