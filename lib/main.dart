import 'package:flutter/material.dart';
import 'package:mobile/Screens/AboutScreen.dart';
import 'package:mobile/Screens/AccountScreen.dart';
import 'package:mobile/Screens/SplashScreen.dart';
import 'package:mobile/Screens/HomeScreen.dart';
import 'package:mobile/Screens/LoginScreen.dart';
import 'package:mobile/Screens/ProfileScreen.dart';
import 'package:mobile/Screens/SignUpScreen.dart';

import 'Utils/Constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MaterialApp(
      title: 'Travel booking',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

