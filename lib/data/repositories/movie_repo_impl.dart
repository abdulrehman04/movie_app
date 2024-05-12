import 'package:cowlar_task/data/models/response_model.dart';
import 'package:cowlar_task/data/models/upcoming_movies_model.dart';
import 'package:cowlar_task/data/sources/movie_data_source.dart';
import 'package:cowlar_task/domain/repositories/movie_repository.dart';

class MovieRepoImpl implements MovieRepository {
  @override
  Future<ResponseModel<UpcomingMoviesModel>> fetchUpcomingMovies(
    int page,
  ) async {
    return await MovieDataSource().fetchUpcomingMovies(page);
  }

  @override
  Future<ResponseModel<UpcomingMoviesModel>> getMovieDetails(int id) async {
    return await MovieDataSource().getMovieDetails(id);
  }
}
