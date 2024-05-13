import 'package:cowlar_task/core/usecase/usecase.dart';
import 'package:cowlar_task/data/models/upcoming_movies_model.dart';
import 'package:cowlar_task/domain/repositories/movie_repository.dart';

class GetOfflineMovies implements Usecase<List<UpcomingMovie>, void> {
  final MovieRepository _movieRepository;

  GetOfflineMovies(this._movieRepository);
  @override
  Future<List<UpcomingMovie>> call({void params}) async {
    return await _movieRepository.getSavedMovies();
  }
}
