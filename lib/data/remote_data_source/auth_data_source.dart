

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:snippet/data/remote_data_source/snippet_api.dart';
import 'package:snippet/domain/models/snippet_request.dart';
import 'package:snippet/domain/models/user.dart';

part 'auth_data_source.g.dart';

@RestApi()
abstract class AuthDataSource {
  factory AuthDataSource(Dio dio, {String baseUrl}) =
  _AuthDataSource;

  @POST(SnippetApi.authenticationApi)
  Future<String> authenticateUser(@Body() User req);



}
