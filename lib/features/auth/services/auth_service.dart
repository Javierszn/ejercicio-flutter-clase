import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mi_primera_app/core/constants/api_constants.dart';
import 'package:mi_primera_app/core/storage/local_storage_service.dart';

class AuthService {
  Future<bool> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.loginEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['accessToken'] ?? data['token'];
        if (token != null) {
          await LocalStorageService.saveToken(token);
        }
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
