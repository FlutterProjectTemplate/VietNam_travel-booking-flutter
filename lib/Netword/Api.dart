import 'package:mobile/Models/Tour.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Api{
  static const String _baseUrl = "https://run.mocky.io/v3/";
  Future<List<Tour>> fetch() async {
    final response = await http.get('https://travelbooking4uit.herokuapp.com/api/public/tour/');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final jsonresponse = json.decode(response.body);
      return (jsonresponse as List).map((p)=>Tour.fromJson(p)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load tour');
    }
  }
  Future fetchTour() async {
    http.Response response;
    response= await http.get('https://travelbooking4uit.herokuapp.com/api/public/tour/100000');
    if(response.statusCode==200){

        return Tour.fromJson(jsonDecode(response.body));
    }
  }
  Future<List<Tour>> fetchTours() async {
    http.Response response;
    response= await http.get('https://travelbooking4uit.herokuapp.com/api/public/tour/');
    if(response.statusCode==200){

        return (json.decode(response.body) as List).map((p)=>Tour.fromJson(p)).toList();

    }
  }
}

