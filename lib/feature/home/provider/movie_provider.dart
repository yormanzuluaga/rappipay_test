import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:api_repository/api_repository.dart';
import 'package:api_helper/api_helper.dart';

final movieRepositoryProvider = Provider<MovieRepository>((ref) {
  final apiClient = ApiClient(); // Asume que tienes una instancia de ApiClient
  return MovieRepositoryImpl(movieResource: MovieResource(apiClient: apiClient));
});

final movieProvider = StateNotifierProvider<MovieNotifier, MovieState>((ref) {
  return MovieNotifier(ref.watch(movieRepositoryProvider));
});

final movieNotifierProvider = StateNotifierProvider<MovieNotifier, MovieState>((ref) {
  final movieRepository = ref.watch(movieRepositoryProvider);
  return MovieNotifier(movieRepository);
});

class MovieState with EquatableMixin {
  final List<Result>? listMovie;
  final List<Result>? aboveListMovie;
  final bool isLoading;
  final ApiException? error;

  MovieState({
    this.listMovie,
    this.aboveListMovie,
    this.isLoading = false,
    this.error,
  });

  MovieState copyWith({
    List<Result>? listMovie,
    List<Result>? aboveListMovie,
    bool? isLoading,
    ApiException? error,
  }) {
    return MovieState(
      listMovie: listMovie ?? this.listMovie,
      aboveListMovie: aboveListMovie ?? this.aboveListMovie,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        aboveListMovie,
        listMovie,
        isLoading,
        error,
      ];
}

class MovieNotifier extends StateNotifier<MovieState> {
  final MovieRepository _movieRepository;

  MovieNotifier(this._movieRepository) : super(MovieState());

  Future<void> getPopularMovies({Map<String, String>? headers}) async {
    state = state.copyWith(isLoading: true);

    final result = await _movieRepository.getPopularMovies(headers: headers);

    result.fold(
      (error) {
        state = state.copyWith(error: error, isLoading: false);
      },
      (movies) {
        state = state.copyWith(
          listMovie: movies.results,
          aboveListMovie: movies.results, // Guardamos la lista original
          isLoading: false,
        );
      },
    );
  }

  Future<void> getTopRatedMovies({Map<String, String>? headers}) async {
    state = state.copyWith(isLoading: true);

    final result = await _movieRepository.getTopRatedMovies(headers: headers);

    result.fold(
      (error) {
        state = state.copyWith(error: error, isLoading: false);
      },
      (movies) {
        state = state.copyWith(
          listMovie: movies.results,
          aboveListMovie: movies.results, // Guardamos la lista original
          isLoading: false,
        );
      },
    );
  }

  void searchMovie(String query) {
    final data = state.listMovie?.where((movie) {
      return movie.title!.toLowerCase().contains(query.toLowerCase());
    }).toList();
    state = state.copyWith(listMovie: data);
  }

  void resetSearch() {
    state = state.copyWith(
      listMovie: state.aboveListMovie,
      aboveListMovie: state.aboveListMovie,
    );
  }
}
