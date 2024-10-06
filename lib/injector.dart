import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:snippet/common/app_constants.dart';
import 'package:snippet/common/network_info.dart';
import 'package:snippet/data/remote_data_source/auth_data_source.dart';
import 'package:snippet/data/remote_data_source/snippet_data_source.dart';
import 'package:snippet/data/repositories/auth_repo_impl.dart';
import 'package:snippet/data/repositories/snippet_repo_impl.dart';
import 'package:snippet/domain/repositories/auth_repo.dart';
import 'package:snippet/domain/repositories/snippet_repo.dart';
import 'package:snippet/firebase_options.dart';

var getIt = GetIt.I;
var dio = Dio(BaseOptions(
  receiveTimeout: const Duration(seconds: 60),
  validateStatus: (status) {
    return status != null && status < 500; // Accept any status code less than 500
  },
))
  ..interceptors.add(LogInterceptor(
    request: true,
    requestBody: true,
    requestHeader: true,
    responseBody: true,
    responseHeader: false,
    // You can enable if needed
    error: true,
    logPrint: (log) {
      debugPrint(log.toString()); // Customize how logs are printed if needed
    },
  ));

Future<void> init() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // if(flavor == Flavor.TSRTC_DEMO || flavor == Flavor.APSRTC_DEMO){
  //   dio.interceptors.add(CustomInterceptor());
  // }

  /// register singleton Network connectivity
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  /// Snippet repository and data source injection.
  getIt.registerLazySingleton<SnippetDataSource>(
      () => SnippetDataSource(dio, baseUrl: AppConstants.baseUrl));
  getIt.registerLazySingleton<SnippetRepo>(() => SnippetRepoImpl(
      getIt.get<SnippetDataSource>(), getIt.get<NetworkInfo>()));

  /// auth repository and data store injection.
  getIt.registerLazySingleton<AuthDataSource>(
      () => AuthDataSource(dio, baseUrl: AppConstants.baseUrl));
  getIt.registerLazySingleton<AuthRepo>(() =>
      AuthRepoImpl(getIt.get<AuthDataSource>(), getIt.get<NetworkInfo>()));
}
