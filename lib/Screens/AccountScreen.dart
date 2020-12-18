import 'package:flutter/material.dart';
import 'package:mobile/Components/CustomAppBar.dart';
import 'package:mobile/Screens/AboutScreen.dart';
import 'package:mobile/Screens/LoginScreen.dart';
import 'package:mobile/Utils/Constants.dart';

class AccountScreen extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          //     color: Constants.appBarBackground,
          decoration: BoxDecoration(
              //  borderRadius: BorderRadius.all(Radius.circular(25)),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Color.fromARGB(255, 51, 153, 255)),
                        image: DecorationImage(
                            image: AssetImage("images/user.png"),
                            fit: BoxFit.fill),
                      ),
                    ),
                    // Image.asset('images/user.png',
                    //   height: 100, fit: BoxFit.fitHeight,),
                    SizedBox(
                      height: 10,
                    ),
                    _loginButton()
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: <Widget>[],
                ),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 220, right: 5, left: 5,bottom: 5),
          padding: EdgeInsets.only(top: 20, left: 15, right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Icon(
                    Icons.notifications,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Thông báo",
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.black,
                        fontSize: 16.0),
                  ),
                ],
              ),
              Divider(),
              Row(
                children: [
                  Icon(Icons.history),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Lịch sử đặt tour",
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.black,
                        fontSize: 16.0),
                  ),
                ],
              ),
              Divider(),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => CustomDialog(
                    ),
                  );
                },
                child: Row(
                  children: [
                    Icon(Icons.phone),
                    SizedBox(
                      width: 15,
                    ),

                    Text(
                      "Trung tâm hỗ trợ (24/7)",
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.black,
                          fontSize: 16.0),
                    ),
                  ],
                ),
              ),

              Divider(),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => (AboutScreen())));
                },
                child: Row(
                  children: [
                    Icon(Icons.info),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Về Travel",
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.black,
                          fontSize: 16.0),
                    ),
                  ],
                ),
              ),

              Divider(),
            ],
          ),
        ),
      ],
    );
  }
  Widget _loginButton() {
    return GestureDetector(

      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen(previousContext: context,)));
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 4,
        padding: EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color.fromARGB(255, 51, 153, 255),
                  Color.fromARGB(255, 85, 172, 238)
                ])),
        child: Text(
          'Đăng nhập',
          style: TextStyle(
              decoration: TextDecoration.none,
              fontSize: 12,
              color: Colors.white),
        ),
      ),
    );
  }
}

class CustomDialog extends StatelessWidget {

  CustomDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    double a = 10;
    double b = 25;
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: 35,
            bottom: a,
            left: a,
            right: a,
          ),
          margin: EdgeInsets.only(top: 50),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(a),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Text(
                "",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "011231321321",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              Divider(),
              Align(
                alignment: Alignment.center,
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // To close the dialog
                  },
                  child: Text("Gọi"),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 10,
          right: 10,
          child: CircleAvatar(
            backgroundColor: Colors.blueAccent,
            radius: 40,
            child: Icon(
              Icons.call,
              // size: 50,
            ),
          ),
        ),
      ],
    );
  }
}
