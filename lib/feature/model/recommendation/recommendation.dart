import 'package:asala_saudi/feature/model/product/product.dart';
import 'package:json_annotation/json_annotation.dart';

import '../club/club.dart';
import '../user/user.dart';

part 'recommendation.g.dart';
@JsonSerializable()
class Recommendation{
  List<User?> users;
  List<Club?> clubs;
  List<Product?> products;


  Recommendation(this.users, this.clubs, this.products,);

  factory Recommendation.fromJson(Map<String,dynamic> json)=>_$RecommendationFromJson(json);

  Map<String,dynamic> toJson()=>_$RecommendationToJson(this);
}