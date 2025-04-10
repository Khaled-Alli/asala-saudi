import 'package:asala_saudi/feature/model/product/product.dart';
import 'package:json_annotation/json_annotation.dart';

import '../club/club.dart';
import '../community/community.dart';

part 'user.g.dart';
@JsonSerializable()
class User{
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "username")
  String? userName;
  String? email;
  @JsonKey(name: "full_name")
  String? fullName;
  String? specialization;
  @JsonKey(name: "joined_communities")
  List<Community>? communities;
  @JsonKey(name: "joined_clubs")
  List<Club>? clubs;
  @JsonKey(name: "purchased_products")
  List<Product>? purchasedProduct;

  User(this.id, this.userName, this.email, this.fullName, this.specialization,this.communities,this.clubs,this.purchasedProduct);

  factory User.fromJson(Map<String,dynamic> json)=>_$UserFromJson(json);

  Map<String,dynamic> toJson()=>_$UserToJson(this);
}