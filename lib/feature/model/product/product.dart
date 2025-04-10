import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';
@JsonSerializable()
class Product{
  int? id;
  String? name;
  String? description;
  String? price;
  String? image;


  Product(this.id, this.name, this.description, this.image,this.price);

  factory Product.fromJson(Map<String,dynamic> json)=>_$ProductFromJson(json);

  Map<String,dynamic> toJson()=>_$ProductToJson(this);
}