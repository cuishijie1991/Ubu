import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
    Product();

    String desc;
    String imageUrl;
    String type;
    String name;
    
    factory Product.fromJson(Map<String,dynamic> json) => _$ProductFromJson(json);
    Map<String, dynamic> toJson() => _$ProductToJson(this);
}
