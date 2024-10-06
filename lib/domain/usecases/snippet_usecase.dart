import 'package:dartz/dartz.dart';
import 'package:snippet/common/failure.dart';
import 'package:snippet/domain/models/like_dislike_response.dart';
import 'package:snippet/domain/models/search_response.dart';
import 'package:snippet/domain/models/snippet_request.dart';
import 'package:snippet/domain/models/base_response.dart';
import 'package:snippet/domain/repositories/snippet_repo.dart';
import 'package:snippet/injector.dart';

class SnippetUseCase {
  final dataSource = getIt.get<SnippetRepo>();

  /// get the service status from api
  Future<Either<Failure, BaseResponse>> submitSnippetData(
      SnippetRequest req) async {
    final response = await dataSource.submitSnippetData(req);
    return response;
  }

  Future<Either<Failure, SearchResponse>> getSnippets(String query) async {
    final response = await dataSource.getSnippets(query);
    return response;
  }

  Future<Either<Failure, SearchResponse>> getSnippetWithId(
      String snippetId) async {
    final response = await dataSource.getSnippetWithId(snippetId);
    return response;
  }

  Future<Either<Failure, LikeDislikeResponse>> likeSnippet(
      String snippetId) async {
    final response = await dataSource.likeSnippet(snippetId);
    return response;
  }

  Future<Either<Failure, LikeDislikeResponse>> disLikeSnippet(
      String snippetId) async {
    final response = await dataSource.disLikeSnippet(snippetId);
    return response;
  }

  Future<Either<Failure, SearchResponse>> getMySnippets() async {
    final response = await dataSource.getMySnippets();
    return response;
  }

  Future<Either<Failure, BaseResponse>> deleteSnippet(String snippetId) async {
    final response = await dataSource.deleteSnippet(snippetId);
    return response;
  }

}
