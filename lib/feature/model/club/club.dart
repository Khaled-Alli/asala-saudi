import 'package:json_annotation/json_annotation.dart';

import '../user/user.dart';

part 'club.g.dart';
@JsonSerializable()
class Club{
  int? id;
  String? name;
  String? description;
  @JsonKey(name: "icon")
  String? image;
  List<User> members;

  Club(this.id, this.name, this.description, this.image,this.members);

  factory Club.fromJson(Map<String,dynamic> json)=>_$ClubFromJson(json);

  Map<String,dynamic> toJson()=>_$ClubToJson(this);
}