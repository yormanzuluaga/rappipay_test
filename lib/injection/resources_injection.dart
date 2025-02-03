part of 'injection_container.dart';

void _initResourcesInjections() {
  sl.registerFactory<MovieResource>(() => MovieResource(
        apiClient: sl(),
      ));
}
