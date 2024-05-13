import 'package:cowlar_task/data/models/movie_detail_model.dart';
import 'package:cowlar_task/data/models/movie_videos_model.dart';
import 'package:cowlar_task/data/models/response_model.dart';
import 'package:cowlar_task/data/models/upcoming_movies_model.dart';
import 'package:cowlar_task/data/sources/local/database.dart';
import 'package:cowlar_task/data/sources/remote/movie_data_source.dart';
import 'package:cowlar_task/domain/repositories/movie_repository.dart';

class MovieRepoImpl implements MovieRepository {
  final AppDatabase _appDatabase;
  final MovieDataSource _movieDataSource;
  MovieRepoImpl(this._appDatabase, this._movieDataSource);

  @override
  Future<ResponseModel<UpcomingMoviesModel>> fetchUpcomingMovies(
    int page,
  ) async {
    ResponseModel response = await _movieDataSource.fetchUpcomingMovies(page);
    if (!response.hasError) {
      return ResponseModel(
        data: UpcomingMoviesModel.fromJson(response.data),
      );
    }
    return ResponseModel(data: null, hasError: true);
  }

  @override
  Future<ResponseModel<MovieDetailModel>> getMovieDetails(int id) async {
    ResponseModel response = await _movieDataSource.getMovieDetails(id);
    if (!response.hasError) {
      return ResponseModel(
        data: MovieDetailModel.fromJson(response.data),
      );
    }
    return ResponseModel(data: null, hasError: true);
  }

  @override
  Future<ResponseModel<MovieVideosModel>> getMovieVideos(int id) async {
    ResponseModel response = await _movieDataSource.getMovieVideos(id);
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
  Future<bool> saveMovie(UpcomingMovie movie) async {
    try {
      await _appDatabase.upcomingDao.saveMovie(movie);
      return true;
    } catch (e) {
      return false;
    }
  }
}
