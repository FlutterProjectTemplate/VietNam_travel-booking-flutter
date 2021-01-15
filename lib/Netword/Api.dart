import 'package:mobile/Models/Tour.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Api{
  static const String _baseUrl = "https://run.mocky.io/v3/";

  Future<Tour> fetchTour() async {
    final response = await http.get('0f605429-0dbe-4d41-893d-da08c1cb698f?fbclid=IwAR07fYzoYXwFe5NI_9Bl0oyfHIM2tPxxMoAPpqOiv7DezTFLc1jjDXO5ofg');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Tour.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load tour');
    }
  }

}

