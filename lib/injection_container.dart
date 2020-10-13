import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:newstoday/config/constant_config.dart';
import 'package:newstoday/config/flavor_config.dart';
import 'package:newstoday/core/network/network_info.dart';
import 'package:newstoday/core/util/dio_logging_interceptor.dart';
import 'package:newstoday/feature/data/datasource/news/news_remote_data_source.dart';
import 'package:newstoday/feature/data/repository/news/news_repository_impl.dart';
import 'package:newstoday/feature/domain/repository/news/news_repository.dart';
import 'package:newstoday/feature/domain/usecase/gettopheadlinesnews/get_top_headlines_news.dart';
import 'package:newstoday/feature/domain/usecase/searchtopheadlinesnews/search_top_headlines_news.dart';
import 'package:newstoday/feature/presentation/bloc/topheadlinesnews/bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /**
   * ! Features
   */
  // Bloc
  sl.registerFactory(
    () => TopHeadlinesNewsBloc(
      getTopHeadlinesNews: sl(),
      searchTopHeadlinesNews: sl(),
    ),
  );

  // Use Case
  sl.registerLazySingleton(() => GetTopHeadlinesNews(newsRepository: sl()));
  sl.registerLazySingleton(() => SearchTopHeadlinesNews(newsRepository: sl()));

  // Repository
  sl.registerLazySingleton<NewsRepository>(
      () => NewsRepositoryImpl(newsRemoteDataSource: sl(), networkInfo: sl()));

  // Data Source
  sl.registerLazySingleton<NewsRemoteDataSource>(
      () => NewsRemoteDataSourceImpl(dio: sl(), constantConfig: sl()));

  /**
   * ! Core
   */
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  /**
   * ! External
   */
  sl.registerLazySingleton(() {
    final dio = Dio();
    dio.options.baseUrl = FlavorConfig.instance.values.baseUrl;
    dio.interceptors.add(DioLoggingInterceptor());
    return dio;
  });
  sl.registerLazySingleton(() => ConstantConfig());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
