import 'package:json_annotation/json_annotation.dart';

import '../user/user.dart';

part 'community.g.dart';
@JsonSerializable()
class Community{
  int? id;
  String? name;
  String? description;
  String? image;
  List<User> members;


  Community(this.id, this.name, this.description, this.image,this.members);

  factory Community.fromJson(Map<String,dynamic> json)=>_$CommunityFromJson(json);

  Map<String,dynamic> toJson()=>_$CommunityToJson(this);
}