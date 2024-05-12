import 'package:cowlar_task/data/models/response_model.dart';
import 'package:cowlar_task/data/models/upcoming_movies_model.dart';

abstract class MovieRepository {
  Future<ResponseModel<UpcomingMoviesModel>> fetchUpcomingMovies(int page);
  Future<ResponseModel<UpcomingMoviesModel>> getMovieDetails(int id);
}
