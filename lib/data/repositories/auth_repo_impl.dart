import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:snippet/common/failure.dart';
import 'package:snippet/common/network_info.dart';
import 'package:snippet/data/remote_data_source/auth_data_source.dart';
import 'package:snippet/domain/models/auth_response.dart';
import 'package:snippet/domain/models/user.dart';
import 'package:snippet/domain/repositories/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthDataSource dataSource;
  final NetworkInfo networkInfo;

  AuthRepoImpl(this.dataSource, this.networkInfo);

  @override
  Future<Either<Failure, AuthResponse>> authenticateUser(User req) async {
    if (!await networkInfo.isConnected) {
      return Left(Failure(message: 'No Internet', failureType: FailureType.INTERNET));
    } else {
      try {
        var response = await dataSource.authenticateUser(req);
        final map = jsonDecode(response);
        final authRes = AuthResponse.fromJson(map);
        return Right(authRes);
      } catch (e) {
        return Left(Failure(message: e.toString()));
      }
    }
  }
}
