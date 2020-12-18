import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/Screens/AccountScreen.dart';
import 'package:mobile/Screens/HomeScreen.dart';

import 'TourListScreen.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  int _selectedIndex = 0;
  int _lastSelectedIndex = -1;

  void _onItemTapped(int index) {
    if (index != _lastSelectedIndex) {
      setState(() {
        _selectedIndex = index;
        _lastSelectedIndex = _selectedIndex;
        // if (_selectedIndex != _lastSelectedIndex) {
        //   _navigatorKey.currentState.pushReplacementNamed("/${index}");
        //   _lastSelectedIndex = _selectedIndex;
        // }
      });
    }
  }

  Widget _MyNavigator() {
    Scaffold scaffold = new Scaffold();
    switch (_selectedIndex) {
      case 0:
        return HomeScreen();
        break;
      case 1:
        return AccountScreen();
        case 2:
        return TourListScreen();
      case 3:
        return AccountScreen();
        break;
      default:
        return HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _MyNavigator(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.black,
        onTap: (value) {
          // Respond to item press.
          _onItemTapped(value);
        },
        items: [
          BottomNavigationBarItem(
            title: Text('Trang chủ'),
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            title: Text('Cộng đồng'),
            icon: Icon(Icons.public),
          ),
          BottomNavigationBarItem(
            title: Text('Yêu thích'),
            icon: Icon(Icons.favorite),
          ),
          BottomNavigationBarItem(
            title: Text('Tài khoản'),
            icon: Icon(Icons.account_circle),
          ),
        ],
      ),
    );
  }
}
