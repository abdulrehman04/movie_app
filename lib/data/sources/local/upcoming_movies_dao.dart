import 'package:cowlar_task/data/models/upcoming_movies_model.dart';
import 'package:floor/floor.dart';

@dao
abstract class UpcomingMoviesDao {
  @Insert()
  Future<void> saveMovie(UpcomingMovie movie);

  @Query('SELECT * FROM upcomingMovie')
  Future<List<UpcomingMovie>> getLocalMovies();
}
