import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mobile/Models/Image.dart';
import 'package:mobile/Models/Post.dart';
import 'package:mobile/Models/PostRequest.dart';
import 'package:mobile/Network/Api.dart';
import 'package:mobile/Screens/CommunityScreen.dart';
import 'package:mobile/Screens/MainScreen.dart';
import 'package:mobile/globals.dart' as globals;
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:progress_dialog/progress_dialog.dart';

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  PageController _pageController;
  int _page = 0;
  List navs = ["Trang chủ", "Cộng đồng", "Yêu thích"];
  int _selectedIndex = 0;
  File _image;
  String requestBody ;
  List<ImageEntities> images;

  final picker = ImagePicker();
  void getImage() async {
    var pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
  final _contentController = TextEditingController();
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
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
  List<Post> posts;
  void load() {
    setState(() {
    });
  }
  ProgressDialog _progressDialog;
  @override
  void initState() {
    super.initState();
    Api.getPosts().then((value) {
      setState(() {
        posts = value;

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _progressDialog = new ProgressDialog(context);
    _progressDialog.style(
        message: 'Vui lòng chờ...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));
    return MaterialApp(
        title: "Anime App",
        theme: ThemeData(fontFamily: "Open Sans"),
        debugShowCheckedModeBanner: false,
        home: AddPost(context));
  }

  Widget AddPost(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Stack(children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Color(0xffd2fbd2),
                Color(0xff),
              ],
              begin: Alignment.topCenter,
            )),
          ),
          SafeArea(
            child: Column(children: <Widget>[
              Container(
                color: Colors.orangeAccent,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CommunityScreen(),
                              ),
                            );
                          }),
                      Text(
                        "Đăng bài",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("images/04.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.6,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: TextField(
                                  controller: _contentController,
                                  decoration: InputDecoration(
                                      hintText: "Hãy viết gì đó",
                                      fillColor: Colors.white,
                                      filled: true,
                                      suffixIcon: Icon(Icons.filter_list),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 16.0)),
                                )),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: IconButton(
                                icon: Icon(Icons.send),
                                highlightColor: Colors.grey,
                                onPressed: () {
                                  post();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.symmetric(horizontal: 16.0),
                    child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        decoration: BoxDecoration(
                          color: Colors.orangeAccent.shade100,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Column(
                          children: [
                            Center(
                              child: _image == null
                                  ? Text('Chọn Ảnh')
                                  : Image.file(_image),
                            ),
                            _image != null
                                ? Text('')
                                : FloatingActionButton(
                                    onPressed: getImage,
                                    tooltip: 'Pick Image',
                                    child: Icon(Icons.add_a_photo),
                                  )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ]),
      ),
    );
  }
  void post() {
    _progressDialog.show();
    final String requestBody = json.encoder.convert(images);

    var now = new DateTime.now();
    var dateFormatted = DateFormat("yyyy-MM-ddTHH:mm:ss").format(now);
    print(dateFormatted);

    PostRequest postRequest =
    new PostRequest(content: _contentController.text.trim(), time: dateFormatted,imageEntities: null);
    Api.post(postRequest).then((value) {
      _progressDialog.hide();
      // Fluttertoast.showToast(msg: value.name);
      globals.isCommunity=true;
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainScreen()));
    }, onError: (e) {
      _progressDialog.hide();
      showDialog(
        context: context,
        builder: (BuildContext context) => AdvanceCustomAlert(message: e.toString().substring(11)),
      );
      //   dialogContent(context, e.toString().substring(11));
    });
  }
}
class AdvanceCustomAlert extends StatelessWidget {
  final String message;

  const AdvanceCustomAlert({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0)
        ),
        child: Stack(
          overflow: Overflow.visible,
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                child: Column(
                  children: [
                    Text('Lỗi', style: TextStyle(fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.red),),
                    SizedBox(height: 5,),
                    Text(
                      message,
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 20,),
                    RaisedButton(onPressed: () {
                      Navigator.of(context).pop();
                    },
                      color: Color(0xfff7892b),
                      child: Text(
                        'Okay', style: TextStyle(color: Colors.white),),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
                top: -60,
                child: CircleAvatar(
                  backgroundColor: Colors.redAccent,
                  radius: 60,
                  child: Icon(
                    Icons.assistant_photo, color: Colors.white, size: 50,),
                )
            ),
          ],
        )
    );
  }
}

