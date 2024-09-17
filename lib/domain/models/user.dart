import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String? email;
  String? firstName;
  String? lastName;
  String? profilePicUrl;

  User({
    this.email,
    this.firstName,
    this.lastName,
    this.profilePicUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
