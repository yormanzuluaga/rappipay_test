import 'package:api_helper/api_helper.dart';
import 'package:dartz/dartz.dart';

abstract class MovieRepository {
  Future<Either<ApiException, MovieModel>> getPopularMovies({
    Map<String, String>? headers,
  });

  Future<Either<ApiException, MovieModel>> getTopRatedMovies({
    Map<String, String>? headers,
  });
}
