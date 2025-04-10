// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recommendation _$RecommendationFromJson(Map<String, dynamic> json) =>
    Recommendation(
      (json['users'] as List<dynamic>)
          .map((e) =>
              e == null ? null : User.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['clubs'] as List<dynamic>)
          .map((e) =>
              e == null ? null : Club.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['products'] as List<dynamic>)
          .map((e) =>
              e == null ? null : Product.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RecommendationToJson(Recommendation instance) =>
    <String, dynamic>{
      'users': instance.users,
      'clubs': instance.clubs,
      'products': instance.products,
    };
