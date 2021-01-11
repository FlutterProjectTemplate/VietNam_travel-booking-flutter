import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  PageController _pageController;
  int _page = 0;
  List navs = ["Trang chủ", "Cộng đồng", "Yêu thích"];
  int _selectedIndex = 0;
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Anime App",
      theme: ThemeData(fontFamily: "Open Sans"),
      debugShowCheckedModeBanner: false,
      home: AddPost(),
    );
  }
}

class AddPost extends StatelessWidget {
  const AddPost({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Stack(children: <Widget>[
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
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(icon: Icon(Icons.close), onPressed: () {}),
                  Text(
                    "ĐĂNG BÀI",
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
                            child:  TextField(
                              decoration: InputDecoration(
                                  hintText: "Hãy viết gì đó",
                                  fillColor: Colors.white,
                                  filled: true,
                                  suffixIcon: Icon(Icons.filter_list),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: BorderSide(color: Colors.transparent),
                                  ),
                                  contentPadding:
                                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0)),
                            )
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child:  TextField(
                              decoration: InputDecoration(
                                  hintText: "Thêm caption",
                                  fillColor: Colors.white,
                                  filled: true,
                                  suffixIcon: Icon(Icons.more_horiz),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: BorderSide(color: Colors.transparent),
                                  ),
                                  contentPadding:
                                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0)),
                            )
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: NetworkImage(
                          "https://reviews-top5.com/wp-content/uploads/2020/10/bai-bien-dep.jpg"),
                      fit: BoxFit.cover,
                    )),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ]),
    );
  }
}
