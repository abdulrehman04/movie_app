import 'package:cowlar_task/data/repositories/movie_repo_impl.dart';
import 'package:cowlar_task/data/sources/local/database.dart';
import 'package:cowlar_task/domain/repositories/movie_repository.dart';
import 'package:cowlar_task/domain/usecases/fetch_upcoming_movies.dart';
import 'package:cowlar_task/domain/usecases/get_movie_details.dart';
import 'package:cowlar_task/domain/usecases/get_movie_videos.dart';
import 'package:cowlar_task/domain/usecases/get_offline_movies.dart';
import 'package:cowlar_task/domain/usecases/save_movie_offline.dart';
import 'package:cowlar_task/services/shared_pref_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // Database
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  getIt.registerSingleton<AppDatabase>(database);

  // Repos
  getIt.registerSingleton<MovieRepository>(MovieRepoImpl(getIt(), getIt()));

  // Usecases
  getIt.registerSingleton<FetchUpcomingMovies>(FetchUpcomingMovies(getIt()));
  getIt.registerSingleton<GetMovieDetails>(GetMovieDetails(getIt()));
  getIt.registerSingleton<GetMovieVideos>(GetMovieVideos(getIt()));

  //Offline usecases
  getIt.registerSingleton<GetOfflineMovies>(GetOfflineMovies(getIt()));
  getIt.registerSingleton<SaveMovieOffline>(SaveMovieOffline(getIt()));

  // Services
  getIt.registerSingleton<SharedPrefService>(SharedPrefService());
}
