// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like_dislike_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LikeDislikeResponse _$LikeDislikeResponseFromJson(Map<String, dynamic> json) =>
    LikeDislikeResponse(
      error: json['error'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : LikesData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LikeDislikeResponseToJson(
        LikeDislikeResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'data': instance.data?.toJson(),
    };
