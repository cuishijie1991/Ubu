import 'package:json_annotation/json_annotation.dart';

part 'fortune.g.dart';

@JsonSerializable()
class Fortune {
  Fortune();

  num astroid;
  String astroname;
  Map<String, dynamic> year;
  Map<String, dynamic> week;
  Map<String, dynamic> today;
  Map<String, dynamic> tomorrow;
  Map<String, dynamic> month;

  factory Fortune.fromJson(Map<String, dynamic> json) =>
      _$FortuneFromJson(json);

  Map<String, dynamic> toJson() => _$FortuneToJson(this);
}
