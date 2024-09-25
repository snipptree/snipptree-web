// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      token: json['token'] as String?,
      email: json['email'] as String?,
      displayName: json['displayName'] as String?,
      profilePicUrl: json['profilePicUrl'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'token': instance.token,
      'email': instance.email,
      'displayName': instance.displayName,
      'profilePicUrl': instance.profilePicUrl,
    };
