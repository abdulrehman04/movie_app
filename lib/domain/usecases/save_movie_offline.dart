import 'package:cowlar_task/core/usecase/usecase.dart';
import 'package:cowlar_task/data/models/upcoming_movies_model.dart';
import 'package:cowlar_task/domain/repositories/movie_repository.dart';

class SaveMovieOffline implements Usecase<void, UpcomingMovie> {
  final MovieRepository _movieRepository;

  SaveMovieOffline(this._movieRepository);
  @override
  Future<void> call({UpcomingMovie? params}) async {
    await _movieRepository.saveMovie(params!);
  }
}
