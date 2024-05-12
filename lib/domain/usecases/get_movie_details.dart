import 'package:cowlar_task/core/usecase/usecase.dart';
import 'package:cowlar_task/data/models/movie_detail_model.dart';
import 'package:cowlar_task/data/models/response_model.dart';
import 'package:cowlar_task/domain/repositories/movie_repository.dart';

class GetMovieDetails implements Usecase<ResponseModel<MovieDetailModel>, int> {
  GetMovieDetails(this.movieRepository);
  final MovieRepository movieRepository;

  @override
  Future<ResponseModel<MovieDetailModel>> call({int? params}) async {
    return await movieRepository.getMovieDetails(params ?? 0);
  }
}
