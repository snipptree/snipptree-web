
import 'package:dartz/dartz.dart';
import 'package:snippet/common/failure.dart';
import 'package:snippet/domain/models/snippet_request.dart';
import 'package:snippet/domain/models/snippet_response.dart';
import 'package:snippet/domain/repositories/snippet_repo.dart';
import 'package:snippet/injector.dart';

class SnippetDialogUseCase{
  final dataSource = getIt.get<SnippetRepo>();
  /// get the service status from api
    Future<Either<Failure, SnippetResponse>> submitSnippetData(SnippetRequest req) async {
      final response = await dataSource.submitSnippetData(req);
      return response;
    }

}