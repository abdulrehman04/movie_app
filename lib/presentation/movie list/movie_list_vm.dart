import 'package:cowlar_task/core/injection/dependency_injection.dart';
import 'package:cowlar_task/data/models/response_model.dart';
import 'package:cowlar_task/data/models/upcoming_movies_model.dart';
import 'package:cowlar_task/domain/usecases/fetch_upcoming_movies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieListvmProvider = ChangeNotifierProvider((ref) {
  return MovieListViewModel(getIt());
});

class MovieListViewModel extends ChangeNotifier {
  final FetchUpcomingMovies _fetchUpcomingMovies;
  MovieListViewModel(this._fetchUpcomingMovies);

  List<UpcomingMovie> upcomingMovies = [];

  getMovies() async {
    ResponseModel<UpcomingMoviesModel> upcomingMoviesModel =
        await _fetchUpcomingMovies(params: 5);
    if (upcomingMoviesModel.hasError) {
      // Show error
      print('error');
      return;
    }
    print(upcomingMoviesModel.data?.page);
    upcomingMoviesModel.data?.results.forEach((element) {
      upcomingMovies.add(element);
    });
    print(upcomingMovies);
  }
}
