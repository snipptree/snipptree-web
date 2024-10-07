import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:snippet/common/failure.dart';
import 'package:snippet/common/network_info.dart';
import 'package:snippet/common/shared_pref.dart';
import 'package:snippet/data/remote_data_source/snippet_data_source.dart';
import 'package:snippet/domain/models/like_dislike_response.dart';
import 'package:snippet/domain/models/search_response.dart';
import 'package:snippet/domain/models/snippet_request.dart';
import 'package:snippet/domain/models/base_response.dart';
import 'package:snippet/domain/repositories/snippet_repo.dart';

class SnippetRepoImpl implements SnippetRepo {
  final SnippetDataSource dataSource;
  final NetworkInfo networkInfo;

  SnippetRepoImpl(this.dataSource, this.networkInfo);

  @override
  Future<Either<Failure, BaseResponse>> submitSnippetData(
      SnippetRequest req) async {
    if (!await networkInfo.isConnected) {
      return Left(
          Failure(message: 'No Internet', failureType: FailureType.INTERNET));
    } else {
      try {
        var response = await dataSource.submitSnippetData(req);
        final map = jsonDecode(response);
        final serviceListResponse = BaseResponse.fromJson(map);
        return Right(serviceListResponse);
      } catch (e) {
        return Left(Failure(message: e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, SearchResponse>> getSnippets(String req) async {
    if (!await networkInfo.isConnected) {
      return Left(
          Failure(message: 'No Internet', failureType: FailureType.INTERNET));
    } else {
      try {
        var response = await dataSource.getSnippets(
            SharedPrefs().getJwtToken() ?? '', req);
        final map = jsonDecode(response);
        final searchRes = SearchResponse.fromJson(map);
        return Right(searchRes);
      } catch (e) {
        return Left(Failure(message: e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, SearchResponse>> getMySnippets() async {
    if (!await networkInfo.isConnected) {
      return Left(
          Failure(message: 'No Internet', failureType: FailureType.INTERNET));
    } else {
      try {
        var response =
            await dataSource.getMySnippets(SharedPrefs().getJwtToken() ?? '');
        final map = jsonDecode(response);
        final searchRes = SearchResponse.fromJson(map);
        return Right(searchRes);
      } catch (e) {
        return Left(Failure(message: e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, SearchResponse>> getSnippetWithId(
      String snippetId) async {
    if (!await networkInfo.isConnected) {
      return Left(
          Failure(message: 'No Internet', failureType: FailureType.INTERNET));
    } else {
      try {
        var response = await dataSource.getSnippetWithId(snippetId);
        final map = jsonDecode(response);
        final searchRes = SearchResponse.fromJson(map);
        return Right(searchRes);
      } catch (e) {
        return Left(Failure(message: e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, LikeDislikeResponse>> likeSnippet(
      String snippetId) async {
    var response = '';
    if (!await networkInfo.isConnected) {
      return Left(
          Failure(message: 'No Internet', failureType: FailureType.INTERNET));
    } else {
      try {
        response = await dataSource.likeSnippet(
            SharedPrefs().getJwtToken() ?? '', snippetId);
        final map = jsonDecode(response);
        final searchRes = LikeDislikeResponse.fromJson(map);
        return Right(searchRes);
      } catch (e) {
        final map = jsonDecode(response);
        final searchRes = Failure.fromJson(map);
        return Left(Failure(message: searchRes.message ?? e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, LikeDislikeResponse>> disLikeSnippet(
      String snippetId) async {
    String response = '';
    if (!await networkInfo.isConnected) {
      return Left(
          Failure(message: 'No Internet', failureType: FailureType.INTERNET));
    } else {
      try {
        response = await dataSource.disLikeSnippet(
            SharedPrefs().getJwtToken() ?? '', snippetId);
        final map = jsonDecode(response);
        final searchRes = LikeDislikeResponse.fromJson(map);
        return Right(searchRes);
      } catch (e) {
        final map = jsonDecode(response);
        final searchRes = Failure.fromJson(map);
        return Left(Failure(message: searchRes.message ?? e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> deleteSnippet(String snippetId) async {
    String response = '';
    if (!await networkInfo.isConnected) {
      return Left(
          Failure(message: 'No Internet', failureType: FailureType.INTERNET));
    } else {
      try {
        response = await dataSource.deleteSnippet(
            SharedPrefs().getJwtToken() ?? '', snippetId);
        final map = jsonDecode(response);
        final searchRes = BaseResponse.fromJson(map);
        return Right(searchRes);
      } catch (e) {
        final map = jsonDecode(response);
        final searchRes = Failure.fromJson(map);
        return Left(Failure(message: searchRes.message ?? e.toString()));
      }
    }
  }
}
