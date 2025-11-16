//lib\services\auth_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = "https://api.astrum.app.br";
  static String? token;

  static Future<bool> login(String login, String password) async {
    final url = Uri.parse("$baseUrl/auth/login");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "login": login,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Valida se realmente existe token
        if (data["token"] == null) {
          print("ERRO: token não recebido");
          return false;
        }

        token = data["token"];
        print("TOKEN RECEBIDO: $token");
        return true;
      }

      print("LOGIN FALHOU (${response.statusCode}): ${response.body}");
      return false;
    } catch (e) {
      print("EXCEPTION LOGIN: $e");
      return false;
    }
  }
}
