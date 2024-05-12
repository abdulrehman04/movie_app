class UpcomingMoviesEntity {
  DatesEntity dates;
  int page;
  List<UpcomingMovieEntity> results;
  int totalPages;
  int totalResults;

  UpcomingMoviesEntity({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory UpcomingMoviesEntity.fromJson(Map<String, dynamic> json) =>
      UpcomingMoviesEntity(
        dates: DatesEntity.fromJson(json["dates"]),
        page: json["page"],
        results: List<UpcomingMovieEntity>.from(
            json["results"].map((x) => UpcomingMovieEntity.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}

class DatesEntity {
  DateTime maximum;
  DateTime minimum;

  DatesEntity({
    required this.maximum,
    required this.minimum,
  });

  factory DatesEntity.fromJson(Map<String, dynamic> json) => DatesEntity(
        maximum: DateTime.parse(json["maximum"]),
        minimum: DateTime.parse(json["minimum"]),
      );
}

class UpcomingMovieEntity {
  bool adult;
  String? backdropPath;
  List<int> genreIds;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String? posterPath;
  DateTime releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  UpcomingMovieEntity({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory UpcomingMovieEntity.fromJson(Map<String, dynamic> json) =>
      UpcomingMovieEntity(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        releaseDate: DateTime.parse(json["release_date"]),
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
      );
}
