import 'package:cowlar_task/core/injection/dependency_injection.dart';
import 'package:cowlar_task/data/models/movie_detail_model.dart';
import 'package:cowlar_task/data/models/movie_videos_model.dart';
import 'package:cowlar_task/data/models/response_model.dart';
import 'package:cowlar_task/domain/usecases/get_movie_videos.dart';
import 'package:cowlar_task/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

final videoPlayerViewModelProvider = ChangeNotifierProvider((ref) {
  return VideoPlayerViewModel(getIt());
});

class VideoPlayerViewModel extends ChangeNotifier {
  final GetMovieVideos _getMovieVideos;
  VideoPlayerViewModel(this._getMovieVideos);

  late YoutubePlayerController youtubeController;
  bool isLoading = false;
  late int movieId;
  late MovieVideosModel videos;

  Future<void> init(int id) async {
    isLoading = true;
    movieId = id;
    await fetchVideos();
    print('here');
    initYoutube(getTrailerId());
  }

  Future<void> fetchVideos() async {
    ResponseModel<MovieVideosModel> movieDetail = await _getMovieVideos(
      params: movieId,
    );
    if (movieDetail.hasError) {
      Utils.showSnackbar(message: movieDetail.errorMessage);
      updateLoading(false);
      return;
    }
    if (movieDetail.data != null) {
      videos = movieDetail.data!;
    }
    updateLoading(false);
  }

  getTrailerId() {
    return videos.results
        .firstWhere((element) => element.type == Type.TRAILER)
        .key;
  }

  initYoutube(String videoId) {
    youtubeController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
      ),
    );
    youtubeController.toggleFullScreenMode();
  }

  updateLoading(bool val) {
    isLoading = val;
    notifyListeners();
  }
}
