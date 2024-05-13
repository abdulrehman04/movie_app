import 'package:cowlar_task/core/usecase/usecase.dart';
import 'package:cowlar_task/data/models/movie_videos_model.dart';
import 'package:cowlar_task/data/models/response_model.dart';
import 'package:cowlar_task/domain/repositories/movie_repository.dart';

class GetMovieVideos implements Usecase<ResponseModel<MovieVideosModel>, int> {
  GetMovieVideos(this.movieRepository);
  final MovieRepository movieRepository;

  @override
  Future<ResponseModel<MovieVideosModel>> call({int? params}) async {
    return await movieRepository.getMovieVideos(params ?? 0);
  }
}
