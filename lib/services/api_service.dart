import 'dart:convert';
import 'package:http/http.dart' as http;

import '../core/constants/app_config.dart';

class ApiService {
  Future<dynamic> get(String endpoint, {String? token}) async {
    final response = await http.get(
      Uri.parse('${AppConfig.baseUrl}$endpoint'),
      headers: _headers(token),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    }

    throw Exception('Erreur API ${response.statusCode}: ${response.body}');
  }

  Future<dynamic> post(
    String endpoint,
    Map<String, dynamic> body, {
    String? token,
  }) async {
    final response = await http.post(
      Uri.parse('${AppConfig.baseUrl}$endpoint'),
      headers: _headers(token),
      body: jsonEncode(body),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    }

    throw Exception('Erreur API ${response.statusCode}: ${response.body}');
  }

  Map<String, String> _headers(String? token) {
    return {
      'Content-Type': 'application/json',
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
  }
}
