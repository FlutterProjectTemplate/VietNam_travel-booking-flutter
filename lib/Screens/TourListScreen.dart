import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mobile/Screens/SearchScreen.dart';
import 'dart:math' as math;
import '../Utils/Constants.dart';
import 'package:carousel_pro/carousel_pro.dart';

class Trip {
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final double budget;
  final String travelType;
  final String imgUrl;
  Trip(this.title, this.startDate, this.endDate, this.budget, this.travelType,this.imgUrl);
}

class TourListScreen extends StatefulWidget {
  @override
  _TourListScreenState createState() => _TourListScreenState();
}

class _TourListScreenState extends State<TourListScreen> {
  final List<Trip> tripsList = [
    Trip("Kỳ Co-Eo Gió", DateTime.now(), DateTime.now(), 2000000, "car","images/01.jpg"),
    Trip("Đà Lạt-Nha Trang", DateTime.now(), DateTime.now(), 2900000, "car","images/02.jpg"),
    Trip("Vũng Tàu", DateTime.now(), DateTime.now(), 2000000, "car","images/3.png"),
    Trip("Đài Loan", DateTime.now(), DateTime.now(), 3000000, "plane","images/01.jpg"),
    Trip("Scranton", DateTime.now(), DateTime.now(), 4000000, "car","images/01.jpg"),
  ];


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
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(50, 255, 255, 255),
              borderRadius: BorderRadius.all(Radius.circular(22.0)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Địa điểm muốn khám phá",
                        hintStyle: TextStyle(color: Colors.white),
                        icon: Icon(Icons.search, color: Colors.white),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SearchScreen(),
                          ),
                        );
                      },
                    )),
                Expanded(
                    flex: 0,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.more_vert, color: Colors.white),
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                    ))
              ],
            )),
        backgroundColor: Colors.orange,
      ),
      body: Container(
          child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) => buildTripCard(context, index))),

    );
  }

  Widget buildTripCard(BuildContext context, int index) {
    final trip = tripsList[index];
    return new Container(
      child: Card(
        margin: const EdgeInsets.all(20.0),
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            children: <Widget>[
              Container(
                decoration: ShapeDecoration(
                    image: DecorationImage(
                        image: AssetImage("${trip.imgUrl}"), fit: BoxFit.fill,
                    ),
                    shape: RoundedRectangleBorder()),
                width: double.maxFinite,
                height: 200,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 4.0,left: 20.0),
                child: Row(children: <Widget>[
                  Text(
                    trip.title,
                    style: new TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 7.0, bottom: 5.0, left: 20.0),
                child: Row(children: <Widget>[
                  Icon(Icons.star, size: 15.0, color: Colors.orangeAccent,),
                  Text(
                    "5.0",
                    style: new TextStyle(fontSize: 15.0,color: Colors.orangeAccent ),

                  ),
                  Spacer(),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 10.0),
                child: Row(children: <Widget>[
                  Spacer(),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 20.0, left: 20.0, right: 20.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      "đ ${trip.budget.toStringAsFixed(0)}",
                      style: new TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.redAccent),
                    ),
                    Spacer(),
                    Icon(Icons.event_available, size: 15.0 ,color: Colors.green),
                    Text(
                      "Có thể đặt từ hôm nay",
                      style: new TextStyle(fontSize: 10.0,color: Colors.green),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
