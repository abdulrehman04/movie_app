import 'package:cowlar_task/data/models/movie_detail_model.dart';
import 'package:cowlar_task/data/models/movie_videos_model.dart';
import 'package:cowlar_task/data/models/response_model.dart';
import 'package:cowlar_task/data/models/upcoming_movies_model.dart';
import 'package:cowlar_task/data/sources/local/database.dart';
import 'package:cowlar_task/data/sources/remote/movie_data_source.dart';
import 'package:cowlar_task/domain/repositories/movie_repository.dart';

class MovieRepoImpl implements MovieRepository {
  final AppDatabase _appDatabase;
  MovieRepoImpl(this._appDatabase);

  @override
  Future<ResponseModel<UpcomingMoviesModel>> fetchUpcomingMovies(
    int page,
  ) async {
    ResponseModel response = await MovieDataSource().fetchUpcomingMovies(page);
    if (!response.hasError) {
      return ResponseModel(
        data: UpcomingMoviesModel.fromJson(response.data),
      );
    }
    return ResponseModel(data: null, hasError: true);
  }

  @override
  Future<ResponseModel<MovieDetailModel>> getMovieDetails(int id) async {
    ResponseModel response = await MovieDataSource().getMovieDetails(id);
    if (!response.hasError) {
      return ResponseModel(
        data: MovieDetailModel.fromJson(response.data),
      );
    }
    return ResponseModel(data: null, hasError: true);
  }

  @override
  Future<ResponseModel<MovieVideosModel>> getMovieVideos(int id) async {
    ResponseModel response = await MovieDataSource().getMovieVideos(id);
    if (!response.hasError) {
      return ResponseModel(
        data: MovieVideosModel.fromJson(response.data),
      );
    }
    return ResponseModel(data: null, hasError: true);
  }

  // Offline methods
  @override
  Future<List<UpcomingMovie>> getSavedMovies() async {
    return await _appDatabase.upcomingDao.getLocalMovies();
  }

  @override
  Future<void> saveMovie(UpcomingMovie movie) async {
    await _appDatabase.upcomingDao.saveMovie(movie);
  }
}
