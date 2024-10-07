/*
*  failure.dart
*
*  Created by Yakub Pasha on 7/4/21 12:23 AM
*  Copyright © 2021 abhibus.com. All rights reserved.
*/
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

part 'failure.g.dart';

enum FailureType { DATABASE, SERVER, INTERNET, FORMAT, GENERAL }

///generic failure to be used for the error cases
@JsonSerializable()
class Failure {
  bool? error;
  String? message;
  int? statusCode;
  FailureType? failureType;

  Failure(
      {required this.message,
      this.statusCode,
      this.error,
      this.failureType = FailureType.GENERAL});

  factory Failure.fromJson(Map<String, dynamic> json) =>
      _$FailureFromJson(json);

  Failure.fromServerError(DioException error) {
    message = error.message;
  }
}
