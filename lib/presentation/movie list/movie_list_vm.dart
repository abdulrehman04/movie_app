import 'package:cowlar_task/core/injection/dependency_injection.dart';
import 'package:cowlar_task/data/models/response_model.dart';
import 'package:cowlar_task/data/models/upcoming_movies_model.dart';
import 'package:cowlar_task/domain/usecases/fetch_upcoming_movies.dart';
import 'package:cowlar_task/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieListvmProvider = ChangeNotifierProvider((ref) {
  return MovieListViewModel(getIt());
});

class MovieListViewModel extends ChangeNotifier {
  final FetchUpcomingMovies _fetchUpcomingMovies;
  MovieListViewModel(this._fetchUpcomingMovies);

  List<UpcomingMovie> upcomingMovies = [];
  bool isFetching = false;
  int page = 1;
  late int totalPages;

  getMovies() async {
    updateFetching(true, shouldNotify: false);
    ResponseModel<UpcomingMoviesModel> upcomingMoviesModel =
        await _fetchUpcomingMovies(params: page);
    if (upcomingMoviesModel.hasError) {
      Utils.showSnackbar(message: upcomingMoviesModel.errorMessage);
      updateFetching(false);
      return;
    }
    totalPages = upcomingMoviesModel.data?.totalPages ?? 1;
    upcomingMoviesModel.data?.results.forEach((element) {
      upcomingMovies.add(element);
    });
    updateFetching(false);
  }

  updateFetching(bool val, {shouldNotify = true}) {
    isFetching = val;
    if (shouldNotify) notifyListeners();
  }

  void fetchMoreMovies() {
    page++;
    getMovies();
  }

  bool hasMoreMovies() {
    return page < totalPages;
  }

  get getListLength => upcomingMovies.length + (isFetching ? 1 : 0);

  bool shouldFetchMore(int index) {
    return index == upcomingMovies.length - 1 && hasMoreMovies();
  }
}
