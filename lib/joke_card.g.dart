// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'joke_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JokeModel _$JokeModelFromJson(Map<String, dynamic> json) {
  return JokeModel(
    url: json['url'] as String,
    value: json['value'] as String,
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$JokeModelToJson(JokeModel instance) => <String, dynamic>{
      'url': instance.url,
      'value': instance.value,
      'id': instance.id,
    };
