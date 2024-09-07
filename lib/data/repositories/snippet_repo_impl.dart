

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:snippet/common/failure.dart';
import 'package:snippet/common/network_info.dart';
import 'package:snippet/data/remote_data_source/snippet_data_source.dart';
import 'package:snippet/domain/models/search_response.dart';
import 'package:snippet/domain/models/snippet_request.dart';
import 'package:snippet/domain/models/snippet_response.dart';
import 'package:snippet/domain/repositories/snippet_repo.dart';

class SnippetRepoImpl implements SnippetRepo {
  final SnipperDataSource dataSource;
  final NetworkInfo networkInfo;
  SnippetRepoImpl(this.dataSource, this.networkInfo);

 

  @override
  Future<Either<Failure, SnippetResponse>> submitSnippetData(
      SnippetRequest req) async {
    if (!await networkInfo.isConnected) {
      return Left(Failure(
          message: 'No Internet',
          failureType: FailureType.INTERNET));
    } else {
      try {
      
        var response = await dataSource.submitSnippetData(req);
        final map = jsonDecode(response);
        final serviceListResponse = SnippetResponse.fromJson(map);
        return Right(serviceListResponse);
      } catch (e) {
        return Left(Failure(message: e.toString()));
      }
    }
  }

 
 
   @override
  Future<Either<Failure, SearchResponse>> getSnippets(
      String req) async {
    if (!await networkInfo.isConnected) {
      return Left(Failure(
          message: 'No Internet',
          failureType: FailureType.INTERNET));
    } else {
      try {
      
        var response = await dataSource.getSnippets(req);
        final map = jsonDecode(response);
        final searchRes = SearchResponse.fromJson(map);
        return Right(searchRes);
      } catch (e) {
        return Left(Failure(message: e.toString()));
      }
    }
  }

}
