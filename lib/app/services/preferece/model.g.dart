// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Keyword _$KeywordFromJson(Map<String, dynamic> json) => Keyword(
      id: json['id'] as String,
      name: json['name'] as String,
      type: $enumDecode(_$KeywordTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$KeywordToJson(Keyword instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$KeywordTypeEnumMap[instance.type]!,
    };

const _$KeywordTypeEnumMap = {
  KeywordType.like: 'LIKE',
  KeywordType.dislike: 'DISLIKE',
};

NewKeyword _$NewKeywordFromJson(Map<String, dynamic> json) => NewKeyword(
      name: json['name'] as String,
      type: $enumDecode(_$KeywordTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$NewKeywordToJson(NewKeyword instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': _$KeywordTypeEnumMap[instance.type]!,
    };

PreferenceData _$PreferenceDataFromJson(Map<String, dynamic> json) =>
    PreferenceData(
      keywords: (json['keywords'] as List<dynamic>)
          .map((e) => Keyword.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PreferenceDataToJson(PreferenceData instance) =>
    <String, dynamic>{
      'keywords': instance.keywords,
    };

PreferenceResponse _$PreferenceResponseFromJson(Map<String, dynamic> json) =>
    PreferenceResponse(
      preference:
          PreferenceData.fromJson(json['preference'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PreferenceResponseToJson(PreferenceResponse instance) =>
    <String, dynamic>{
      'preference': instance.preference,
    };
