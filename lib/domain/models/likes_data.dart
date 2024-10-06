import 'package:json_annotation/json_annotation.dart';

part 'likes_data.g.dart';

@JsonSerializable(explicitToJson: true)
class LikesData {
  int? likes;

  LikesData({
    this.likes,
  });

  factory LikesData.fromJson(Map<String, dynamic> json) =>
      _$LikesDataFromJson(json);
  Map<String, dynamic> toJson() => _$LikesDataToJson(this);
}
