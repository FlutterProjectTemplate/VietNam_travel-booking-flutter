import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile/Components/CustomAppBar.dart';
import 'package:mobile/Network/Api.dart';
import 'package:mobile/globals.dart' as globals;

class HistoryScreen extends StatefulWidget {


  HistoryScreen();

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    globals.futureOrder = Api.getOrder().then((value) {
      setState(() {
        globals.orders = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!globals.isLoggedIn)
      return Center(
        child: Text("Vui lòng đăng nhập để sử dụng chức năng này"),
      );
    else
      return Scaffold(
          appBar: CustomAppBar(context, "Lịch sử đặt tour", false),
          body: Container(
            child:
            globals.orders != null ?
            ListView.builder(
                itemCount: globals.orders.length,
                itemBuilder: (context, index) => buildTripCard(context, index))
                : Center(child: CircularProgressIndicator()),
          )
      );
  }

  Widget buildTripCard(BuildContext context, int index) {
    final oCcy = new NumberFormat("#,### đ", "en_US");
    return new Container(
      child: Card(
        child: InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              children: <Widget>[
                Container(
                  decoration: ShapeDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            globals.orders[index].urlImage == null ||
                                globals.orders[index].urlImage == ""
                                ? 'Loading...'
                                : globals.orders[index].urlImage),
                        fit: BoxFit.fill,
                      ),
                      shape: RoundedRectangleBorder()),
                  width: double.maxFinite,
                  height: 200,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 4.0, left: 20.0),
                  child: Row(children: <Widget>[
                    Text(
                      globals.orders[index] == null ? 'Loading...' : globals
                          .orders[index].tourName,
                      style: new TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 0, bottom: 0, left: 20.0, right: 20.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        globals.orders[index].orderDate != null
                            ? "Ngày đặt: ${globals.orders[index].orderDate
                            .substring(0, 10)}"
                            :""

                        ,
                        style: new TextStyle(fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 0, bottom: 0, left: 20.0, right: 20.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        globals.orders[index].date != null
                            ? "Ngày khởi hành: ${globals.orders[index].date
                            .substring(0, 10)}"
                            :""
                        ,
                        style: new TextStyle(fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Spacer(),
                      Text(
                        globals.orders[index].place != null
                            ? "Nơi khởi hành: ${globals.orders[index].place
                            .substring(0, 10)}"
                            :""
                        ,
                        style: new TextStyle(fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 10.0),
                  child: Row(children: <Widget>[
                    Spacer(),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 4.0, bottom: 20.0, left: 20.0, right: 20.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Số vé: ${globals.orders[index].amount}",
                        style: new TextStyle(fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent),
                      ),
                      Spacer(),
                    ],
                  ),
                )
                , Padding(
                  padding: const EdgeInsets.only(
                      top: 4.0, bottom: 20.0, left: 20.0, right: 20.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Tổng tiền: ${oCcy.format(globals.orders[index] == null
                            ? 'Loading...'
                            : globals.orders[index].total_price)}",
                        style: new TextStyle(fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent),
                      ),
                      Spacer(),
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
