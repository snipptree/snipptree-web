import 'package:json_annotation/json_annotation.dart';
import 'package:snippet/domain/models/likes_data.dart';

part 'like_dislike_response.g.dart';

@JsonSerializable(explicitToJson: true)
class LikeDislikeResponse {
  bool? error;
  String? message;
  LikesData? data;

  LikeDislikeResponse({
    this.error,
    this.message,
    this.data,
  });

  factory LikeDislikeResponse.fromJson(Map<String, dynamic> json) =>
      _$LikeDislikeResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LikeDislikeResponseToJson(this);
}
