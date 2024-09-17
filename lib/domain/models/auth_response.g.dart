// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) => AuthResponse(
      error: json['error'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null ? null : User.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthResponseToJson(AuthResponse instance) => <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'data': instance.data?.toJson(),
    };
