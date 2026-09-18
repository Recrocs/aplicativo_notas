import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  Future<bool> login(
    String usuario,
    String senha,
  ) async {
    final url = Uri.parse(
      'https://dummyjson.com/auth/login',
    );

    final resposta = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': usuario,
        'password': senha,
      }),
    );

    if (resposta.statusCode == 200) {
      return true;
    }

    return false;
  }
}