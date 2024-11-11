// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ingredient _$IngredientFromJson(Map<String, dynamic> json) => Ingredient(
      id: json['id'] as String,
      name: json['name'] as String,
      amount: (json['amount'] as num).toDouble(),
      unit: json['unit'] as String,
      category: json['category'] as String,
      storageType: $enumDecode(_$StorageTypeEnumMap, json['storage_type']),
    );

Map<String, dynamic> _$IngredientToJson(Ingredient instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'amount': instance.amount,
      'unit': instance.unit,
      'category': instance.category,
      'storage_type': _$StorageTypeEnumMap[instance.storageType]!,
    };

const _$StorageTypeEnumMap = {
  StorageType.refrigerated: 'REFRIGERATED',
  StorageType.frozen: 'FROZEN',
  StorageType.roomTemp: 'ROOM_TEMP',
};

NewIngredient _$NewIngredientFromJson(Map<String, dynamic> json) =>
    NewIngredient(
      name: json['name'] as String,
      amount: (json['amount'] as num).toDouble(),
      unit: json['unit'] as String,
      category: json['category'] as String,
      storageType: $enumDecode(_$StorageTypeEnumMap, json['storage_type']),
    );

Map<String, dynamic> _$NewIngredientToJson(NewIngredient instance) =>
    <String, dynamic>{
      'name': instance.name,
      'amount': instance.amount,
      'unit': instance.unit,
      'category': instance.category,
      'storage_type': _$StorageTypeEnumMap[instance.storageType]!,
    };

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      category: json['category'] as String,
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((e) => Ingredient.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'category': instance.category,
      'ingredients': instance.ingredients,
    };

RefrigeratorData _$RefrigeratorDataFromJson(Map<String, dynamic> json) =>
    RefrigeratorData(
      categories: (json['categories'] as List<dynamic>)
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RefrigeratorDataToJson(RefrigeratorData instance) =>
    <String, dynamic>{
      'categories': instance.categories,
    };

RefrigeratorResponse _$RefrigeratorResponseFromJson(
        Map<String, dynamic> json) =>
    RefrigeratorResponse(
      refrigerator: RefrigeratorData.fromJson(
          json['refrigerator'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RefrigeratorResponseToJson(
        RefrigeratorResponse instance) =>
    <String, dynamic>{
      'refrigerator': instance.refrigerator,
    };
