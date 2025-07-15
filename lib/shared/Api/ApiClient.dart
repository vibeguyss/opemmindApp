import 'package:http/http.dart' as http;
import 'package:openmind_app/shared/Api/BaseUrl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ApiClient {
  static const int _maxRetries = 1;

  Future<http.Response> get(String path, {bool withToken = true}) async {
    return _sendRequest(
          () => http.get(Uri.parse('${BaseUrl.baseUrl}$path'), headers: null), // Headers will be added in _sendRequest
      path,
      'GET',
      withToken,
      null,
    );
  }

  Future<http.Response> post(
      String path, {
        Map<String, dynamic>? body,
        bool withToken = true,
      }) async {
    return _sendRequest(
          () => http.post(Uri.parse('${BaseUrl.baseUrl}$path'), headers: null, body: jsonEncode(body)),
      path,
      'POST',
      withToken,
      body,
    );
  }

  // Generic method to send requests and handle interception
  Future<http.Response> _sendRequest(
      Future<http.Response> Function() requestBuilder,
      String path,
      String method,
      bool withToken,
      Map<String, dynamic>? requestBody,
      [int retryCount = 0]) async {
    final headers = await _getHeaders(withToken);
    http.Response response;

    // Rebuild the request with headers
    if (method == 'GET') {
      response = await http.get(Uri.parse('${BaseUrl.baseUrl}$path'), headers: headers);
    } else if (method == 'POST') {
      response = await http.post(Uri.parse('${BaseUrl.baseUrl}$path'), headers: headers, body: jsonEncode(requestBody));
    } else {
      throw UnsupportedError('Unsupported HTTP method: $method');
    }


    // Token refresh logic (interceptor)
    if (withToken && (response.statusCode == 401 || response.statusCode == 403)) {
      print('Token expired or unauthorized. Attempting to refresh token...');
      if (retryCount < _maxRetries) {
        final success = await _refreshToken();
        if (success) {
          print('Token refreshed successfully. Retrying original request...');
          return _sendRequest(requestBuilder, path, method, withToken, requestBody, retryCount + 1);
        } else {
          print('Failed to refresh token. Logging out...');
          await _clearAuthTokens();
          throw Exception('Session expired. Please log in again.');
        }
      } else {
        print('Max retries reached for token refresh. Logging out...');
        await _clearAuthTokens();
        throw Exception('Session expired. Please log in again.');
      }
    }

    return response;
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

  Future<bool> _refreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    final refreshToken = prefs.getString('refreshToken');

    if (refreshToken == null) {
      print('No refresh token found.');
      return false;
    }

    try {
      final url = Uri.parse('${BaseUrl.baseUrl}/auth/refresh');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'refreshToken': refreshToken}),
      );

      if (response.statusCode == 200) {
        final jsonMap = jsonDecode(response.body);
        final data = jsonMap['data'];
        if (data != null && data['accessToken'] != null && data['refreshToken'] != null) {
          await prefs.setString('accessToken', data['accessToken']);
          await prefs.setString('refreshToken', data['refreshToken']);
          print('Tokens refreshed successfully.');
          return true;
        }
      }
      print('Failed to refresh token. Status: ${response.statusCode}, Body: ${response.body}');
      return false;
    } catch (e) {
      print('Error during token refresh: $e');
      return false;
    }
  }

  Future<void> _clearAuthTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    await prefs.remove('refreshToken');
  }
}