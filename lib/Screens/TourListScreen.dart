import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mobile/Models/Tour.dart';
import 'package:mobile/Netword/Api.dart';
import 'package:mobile/Screens/DetailedTourScreen.dart';
import 'package:mobile/Screens/SearchScreen.dart';
import 'dart:math' as math;
import '../Utils/Constants.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:http/http.dart' as http;
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

  List<Tour> Tours;

  Tour tour;
  Api _api=new Api();
  Future fetchTours() async {
    http.Response response;
    response= await http.get('https://travelbooking4uit.herokuapp.com/api/public/tour/');
    if(response.statusCode==200){
      setState(() {
        Tours=(json.decode(response.body) as List).map((p)=>Tour.fromJson(p)).toList();
      });
    }
  }
  @override
  void initState() {
    super.initState();
    fetchTours();

  }

  static List getDummyList(int length) {
    List list = List.generate(length, (i) {
      return "Item ${i + 1}";
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    List items = getDummyList(Tours.length);
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
                        hintText: Tours[0].name,
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
    final Tour tour = Tours[index];
    return new Container(
      child: Card(
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DetailedTourScreen(Tours[index].id),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              children: <Widget>[
                Container(
                  decoration: ShapeDecoration(
                      image: DecorationImage(
                        image: NetworkImage(tour.imageEntities[0].image), fit: BoxFit.fill,
                      ),
                      shape: RoundedRectangleBorder()),
                  width: double.maxFinite,
                  height: 200,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 4.0,left: 20.0),
                  child: Row(children: <Widget>[
                    Text(
                      tour.name,
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
                        "đ ${tour.priceEntities[0].price}",
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
        margin: const EdgeInsets.all(20.0),

      ),
    );
  }
}
