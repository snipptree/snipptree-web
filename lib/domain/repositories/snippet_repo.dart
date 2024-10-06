import 'package:dartz/dartz.dart';
import 'package:snippet/common/failure.dart';
import 'package:snippet/domain/models/like_dislike_response.dart';
import 'package:snippet/domain/models/search_response.dart';
import 'package:snippet/domain/models/snippet_request.dart';
import 'package:snippet/domain/models/base_response.dart';

abstract class SnippetRepo {
  Future<Either<Failure, BaseResponse>> submitSnippetData(SnippetRequest req);

  Future<Either<Failure, SearchResponse>> getSnippets(String req);

  Future<Either<Failure, SearchResponse>> getSnippetWithId(String snippetId);

  Future<Either<Failure, SearchResponse>> getMySnippets();

  Future<Either<Failure, LikeDislikeResponse>> likeSnippet(String snippetId);

  Future<Either<Failure, LikeDislikeResponse>> disLikeSnippet(String snippetId);

  Future<Either<Failure, BaseResponse>> deleteSnippet(String snippetId);
}
