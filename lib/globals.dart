library my_prj.globals;

import 'package:mobile/Models/LoginResponse.dart';

import 'Models/Tour.dart';

bool isLoggedIn = false;
LoginResponse loginResponse;// TODO Implement this library.
List<Tour> tours;
Future<List<Tour>> futureTour;