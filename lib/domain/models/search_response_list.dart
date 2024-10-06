import 'package:json_annotation/json_annotation.dart';

part 'search_response_list.g.dart';

@JsonSerializable()
class SearchResponseList {
  DateTime? createdAt;
  final String? id;
  final String? output;
  final String? snippet;
  final String? title;
  final String? type;
  final String? image;
  final DateTime? updatedAt;
  @JsonKey(name: 'total_likes')
  int? totalLikes;
  @JsonKey(name: 'is_liked')
  bool isLiked;

  SearchResponseList(
      {this.createdAt,
      this.id,
      this.output,
      this.snippet,
      this.title,
      this.type,
      this.image,
      this.totalLikes,
      this.isLiked = false,
      this.updatedAt});

  factory SearchResponseList.fromJson(Map<String, dynamic> json) =>
      _$SearchResponseListFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResponseListToJson(this);
}
