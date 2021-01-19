import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mobile/Components/CustomAppBar.dart';
import 'package:mobile/Models/Price.dart';
import 'package:mobile/Models/Tour.dart';
import 'package:mobile/Network/Api.dart';
import 'package:mobile/Screens/PaymentScreen.dart';
import 'package:http/http.dart' as http;

class TourBookingScreen extends StatefulWidget {
  final Tour tour;

  TourBookingScreen(@required this.tour);

  @override
  State<StatefulWidget> createState() => _TourBookingState(tour);
}

class _TourBookingState extends State<TourBookingScreen> {
  final Tour tour;
  List<int> listOrder = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  List<int> listPrice = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  int _totalNumberOfPeople = 0;
  int _totalPrice = 0;
  String _name;
  String _email;
  String _address;
  String _phone;
  _TourBookingState(this.tour);

  @override
  void dispose() {
    super.dispose();
  }

  changeText(index, text) {
    setState(() {
      listOrder[index] = int.parse(text);
    });
  }

  final oCcy = new NumberFormat("#,### đ", "en_US");

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < tour.priceEntities.length; i++) {
      listPrice[i] = tour.priceEntities[i].price;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context, "Đặt tour", true),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 10, left: 20, right: 20),
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
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: tour.priceEntities.length,
              itemBuilder: (BuildContext context, int index) => _field(index)
              // Text(index.toString()),
              ),
        ]);
  }

  Widget _field(index) {
    PriceEntities priceEntities = tour.priceEntities[index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            priceEntities.type,
          ),
        ),
        TextField(
          onChanged: (text) {
            if (text != "")
              listOrder[index] = int.parse(text);
            else
              listOrder[index] = 0;
            _setSumPrice();
            // Fluttertoast.showToast(msg: listOrder[index].toString()+"  null");
          },
          //      controller: adultController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              hintText: "0",
              counterText:
                  "${oCcy.format(priceEntities == null ? 0 : priceEntities.price)}",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)))),
        ),
      ],
    );
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
                        hintText: "${oCcy.format(_totalPrice)}",
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PaymentScreen(),
            ),
          );
        },
        child: Text(
          'Đặt ngay',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  void _setSumPrice() {
    setState(() {
      int t = 0;
      _totalNumberOfPeople =
          listOrder.reduce((value, element) => value + element);
      for (int i = 0; i < listPrice.length; i++) {
        t += (listPrice[i] * listOrder[i]);
      }
      _totalPrice = t;
    });
  }
}
