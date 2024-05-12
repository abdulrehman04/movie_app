import 'package:cowlar_task/core/injection/dependency_injection.dart';
import 'package:cowlar_task/data/models/movie_detail_model.dart';
import 'package:cowlar_task/data/models/response_model.dart';
import 'package:cowlar_task/domain/usecases/get_movie_details.dart';
import 'package:cowlar_task/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieDetailsViewModelProvider = ChangeNotifierProvider((ref) {
  return MovieDetailsViewModel(getIt());
});

class MovieDetailsViewModel extends ChangeNotifier {
  final GetMovieDetails _getMovieDetails;
  MovieDetailsViewModel(this._getMovieDetails);

  bool isLoading = false;
  late MovieDetailModel movie;
  late int movieId;

  void init(int id) {
    movieId = id;
    isLoading = true;
    fetchMovieDetails();
  }

  fetchMovieDetails() async {
    ResponseModel<MovieDetailModel> movieDetail = await _getMovieDetails(
      params: movieId,
    );
    if (movieDetail.hasError) {
      Utils.showSnackbar(message: movieDetail.errorMessage);
      updateLoading(false);
      return;
    }
    if (movieDetail.data != null) {
      movie = movieDetail.data!;
    }

    updateLoading(false);
  }

  updateLoading(bool val) {
    isLoading = val;
    notifyListeners();
  }
}
