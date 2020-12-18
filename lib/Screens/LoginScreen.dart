import 'package:flutter/material.dart';
import 'package:mobile/Components/BezierContainer.dart';
import 'package:mobile/Components/CustomAppBar.dart';
import 'package:mobile/Screens/MainScreen.dart';
import 'package:mobile/Screens/SignUpScreen.dart';

import 'ForgotPasswordScreen.dart';

class LoginScreen extends StatefulWidget {
  final BuildContext previousContext;
  LoginScreen({this.previousContext});

  @override
  _LoginScreenState createState() => _LoginScreenState(this.previousContext);
}

class _LoginScreenState extends State<LoginScreen> {
  final BuildContext previousContext;

  _LoginScreenState(this.previousContext);

  Widget _submitButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pop(previousContext);
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainScreen()));
      },
      child: Container(
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
        child: Text(
          'Đăng nhập',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _forgotPasswordLabel() {
    return InkWell(
      onTap: () {

        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.centerRight,
        child: Text('Bạn quên mật khẩu ?',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      ),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
        onTap: () {
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => SignUpPage()));
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          padding: EdgeInsets.all(15),
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Bạn chưa có tài khoản ?',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpScreen()));
                },
                child: Text(
                  'Đăng ký',
                  style: TextStyle(
                      color: Color(0xfff79c4f),
                      fontSize: 13,
                      fontWeight: FontWeight.w600),
                ),
              ),

            ],
          ),
        ),

    );




  }

  Widget _entryField(String title, {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            title,
            style: TextStyle(color: Colors.grey, fontSize: 16.0),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.withOpacity(0.5),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(15.0),
          ),
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
          child: Row(
            children: <Widget>[
              new Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: Icon(
                  (isPassword ? Icons.security_outlined : Icons.person_outline),
                  color: Colors.grey,
                ),
              ),
              Container(
                height: 30.0,
                width: 1.0,
                color: Colors.grey.withOpacity(0.5),
                margin: const EdgeInsets.only(left: 00.0, right: 10.0),
              ),
              new Expanded(
                child: TextField(
                  obscureText: isPassword,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Nhập ${title}',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _widgetField() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _entryField("Email"),
          _entryField("Mật khẩu", isPassword: true),
        ],
      ),
    );
  }

  Widget _imageLogo() {
    return Image.asset('images/logo.png', height: 150, fit: BoxFit.fill);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(
        context,
        "Đăng nhập",
        true,
      ),
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
                top: -height * 15,
                right: -MediaQuery.of(context).size.width * 0.4,
                child: BezierContainer()),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 10),
                    _imageLogo(),
                    //_title(),
                    SizedBox(height: 10),
                    _widgetField(),
                    SizedBox(height: 20),
                    _submitButton(),
                    SizedBox(height: 10),
                    _forgotPasswordLabel(),
                    // _divider(),
                    //_facebookButton(),
                    SizedBox(height: height * .055),
                    _createAccountLabel(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
