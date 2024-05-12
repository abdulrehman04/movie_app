import 'package:cowlar_task/data/repositories/movie_repo_impl.dart';
import 'package:cowlar_task/domain/repositories/movie_repository.dart';
import 'package:cowlar_task/domain/usecases/fetch_upcoming_movies.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerSingleton<MovieRepository>(MovieRepoImpl());
  getIt.registerSingleton<FetchUpcomingMovies>(FetchUpcomingMovies(getIt()));
}
