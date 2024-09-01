// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'snippet_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SnippetRequest _$SnippetRequestFromJson(Map<String, dynamic> json) =>
    SnippetRequest(
      title: json['title'] as String?,
      snippet: json['snippet'] as String?,
      type: json['type'] as String?,
      output: json['output'] as String?,
    );

Map<String, dynamic> _$SnippetRequestToJson(SnippetRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'snippet': instance.snippet,
      'type': instance.type,
      'output': instance.output,
    };
