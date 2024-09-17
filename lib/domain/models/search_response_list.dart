import 'package:json_annotation/json_annotation.dart';

part 'search_response_list.g.dart';

@JsonSerializable()
class SearchResponseList {
  DateTime? createdAt;
  String? id;
  String? output;
  String? snippet;
  String? title;
  String? type;
  String? image;
  DateTime? updatedAt;

  SearchResponseList(
      {this.createdAt, this.id, this.output, this.snippet, this.title, this.type, this.image, this.updatedAt});

  factory SearchResponseList.fromJson(Map<String, dynamic> json) => _$SearchResponseListFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SearchResponseListToJson(this);
}
