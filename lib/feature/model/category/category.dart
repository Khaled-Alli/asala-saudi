import 'package:asala_saudi/feature/model/product/product.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';
@JsonSerializable()
class Category{
  int? id;
  String? name;
  List<Product?> products;
  @JsonKey(name: "icon")
  String? image;


  Category(this.id, this.name, this.products, this.image);

  factory Category.fromJson(Map<String,dynamic> json)=>_$CategoryFromJson(json);

  Map<String,dynamic> toJson()=>_$CategoryToJson(this);
}