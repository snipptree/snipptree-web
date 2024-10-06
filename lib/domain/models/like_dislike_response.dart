import 'package:json_annotation/json_annotation.dart';
import 'package:snippet/domain/models/likes_data.dart';
import 'base_response.dart';

part 'like_dislike_response.g.dart';

@JsonSerializable(explicitToJson: true)
class LikeDislikeResponse extends BaseResponse {
  LikesData? data;

  LikeDislikeResponse({
    super.error,
    super.message,
    super.statusCode,
    this.data,
  });

  factory LikeDislikeResponse.fromJson(Map<String, dynamic> json) =>
      _$LikeDislikeResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LikeDislikeResponseToJson(this);
}
