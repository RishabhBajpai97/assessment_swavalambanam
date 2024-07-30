import 'package:assessment_swavalambanam/features/newspaper/data/datasource/newspaper_remote_source.dart';
import 'package:assessment_swavalambanam/features/newspaper/data/repository/newspaper_repository_impl.dart';
import 'package:assessment_swavalambanam/features/newspaper/domain/repository/newspaper_repository.dart';
import 'package:assessment_swavalambanam/features/newspaper/domain/usecase/get_newpaper.dart';
import 'package:assessment_swavalambanam/features/newspaper/presentation/bloc/newspaper_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

//dependency injection

void init() {
  // Blocs
  sl.registerFactory(() => NewspaperBloc(getNewspapers: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetNewspapers(sl()));

  // Repository
  sl.registerLazySingleton<NewspaperRepository>(
    () => NewsRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<NewspaperRemoteDataSource>(
    () => NewspaperRemoteDataSourceImpl(client: sl()),
  );

  // External
  sl.registerLazySingleton(() => http.Client());
}
