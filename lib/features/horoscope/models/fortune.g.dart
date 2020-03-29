// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fortune.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Fortune _$FortuneFromJson(Map<String, dynamic> json) {
  return Fortune()
    ..astroid = json['astroid'] as num
    ..astroname = json['astroname'] as String
    ..year = json['year'] as Map<String, dynamic>
    ..week = json['week'] as Map<String, dynamic>
    ..today = json['today'] as Map<String, dynamic>
    ..tomorrow = json['tomorrow'] as Map<String, dynamic>
    ..month = json['month'] as Map<String, dynamic>;
}

Map<String, dynamic> _$FortuneToJson(Fortune instance) => <String, dynamic>{
      'astroid': instance.astroid,
      'astroname': instance.astroname,
      'year': instance.year,
      'week': instance.week,
      'today': instance.today,
      'tomorrow': instance.tomorrow,
      'month': instance.month
    };
