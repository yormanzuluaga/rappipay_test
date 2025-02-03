part of 'injection_container.dart';

void _initRepositoriesInjections() {
  sl.registerFactory<MovieRepository>(() => MovieRepositoryImpl(movieResource: sl()));
}
