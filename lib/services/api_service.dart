import 'dart:convert';

import 'package:cowlar_task/data/models/response_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiService {
  Future<ResponseModel> get(String url, {bool usesAuth = true}) async {
    try {
      Map<String, String>? headers = {};
      if (usesAuth) {
        headers.addAll({'Authorization': 'Bearer ${dotenv.env['KEY']}'});
      }
      Response response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
      final body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return ResponseModel(
          data: body,
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
