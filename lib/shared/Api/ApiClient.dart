import 'package:http/http.dart' as http;
import 'package:openmind_app/shared/Api/BaseUrl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ApiClient {
  Future<http.Response> get(String path, {bool withToken = true}) async {
    final url = Uri.parse('${BaseUrl.baseUrl}$path');
    final headers = await _getHeaders(withToken);
    return http.get(url, headers: headers);
  }

  Future<http.Response> post(
      String path, {
        Map<String, dynamic>? body,
        bool withToken = true,
      }) async {
    final url = Uri.parse('${BaseUrl.baseUrl}$path');
    final headers = await _getHeaders(withToken);
    return http.post(url, headers: headers, body: jsonEncode(body));
  }

  Future<Map<String, String>> _getHeaders(bool withToken) async {
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };

    if (withToken) {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken');
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
    }

    return headers;
  }
}
