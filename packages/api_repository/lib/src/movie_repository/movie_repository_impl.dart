import 'package:api_helper/api_helper.dart';
import 'package:api_repository/api_repository.dart';
import 'package:dartz/dartz.dart';

class MovieRepositoryImpl extends MovieRepository {
  MovieResource movieResource;
  @override
  MovieRepositoryImpl({
    required this.movieResource,
  });

  @override
  Future<Either<ApiException, MovieModel>> getPopularMovies({
    Map<String, String>? headers,
  }) async {
    final movieModel = await movieResource.getPopularMovies(
      headers: headers,
    );
    return movieModel.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }

  @override
  Future<Either<ApiException, MovieModel>> getTopRatedMovies({
    Map<String, String>? headers,
  }) async {
    final movieModel = await movieResource.getTopRatedMovies(
      headers: headers,
    );
    return movieModel.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}
