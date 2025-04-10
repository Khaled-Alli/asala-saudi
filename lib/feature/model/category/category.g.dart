// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      (json['id'] as num?)?.toInt(),
      json['name'] as String?,
      (json['products'] as List<dynamic>)
          .map((e) =>
              e == null ? null : Product.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['icon'] as String?,
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'products': instance.products,
      'icon': instance.image,
    };
