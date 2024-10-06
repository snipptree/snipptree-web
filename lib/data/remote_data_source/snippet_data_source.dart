import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:snippet/data/remote_data_source/snippet_api.dart';
import 'package:snippet/domain/models/snippet_request.dart';

part 'snippet_data_source.g.dart';

@RestApi()
abstract class SnippetDataSource {
  factory SnippetDataSource(Dio dio, {String baseUrl}) = _SnippetDataSource;

  @POST(SnippetApi.submitSnippetApi)
  Future<String> submitSnippetData(@Body() SnippetRequest req);

  @GET(SnippetApi.getSnippetsApi)
  Future<String> getSnippets(
      @Header("Authorization") String token, @Query('query') String q);

  @GET('${SnippetApi.getSnippetWithId}/{snippetId}')
  Future<String> getSnippetWithId(@Path("snippetId") String snippetId);

  @POST('${SnippetApi.likeSnippet}/{snippetId}/like')
  Future<String> likeSnippet(@Header("Authorization") String token,
      @Path("snippetId") String snippetId);

  @DELETE('${SnippetApi.disLikeSnippet}/{snippetId}/unlike')
  Future<String> disLikeSnippet(@Header("Authorization") String token,
      @Path("snippetId") String snippetId);

  @DELETE('${SnippetApi.deleteSnippet}/{snippetId}')
  Future<String> deleteSnippet(@Header("Authorization") String token,
      @Path("snippetId") String snippetId);

  @GET(SnippetApi.getMySnippetsApi)
  Future<String> getMySnippets(@Header("Authorization") String token);
}
