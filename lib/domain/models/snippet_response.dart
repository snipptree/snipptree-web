import 'package:json_annotation/json_annotation.dart';

part 'snippet_response.g.dart';

@JsonSerializable(explicitToJson: true)
class SnippetResponse {
  bool? error;
  String? message;

  SnippetResponse({
    this.error,
    this.message,
  });

  factory SnippetResponse.fromJson(Map<String, dynamic> json) => _$SnippetResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SnippetResponseToJson(this);
}
