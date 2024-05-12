import 'package:cowlar_task/core/usecase/usecase.dart';
import 'package:cowlar_task/data/models/response_model.dart';
import 'package:cowlar_task/data/models/upcoming_movies_model.dart';
import 'package:cowlar_task/domain/repositories/movie_repository.dart';

class FetchUpcomingMovies
    implements Usecase<ResponseModel<UpcomingMoviesModel>, int> {
  FetchUpcomingMovies(this.movieRepository);
  final MovieRepository movieRepository;

  @override
  Future<ResponseModel<UpcomingMoviesModel>> call({int? params}) async {
    return await movieRepository.fetchUpcomingMovies(params ?? 0);
  }
}
