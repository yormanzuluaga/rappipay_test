import 'dart:convert';
import 'dart:io';
import 'package:api_helper/api_helper.dart';
import 'package:either_dart/either.dart';

/// {@template example_resource}
/// An api resource to get the prompt terms.
/// {@endtemplate}
class MovieResource {
  /// {@macro example_resource}
  MovieResource({
    required ApiClient apiClient,
  }) : _apiClient = apiClient;

  // ignore: unused_field
  final ApiClient _apiClient;

  /// Get /game/prompt/terms
  ///
  /// Returns a [List<String>].
  Future<Either<ApiException, MovieModel>> getPopularMovies({
    Map<String, String>? headers,
  }) async {
    final response = await _apiClient.get(
      'movie/popular?api_key=dd69912c2f3f2025f9ac23c5f119b926&language=es-ES',
      modifiedHeaders: headers,
    );

    if (response.statusCode == HttpStatus.ok) {
      final loginResponse = MovieModel.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
      return Right(loginResponse);
    } else {
      return Left(
        ApiException(
          response.statusCode,
          response.body,
        ),
      );
    }
  }

  Future<Either<ApiException, MovieModel>> getTopRatedMovies({
    Map<String, String>? headers,
  }) async {
    final response = await _apiClient.get(
      'movie/top_rated?api_key=dd69912c2f3f2025f9ac23c5f119b926&language=es-ES',
      modifiedHeaders: headers,
    );

    if (response.statusCode == HttpStatus.ok) {
      final loginResponse = MovieModel.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
      return Right(loginResponse);
    } else {
      return Left(
        ApiException(
          response.statusCode,
          response.body,
        ),
      );
    }
  }
}
