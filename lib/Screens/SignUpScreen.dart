import 'package:flutter/material.dart';
import 'package:mobile/Components/BezierContainer.dart';
import 'package:mobile/Components/CustomAppBar.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen();

  @override
  State<StatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  Widget _entryField(String title,
      {bool isPassword = false,
      bool isMail = false,
      bool isRePassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            (isRePassword ? 'Nhập lại ${title}' : title),
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
                  (isPassword||isRePassword?Icons.security_outlined:isMail?Icons.mail_outline:Icons.person_outline),
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
                  keyboardType:
                      TextInputType.text,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText:
                        (isRePassword ? 'Nhập lại ${title}' : 'Nhập ${title}'),
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
          _entryField("Họ tên"),
          _entryField("Email", isMail: true),
          _entryField("Mật khẩu", isPassword: true),
          _entryField("Mật khẩu", isPassword: true, isRePassword: true),
        ],
      ),
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
      child: Text(
        'Đăng Ký',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }
  Widget _imageLogo() {
    return  Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
            image: AssetImage("images/user.png"),
            fit: BoxFit.fill),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(
        context,
        "Đăng ký",
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
                    SizedBox(height: 10),
                    _widgetField(),
                    SizedBox(height: 10),
                    _submitButton(),
                    SizedBox(height: 20),
                    //          _submitButton(),
                    SizedBox(height: 10),
                    //             _forgotPasswordLabel(),
                    // _divider(),
                    //_facebookButton(),
                    SizedBox(height: height * .055),
                    //            _createAccountLabel(),
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
