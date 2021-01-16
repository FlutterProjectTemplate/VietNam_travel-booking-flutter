
import 'package:mobile/Models/Exception.dart';
import 'package:mobile/Models/LoginRequest.dart';
import 'package:mobile/Models/LoginResponse.dart';
import 'package:mobile/Models/Tour.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Api{
  static const String _baseUrl = "https://travelbooking4uit.herokuapp.com/";

  static Future<LoginResponse> login(LoginRequest loginRequest) async {
    final response = await http.post(
      '${_baseUrl}api/public/auth/login',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(loginRequest.toJson()),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return LoginResponse.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(CustomException.fromJson(json.decode(utf8.decode(response.bodyBytes))).message);
    }
  }

}

