// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product()
    ..desc = json['desc'] as String
    ..imageUrl = json['imageUrl'] as String
    ..type = json['type'] as String
    ..name = json['name'] as String;
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'desc': instance.desc,
      'imageUrl': instance.imageUrl,
      'type': instance.type,
      'name': instance.name
    };
