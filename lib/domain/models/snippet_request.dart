


import 'package:json_annotation/json_annotation.dart';

part 'snippet_request.g.dart';

@JsonSerializable(explicitToJson: true)
class SnippetRequest {
 String? title;
    String? snippet;
    String? type;
    String? output;



  SnippetRequest({
   this.title,
        this.snippet,
        this.type,
        this.output,
  });

  factory SnippetRequest.fromJson(Map<String, dynamic> json) =>
      _$SnippetRequestFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$SnippetRequestToJson(this);
}
