import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile/Components/CustomAppBar.dart';
import 'package:mobile/Models/Tour.dart';
import 'package:mobile/Network/Api.dart';
import 'package:mobile/Screens/PaymentScreen.dart';
import 'package:http/http.dart' as http;
class TourBookingScreen extends StatefulWidget {
  final int tourId;

  TourBookingScreen(@required this.tourId) ;
  @override
  State<StatefulWidget> createState() => _TourBookingState();
}

class _TourBookingState extends State<TourBookingScreen> {
  int _adultPrice = 10000;
  int _childPrice = 1234324;
  int _babyPrice = 123123;
  int _totalNumberOfPeople = 10;
  int _totalPrice = 1012312312;
  List<Tour> Tours;

  Tour tour;
  Future fetchTour(int id) async {
    http.Response response;
    response= await http.get('https://travelbooking4uit.herokuapp.com/api/public/tour/$id');
    if(response.statusCode==200){
      setState(() {
        tour=Tour.fromJson(jsonDecode(response.body));
      });
    }
  }
  final oCcy = new NumberFormat("#,### đ", "en_US");
  @override
  void initState() {
    super.initState();
    fetchTour(widget.tourId);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context, "Đặt tour", true),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 10, left: 20, right: 20),
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(20),
        //   color: Colors.white,
        // ),

        child: Column(
          children: [
            _containerContact(),
            Divider(),
            _containerOder(),
            Divider(),
            _containerTotal(),
            SizedBox(
              height: 20,
            ),
            _submitButton(),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Widget _containerContact() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            "Thông tin liên hệ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          decoration: InputDecoration(
              labelText: "Họ tên",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)))),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)))),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          decoration: InputDecoration(
              labelText: "Địa chỉ",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)))),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
              labelText: "Số điện thoại",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)))),
        ),
      ],
    );
  }

  Widget _containerOder() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              "Thông tin đặt vé",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  "Người lớn",
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: "0",
                    counterText: "${oCcy.format(_adultPrice)}",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)))),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Flexible(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Trẻ em (hơn 1m3)",
                    ),
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: "0",
                        counterText: "${oCcy.format(_childPrice)}",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
                  ),
                ],
              )),
              SizedBox(
                width: 10,
              ),
              Flexible(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Trẻ em (dưới 1m3)",
                    ),
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: "0",
                        counterText: "${oCcy.format(_babyPrice)}",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
                  ),
                ],
              )),
            ],
          ),
        ]);
  }

  Widget _containerTotal() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: <Widget>[
            Flexible(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Tổng số người",
                  ),
                ),
                Container(
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                        hintText: "${_totalNumberOfPeople}",
                        suffixText: "người",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,
                    boxShadow: [],
                  ),
                  height: 50,
                ),
              ],
            )),
            SizedBox(
              width: 10,
            ),
            Flexible(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Tổng tiền",
                  ),
                ),
                Container(
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                        hintText: "${_totalPrice}",
                        suffixText: "đ",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,
                    boxShadow: [],
                  ),
                  height: 50,
                ),
              ],
            )),
          ],
        ),
      ],
    );
  }

  Widget _submitButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xfffbb448), Color(0xfff7892b)])),
      child: new GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (_) => PaymentScreen(),
          ),);
        },
        child: Text(
          'Đặt ngay',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
