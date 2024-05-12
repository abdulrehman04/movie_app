import 'dart:convert';

import 'package:cowlar_task/core/constants/strings.dart';
import 'package:cowlar_task/data/models/response_model.dart';
import 'package:cowlar_task/data/models/upcoming_movies_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class MovieDataSource {
  Future<ResponseModel<UpcomingMoviesModel>> fetchUpcomingMovies(
    int page,
  ) async {
    try {
      Response response = await http.get(
        Uri.parse('${ApiUrls.upcomingMoviesUrl}$page'),
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjNzlhZjA0ZGU3ODRlMTcyOTUwNjA4ZWEwMDVhOGVhMyIsInN1YiI6IjY2NDAxMzU0ZGMzY2YyYzI0ZDQzODE0YSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.s-ukjyN01FN8RMAJuNQjfyYy8Ft_vrUNGStWnyvh2Ck'
        },
      );
      final body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return ResponseModel(
          data: UpcomingMoviesModel.fromJson(body),
          hasError: false,
        );
      }
      return ResponseModel(
        errorMessage: body['status_message'] ?? 'API error',
        hasError: false,
      );
    } catch (e) {
      return ResponseModel(
        errorMessage: 'An error has occurred',
        hasError: false,
      );
    }
  }
}
