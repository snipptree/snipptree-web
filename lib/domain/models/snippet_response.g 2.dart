// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'snippet_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SnippetResponse _$SnippetResponseFromJson(Map<String, dynamic> json) =>
    SnippetResponse(
      error: json['error'] as bool?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$SnippetResponseToJson(SnippetResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
    };
