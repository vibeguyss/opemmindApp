import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  final String baseUrl;
  ApiClient({required this.baseUrl});

  Future<Map<String, String>> _getHeaders({bool withToken = true}) async {
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

  Future<http.Response> get(
      String path, {
        Map<String, String>? queryParameters,
        bool withToken = true,
      }) async {
    final uri = Uri.parse('$baseUrl$path').replace(queryParameters: queryParameters);
    final headers = await _getHeaders(withToken: withToken);

    return await http.get(uri, headers: headers);
  }

  Future<http.Response> post(
      String path, {
        Map<String, dynamic>? body,
        bool withToken = true,
      }) async {
    final uri = Uri.parse('$baseUrl$path');
    final headers = await _getHeaders(withToken: withToken);
    final jsonBody = body != null ? jsonEncode(body) : null;

    return await http.post(uri, headers: headers, body: jsonBody);
  }
}
