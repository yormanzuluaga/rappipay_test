import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rappipay_test/feature/home/provider/movie_provider.dart';
import 'package:api_helper/api_helper.dart';
import '../../../mockito.dart';

void main() {
  late MovieNotifier movieNotifier;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    movieNotifier = MovieNotifier(mockMovieRepository);
  });

  test('initial state is correct', () {
    expect(movieNotifier.state, equals(MovieState()));
  });

  test('getPopularMovies updates state correctly on success', () async {
    final movies = MovieModel(results: [Result(title: 'Movie 1'), Result(title: 'Movie 2')]);
    when(mockMovieRepository.getPopularMovies(headers: anyNamed('headers'))).thenAnswer((_) async => Right(movies));

    await movieNotifier.getPopularMovies();

    expect(movieNotifier.state.isLoading, false);
    expect(movieNotifier.state.listMovie, movies.results);
    expect(movieNotifier.state.error, isNull);
  });

  test('getPopularMovies updates state correctly on failure', () async {
    final error = ApiException(400, 'Error');
    when(mockMovieRepository.getPopularMovies(headers: anyNamed('headers'))).thenAnswer((_) async => Left(error));

    await movieNotifier.getPopularMovies();

    expect(movieNotifier.state.isLoading, false);
    expect(movieNotifier.state.listMovie, isNull);
    expect(movieNotifier.state.error, error);
  });

  test('searchMovie filters movies correctly', () {
    final movies = [Result(title: 'Movie 1'), Result(title: 'Movie 2')];
    movieNotifier.state = movieNotifier.state.copyWith(listMovie: movies, aboveListMovie: movies);

    movieNotifier.searchMovie('Movie 1');

    expect(movieNotifier.state.listMovie, [movies[0]]);
  });

  test('resetSearch resets the movie list', () {
    final movies = [Result(title: 'Movie 1'), Result(title: 'Movie 2')];
    movieNotifier.state = movieNotifier.state.copyWith(listMovie: [movies[0]], aboveListMovie: movies);

    movieNotifier.resetSearch();

    expect(movieNotifier.state.listMovie, movies);
  });
}
