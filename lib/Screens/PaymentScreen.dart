import 'package:flutter/material.dart';
import 'package:mobile/Screens/CommunityScreen.dart';
import 'package:momo_vn/momo_vn.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  MomoVn _momoPay;
  PaymentResponse _momoPaymentResult;
  String _payment_status;
  @override
  void initState() {
    super.initState();
    _momoPay = MomoVn();
    _momoPay.on(MomoVn.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _momoPay.on(MomoVn.EVENT_PAYMENT_ERROR, _handlePaymentError);
    initPlatformState();
  }
  Future<void> initPlatformState() async {
    if (!mounted) return;
    setState(() {
    });
  }
  MomoPaymentInfo options = MomoPaymentInfo(
      merchantname: "Tên đối tác",
      merchantcode: 'Mã đối tác',
      appScheme: "1221212",
      amount: 6000000000,
      orderId: '12321312',
      orderLabel: 'Label để hiển thị Mã giao dịch',
      merchantnamelabel: "Tiêu đề tên cửa hàng",
      fee: 0,
      description: 'Mô tả chi tiết',
      username: 'Định danh user (id/email/...)',
      partner: 'merchant',
      extra: "{\"key1\":\"value1\",\"key2\":\"value2\"}",
      isTestMode: true
  );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('THANH TOÁN QUA ỨNG DỤNG MOMO'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              FlatButton(
                color: Colors.blue,
                textColor: Colors.white,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                padding: EdgeInsets.all(8.0),
                splashColor: Colors.blueAccent,
                child: Text('DEMO PAYMENT WITH MOMO.VN'),
                onPressed: () async {
                  MomoPaymentInfo options = MomoPaymentInfo(
                      merchantname: "merchantname",
                      appScheme: "momoxxxx",
                      merchantcode: 'MOMOxxx',
                      amount: 60000,
                      orderId: '12321312',
                      orderLabel: 'Gói dịch vụ ABCD',
                      merchantnamelabel: "TRUNG TÂM XYZ",
                      fee: 0,
                      description: 'Thanh toán công đoạn A',
                      username: '091xxxx',
                      partner: 'merchant',
                      extra: "{\"key1\":\"value1\",\"key2\":\"value2\"}",
                      isTestMode: true
                  );
                  try {
                    _momoPay.open(options);
                  } catch (e) {
                    debugPrint(e);
                  }
                },
              ),
              Text(_payment_status ?? "CHƯA THANH TOÁN")
            ],
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
    _momoPay.clear();
  }
  void _setState() {
    _payment_status = 'Đã chuyển thanh toán';
    if (_momoPaymentResult.isSuccess) {
      _payment_status += "\nTình trạng: Thành công.";
      _payment_status += "\nSố điện thoại: " + _momoPaymentResult.phonenumber;
      _payment_status += "\nExtra: " + _momoPaymentResult.extra;
      _payment_status += "\nToken: " + _momoPaymentResult.token;
    }
    else {
      _payment_status += "\nTình trạng: Thất bại.";
      _payment_status += "\nExtra: " + _momoPaymentResult.extra;
      _payment_status += "\nMã lỗi: " + _momoPaymentResult.status.toString();
    }
  }
  void _handlePaymentSuccess(PaymentResponse response) {
    setState(() {
      _momoPaymentResult = response;
      _setState();
    });
    Fluttertoast.showToast(msg: "THÀNH CÔNG: " + response.phonenumber, timeInSecForIosWeb: 4);
  }

  void _handlePaymentError(PaymentResponse response) {
    setState(() {
      _momoPaymentResult = response;
      _setState();
    });
    Fluttertoast.showToast(msg: "THẤT BẠI: " + response.message.toString(), timeInSecForIosWeb: 4);
  }
}


