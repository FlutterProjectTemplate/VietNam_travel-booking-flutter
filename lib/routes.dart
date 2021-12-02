import 'package:flutter/widgets.dart';
import 'package:mobile/Screens/AccountScreen.dart';
import 'package:mobile/Screens/CommentScreen.dart';
import 'package:mobile/Screens/CommunityScreen.dart';
import 'package:mobile/Screens/DetailedTourScreen.dart';
import 'package:mobile/Screens/FavouriteScreen.dart';
import 'package:mobile/Screens/HistoryScreen.dart';
import 'package:mobile/Screens/HomeScreen.dart';
import 'package:mobile/Screens/LoginScreen.dart';
import 'package:mobile/Screens/PaymentScreen.dart';
import 'package:mobile/Screens/ProfileScreen.dart';
import 'package:mobile/Screens/SearchScreen.dart';
import 'package:mobile/Screens/SignUpScreen.dart';
import 'package:mobile/Screens/TourBookingScreen.dart';
import 'package:mobile/Screens/TourListScreen.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    "/": (context) =>HomeScreen(),
    "/account": (context) =>AccountScreen(),
    "/comment": (context) =>CommentScreen(0),
    "/community": (context) =>CommunityScreen(),
    "/detailed-tour-screen": (context) =>DetailedTourScreen(0),
    "/favourite": (context) =>FavouriteScreen(),
    "/history": (context) =>HistoryScreen(),
    "/home": (context) =>HomeScreen(),
    "/login": (context) =>LoginScreen(),
    "/payment": (context) =>PaymentScreen(),
    "/profile": (context) =>ProfileScreen(),
    "/search": (context) =>SearchScreen(),
    "/sign-up": (context) =>SignUpScreen(),
    "/tour-booking": (context) =>TourBookingScreen(null),
    "/tour-list": (context) =>TourListScreen(null),
};
