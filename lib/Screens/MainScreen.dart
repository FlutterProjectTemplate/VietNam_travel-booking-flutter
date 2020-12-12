import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/Screens/AccountScreen.dart';
import 'package:mobile/Screens/HomeScreen.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  int _selectedIndex = 0;
  int _lastSelectedIndex = -1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex != _lastSelectedIndex) {
        _navigatorKey.currentState.pushReplacementNamed("/${index}");
        _lastSelectedIndex = _selectedIndex;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        // key: _navigatorKey,
        // initialRoute: '/0',
        // onGenerateRoute: (RouteSettings settings) {
        //   WidgetBuilder builder;
        //
        //   // Manage your route names here
        //   switch (settings.name) {
        //     case '/0':
        //       builder = (BuildContext context) => HomeScreen();
        //       break;
        //     case '/1':
        //       builder = (BuildContext context) => AccountScreen();
        //       break;
        //     case '/2':
        //       builder = (BuildContext context) => HomeScreen();
        //       break;
        //     case '/3':
        //       builder = (BuildContext context) => AccountScreen();
        //       break;
        //     default:
        //       builder = (BuildContext context) => HomeScreen();
        //   }
        //   // _navigatorKey.currentState.pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
        //   // You can also return a PageRouteBuilder and
        //   // define custom transitions between pages
        //   return MaterialPageRoute(
        //     builder: builder,
        //     settings: settings,
        //   );
        // },
      ),
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
