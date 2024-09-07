

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:snippet/data/remote_data_source/snippet_api.dart';
import 'package:snippet/domain/models/snippet_request.dart';

part 'snippet_data_source.g.dart';

@RestApi()
abstract class SnipperDataSource {
  factory SnipperDataSource(Dio dio, {String baseUrl}) =
      _SnipperDataSource;

  @POST(SnippetApi.submitSnippetApi)
  Future<String> submitSnippetData(@Body() SnippetRequest req);

    @GET(SnippetApi.getSnippetsApi)
  Future<String> getSnippets(@Query('query') String q);

  
}
