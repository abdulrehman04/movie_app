import 'package:cowlar_task/data/models/movie_detail_model.dart';
import 'package:cowlar_task/data/models/response_model.dart';
import 'package:cowlar_task/data/models/upcoming_movies_model.dart';
import 'package:cowlar_task/data/sources/movie_data_source.dart';
import 'package:cowlar_task/domain/repositories/movie_repository.dart';

class MovieRepoImpl implements MovieRepository {
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
}
