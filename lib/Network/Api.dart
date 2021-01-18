import 'dart:io';

import 'package:mobile/Models/Exception.dart';
import 'package:mobile/Models/LoginRequest.dart';
import 'package:mobile/Models/LoginResponse.dart';
import 'package:mobile/Models/Post.dart';
import 'package:mobile/Models/PostRequest.dart';
import 'package:mobile/Models/SearchRequest.dart';
import 'package:mobile/Models/Tour.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/Models/User.dart';
import 'dart:convert';

import 'package:mobile/Screens/TourListScreen.dart';

class Api {
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
      return LoginResponse.fromJson(
          json.decode(utf8.decode(response.bodyBytes)));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(
          CustomException.fromJson(json.decode(utf8.decode(response.bodyBytes)))
              .message);
    }
  }

  static Future<List<Tour>> search(SearchRequest searchRequest) async {
    final response = await http.post(
      '${_baseUrl}api/public/tour/search',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(searchRequest.toJson()),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return (json.decode(utf8.decode(response.bodyBytes)) as List)
          .map((p) => Tour.fromJson(p))
          .toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(
          CustomException.fromJson(json.decode(utf8.decode(response.bodyBytes)))
              .message);
    }
  }

  static Future<List<Tour>> getTour() async {
    http.Response response;
    response = await http
        .get('https://travelbooking4uit.herokuapp.com/api/public/tour/');
    if (response.statusCode == 200) {
      return (json.decode(utf8.decode(response.bodyBytes)) as List)
          .map((p) => Tour.fromJson(p))
          .toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(
          CustomException.fromJson(json.decode(utf8.decode(response.bodyBytes)))
              .message);
    }
  }

  static Future<Tour> fetchTour(int id) async {
    http.Response response;
    response = await http
        .get('https://travelbooking4uit.herokuapp.com/api/public/tour/$id');
    if (response.statusCode == 200) {
      return Tour.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(
          CustomException.fromJson(json.decode(utf8.decode(response.bodyBytes)))
              .message);
    }
  }

  static Future<User> signUp(User user) async {
    final response = await http.post(
      '${_baseUrl}api/public/auth/create',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return User.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(
          CustomException.fromJson(json.decode(utf8.decode(response.bodyBytes)))
              .message);
    }
  }
  static Future<List<Post>> getPosts() async {
    http.Response response;
    response= await http.get('https://travelbooking4uit.herokuapp.com/api/public/posts/');
    if(response.statusCode==200){

      return (json.decode(utf8.decode(response.bodyBytes)) as List).map((p) =>
          Post.fromJson(p)).toList();

    }else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(CustomException
          .fromJson(json.decode(utf8.decode(response.bodyBytes)))
          .message);
    }
  }
  static Future<Post> getPost(int id) async {
    http.Response response;
    response= await http.get('https://travelbooking4uit.herokuapp.com/api/public/posts/$id');
    if(response.statusCode==200){

      return Post.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));

    }else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(CustomException
          .fromJson(json.decode(utf8.decode(response.bodyBytes)))
          .message);
    }
  }
  static Future post(PostRequest postRequest,String auth) async {
    final response = await http.post(
      '${_baseUrl}api/public/tour/search',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': '$auth',
      },
      body: jsonEncode(postRequest.toJson()),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return HttpStatus.ok;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(
          CustomException.fromJson(json.decode(utf8.decode(response.bodyBytes)))
              .message);
    }
  }
}
