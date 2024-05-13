import 'package:cowlar_task/data/models/movie_detail_model.dart';
import 'package:cowlar_task/data/models/movie_videos_model.dart';
import 'package:cowlar_task/data/models/response_model.dart';
import 'package:cowlar_task/data/models/upcoming_movies_model.dart';

abstract class MovieRepository {
  Future<ResponseModel<UpcomingMoviesModel>> fetchUpcomingMovies(int page);
  Future<ResponseModel<MovieDetailModel>> getMovieDetails(int id);
  Future<ResponseModel<MovieVideosModel>> getMovieVideos(int id);
}
