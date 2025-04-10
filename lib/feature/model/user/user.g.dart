// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      (json['id'] as num?)?.toInt(),
      json['username'] as String?,
      json['email'] as String?,
      json['full_name'] as String?,
      json['specialization'] as String?,
      (json['joined_communities'] as List<dynamic>?)
          ?.map((e) => Community.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['joined_clubs'] as List<dynamic>?)
          ?.map((e) => Club.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['purchased_products'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.userName,
      'email': instance.email,
      'full_name': instance.fullName,
      'specialization': instance.specialization,
      'joined_communities': instance.communities,
      'joined_clubs': instance.clubs,
      'purchased_products': instance.purchasedProduct,
    };
