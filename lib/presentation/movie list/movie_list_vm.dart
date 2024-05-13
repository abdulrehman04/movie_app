import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cowlar_task/core/injection/dependency_injection.dart';
import 'package:cowlar_task/data/models/response_model.dart';
import 'package:cowlar_task/data/models/upcoming_movies_model.dart';
import 'package:cowlar_task/domain/usecases/fetch_upcoming_movies.dart';
import 'package:cowlar_task/domain/usecases/get_offline_movies.dart';
import 'package:cowlar_task/domain/usecases/save_movie_offline.dart';
import 'package:cowlar_task/services/internet_connectivity_service.dart';
import 'package:cowlar_task/services/shared_pref_service.dart';
import 'package:cowlar_task/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final movieListvmProvider = ChangeNotifierProvider((ref) {
  return MovieListViewModel(getIt(), getIt(), getIt());
});

class MovieListViewModel extends ChangeNotifier {
  final FetchUpcomingMovies _fetchUpcomingMovies;
  final GetOfflineMovies _getOfflineMovies;
  final SaveMovieOffline _saveMovieOffline;
  MovieListViewModel(
    this._fetchUpcomingMovies,
    this._getOfflineMovies,
    this._saveMovieOffline,
  );

  List<UpcomingMovie> upcomingMovies = [];
  bool isFetching = false;
  int page = 1;
  late int totalPages = 2;
  final SharedPrefService _sharedPrefService = getIt<SharedPrefService>();

  init() {
    getMovies();
  }

  getMovies() async {
    if (await InternetConnectionChecker().hasConnection) {
      fetchRemoteMovies();
    } else {
      page = _sharedPrefService.getInt('page');
      if (page == -1) {
        page = 1;
      }
      totalPages = page;
      startInternetCheckStream();
      getOfflineMovies();
    }
  }

  fetchRemoteMovies() async {
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
      try {
        _saveMovieOffline(params: element);
      } catch (e) {
        debugPrint('Failed to save offline');
      }
      upcomingMovies.add(element);
    });
    updateFetching(false);
  }

  getOfflineMovies() async {
    upcomingMovies = await _getOfflineMovies();
    updateFetching(false);
  }

  updateFetching(bool val, {shouldNotify = true}) {
    isFetching = val;
    if (shouldNotify) notifyListeners();
  }

  void fetchMoreMovies() {
    page++;
    _sharedPrefService.setInt('page', page);
    getMovies();
  }

  bool hasMoreMovies() {
    return page < totalPages;
  }

  get getListLength => upcomingMovies.length + (isFetching ? 1 : 0);

  bool shouldFetchMore(int index) {
    return index == upcomingMovies.length - 1 && hasMoreMovies();
  }

  void startInternetCheckStream() {
    InternetConnectivityService().getConnectivityStream().listen((event) async {
      if (event != ConnectivityResult.none &&
          await InternetConnectionChecker().hasConnection) {
        fetchMoreMovies();
      }
    });
  }
}
