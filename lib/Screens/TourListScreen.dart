import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;
import '../Utils/Constants.dart';

import 'package:carousel_pro/carousel_pro.dart';


class TourListScreen extends StatefulWidget {
  @override
  _TourListScreenState createState() => _TourListScreenState();
}

class _TourListScreenState extends State<TourListScreen> {
  PageController _pageController;
  int _page = 0;
  List navs = ["Trang chủ", "Cộng đồng", "Yêu thích"];
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  static List getDummyList() {
    List list = List.generate(10, (i) {
      return "Item ${i + 1}";
    });
    return list;
  }
  @override
  Widget build(BuildContext context) {
    List items = getDummyList();
    return Scaffold(
      appBar: AppBar(
        title: Container(
            margin:EdgeInsets.symmetric(horizontal: 10.0, vertical:  8.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(50, 255, 255, 255),
              borderRadius: BorderRadius.all(Radius.circular(22.0)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                    flex:1,

                    child: TextFormField(
                      decoration: InputDecoration(
                        border:InputBorder.none,
                        hintText: "Địa điểm muốn khám phá",
                        hintStyle:TextStyle(color: Colors.white),
                        icon: Icon(Icons.search, color: Colors.white),
                      ),
                    )
                ),
                Expanded(
                    flex:0,
                    child: IconButton(
                      onPressed: (){},
                      icon:Icon(Icons.more_vert,color: Colors.white),
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                    )
                )
              ],
            )
        ),
        backgroundColor:Colors.orange,

      ),

      body:  Container(
          child: ListView.builder(

          itemCount: items.length,
            itemBuilder: (context, index) {
              return Dismissible(
              key: Key(items[index]),
                    background: Container(
                      alignment: AlignmentDirectional.centerEnd,
                      color: Colors.red,
                        child: Icon(
                                Icons.delete,
                                color: Colors.white,
                        ),
                    ),
                      onDismissed: (direction) {
                      setState(() {
                      items.removeAt(index);
                    });
                },
                    direction: DismissDirection.endToStart,
                    child: Container(
                      decoration: ShapeDecoration(
                          image: DecorationImage(
                              image: AssetImage("images/landscape1.jpeg"),
                              fit: BoxFit.fitWidth),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusDirectional.circular(20))),
                      width: double.maxFinite,
                      height: 300,
                      child: Align(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                      ),
                      alignment: Alignment.bottomCenter,
                    ),
              )

        );
      },
          )),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}



