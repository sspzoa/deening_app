import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

enum KeywordType {
  @JsonValue("LIKE")
  like,
  @JsonValue("DISLIKE")
  dislike,
}

@JsonSerializable()
class Keyword {
  Keyword({
    required this.id,
    required this.name,
    required this.type,
  });

  final String id;
  final String name;
  @JsonKey(name: 'type')
  final KeywordType type;

  factory Keyword.fromJson(Map<String, dynamic> json) =>
      _$KeywordFromJson(json);

  Map<String, dynamic> toJson() => _$KeywordToJson(this);
}

@JsonSerializable()
class NewKeyword {
  NewKeyword({
    required this.name,
    required this.type,
  });

  final String name;
  @JsonKey(name: 'type')
  final KeywordType type;

  factory NewKeyword.fromJson(Map<String, dynamic> json) =>
      _$NewKeywordFromJson(json);

  Map<String, dynamic> toJson() => _$NewKeywordToJson(this);
}

@JsonSerializable()
class PreferenceData {
  PreferenceData({
    required this.keywords,
  });

  final List<Keyword> keywords;

  factory PreferenceData.fromJson(Map<String, dynamic> json) =>
      _$PreferenceDataFromJson(json);

  Map<String, dynamic> toJson() => _$PreferenceDataToJson(this);
}

@JsonSerializable()
class PreferenceResponse {
  PreferenceResponse({
    required this.preference,
  });

  final PreferenceData preference;

  factory PreferenceResponse.fromJson(Map<String, dynamic> json) =>
      _$PreferenceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PreferenceResponseToJson(this);
}
