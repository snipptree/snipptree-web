
import 'package:dartz/dartz.dart';
import 'package:snippet/common/failure.dart';
import 'package:snippet/domain/models/snippet_request.dart';
import 'package:snippet/domain/models/snippet_response.dart';

abstract class SnippetRepo {
  Future<Either<Failure, SnippetResponse>> submitSnippetData(SnippetRequest req);
  



}
