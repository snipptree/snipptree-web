/*
*  failure.dart
*
*  Created by Yakub Pasha on 7/4/21 12:23 AM
*  Copyright © 2021 abhibus.com. All rights reserved.
*/
import 'package:dio/dio.dart';

enum FailureType { DATABASE, SERVER, INTERNET, FORMAT, GENERAL }

///generic failure to be used for the error cases
class Failure {
  String? message;
  FailureType? failureType;

  Failure({required this.message, this.failureType = FailureType.GENERAL});

  Failure.fromServerError(DioError error) {
    message = error.message;
  }
}
