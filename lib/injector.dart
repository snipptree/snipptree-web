import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:snippet/common/network_info.dart';
import 'package:snippet/data/remote_data_source/snippet_data_source.dart';
import 'package:snippet/data/repositories/snippet_repo_impl.dart';
import 'package:snippet/domain/repositories/snippet_repo.dart';
import 'package:snippet/firebase_options.dart';


var getIt = GetIt.I;
var dio = Dio(BaseOptions(
receiveTimeout: const Duration(seconds: 60)));


Future<void> init() async {

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // if(flavor == Flavor.TSRTC_DEMO || flavor == Flavor.APSRTC_DEMO){
  //   dio.interceptors.add(CustomInterceptor());
  // }


  /// register singleton Network connectivity
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

 
  /// Bus Booking flow repository and data source injection.
  getIt.registerLazySingleton<SnipperDataSource>(
      () => SnipperDataSource(dio, baseUrl: 'http://snipptree.com/'));
  getIt.registerLazySingleton<SnippetRepo>(
      () => SnippetRepoImpl(getIt.get<SnipperDataSource>(), getIt.get<NetworkInfo>()));

}