import 'package:json_annotation/json_annotation.dart';
import 'package:snippet/domain/models/search_response_list.dart';
import 'package:snippet/domain/models/user.dart';

part 'auth_response.g.dart';

@JsonSerializable(explicitToJson: true)
class AuthResponse {
  bool? error;
  String? message;
  User? data;

  AuthResponse({
    this.error,
    this.message,
    this.data,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}
