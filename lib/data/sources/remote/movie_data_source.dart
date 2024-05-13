import 'package:cowlar_task/core/constants/strings.dart';
import 'package:cowlar_task/data/models/response_model.dart';
import 'package:cowlar_task/services/api_service.dart';

class MovieDataSource {
  Future<ResponseModel> fetchUpcomingMovies(int page) async {
    return await ApiService().get('${ApiUrls.upcomingMoviesUrl}$page');
  }

  Future<ResponseModel> getMovieDetails(int id) async {
    return await ApiService().get('${ApiUrls.movieBaseUrl}/$id');
  }

  Future<ResponseModel> getMovieVideos(int id) async {
    return await ApiService().get('${ApiUrls.movieBaseUrl}/$id/videos');
  }
}
