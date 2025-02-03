import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_model.freezed.dart';
part 'movie_model.g.dart';

@freezed
class MovieModel with _$MovieModel {
  const factory MovieModel({
    int? page,
    List<Result>? results,
    int? totalPages,
    int? totalResults,
  }) = _MovieModel;

  factory MovieModel.fromJson(Map<String, dynamic> json) => _$MovieModelFromJson(json);
}

@freezed
class Result with _$Result {
  const factory Result({
    bool? adult,
    String? backdrop_path,
    List<int>? genreIds,
    int? id,
    OriginalLanguage? originalLanguage,
    String? original_title,
    String? overview,
    double? popularity,
    String? poster_path,
    String? release_date,
    String? title,
    bool? video,
    double? voteAverage,
    int? voteCount,
  }) = _Result;

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
}

enum OriginalLanguage { EN, FR, NO, TE }

final originalLanguageValues =
    EnumValues({"en": OriginalLanguage.EN, "fr": OriginalLanguage.FR, "no": OriginalLanguage.NO, "te": OriginalLanguage.TE});

class EnumValues<T> {
  final Map<String, T> map;
  late final Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
