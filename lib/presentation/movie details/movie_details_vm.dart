import 'package:cowlar_task/core/injection/dependency_injection.dart';
import 'package:cowlar_task/domain/usecases/get_movie_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieDetailsViewModelProvider = ChangeNotifierProvider((ref) {
  return MovieDetailsViewModel(getIt());
});

class MovieDetailsViewModel extends ChangeNotifier {
  final GetMovieDetails _getMovieDetails;
  MovieDetailsViewModel(this._getMovieDetails);
  late int movieId;
  void init(int id) {
    movieId = id;
    fetchMovieDetails();
  }

  fetchMovieDetails() {
    _getMovieDetails(params: movieId);
  }
}
