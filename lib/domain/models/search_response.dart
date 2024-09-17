import 'package:json_annotation/json_annotation.dart';
import 'package:snippet/domain/models/search_response_list.dart';

part 'search_response.g.dart';

@JsonSerializable(explicitToJson: true)
class SearchResponse {
  bool? error;
  String? message;
  List<SearchResponseList>? data;

  SearchResponse({
    this.error,
    this.message,
    this.data,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) => _$SearchResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SearchResponseToJson(this);
}
