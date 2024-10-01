import 'package:dartz/dartz.dart';
import 'package:snippet/common/failure.dart';
import 'package:snippet/domain/models/search_response.dart';
import 'package:snippet/domain/models/snippet_request.dart';
import 'package:snippet/domain/models/snippet_response.dart';
import 'package:snippet/domain/repositories/snippet_repo.dart';
import 'package:snippet/injector.dart';

class SnippetUseCase {
  final dataSource = getIt.get<SnippetRepo>();

  /// get the service status from api
  Future<Either<Failure, SnippetResponse>> submitSnippetData(
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

  Future<Either<Failure, SearchResponse>> getMySnippets() async {
    final response = await dataSource.getMySnippets();
    return response;
  }
}
