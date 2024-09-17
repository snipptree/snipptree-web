// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_response_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResponseList _$SearchResponseListFromJson(Map<String, dynamic> json) => SearchResponseList(
      createdAt: json['createdAt'] == null ? null : DateTime.parse(json['createdAt'] as String),
      id: json['id'] as String?,
      output: json['output'] as String?,
      snippet: json['snippet'] as String?,
      title: json['title'] as String?,
      type: json['type'] as String?,
      image: json['image'] as String?,
      updatedAt: json['updatedAt'] == null ? null : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$SearchResponseListToJson(SearchResponseList instance) => <String, dynamic>{
      'createdAt': instance.createdAt?.toIso8601String(),
      'id': instance.id,
      'output': instance.output,
      'snippet': instance.snippet,
      'title': instance.title,
      'type': instance.type,
      'image': instance.image,
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
