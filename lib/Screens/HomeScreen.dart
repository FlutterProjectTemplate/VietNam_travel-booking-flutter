import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;
import '../Utils/Constants.dart';

import 'package:carousel_pro/carousel_pro.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController;
  int _page = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
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
                        hintText: "Địa điểm muốn khám phá",
                        hintStyle: TextStyle(color: Colors.white),
                        icon: Icon(Icons.search, color: Colors.white),
                      ),
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

      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 200,
                  child: ImageCarousel(),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment(-0.8, -0.5),
                  child: new Text("TOUR HOT",
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left),
                ),
                SizedBox(height: 8),
                Container(
                  height: 400,
                  child: Align(
                    child: SlidingCardsView(),
                    alignment: Alignment.center,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.orangeAccent,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SlidingCardsView extends StatefulWidget {
  @override
  _SlidingCardsViewState createState() => _SlidingCardsViewState();
}

class _SlidingCardsViewState extends State<SlidingCardsView> {
  PageController pageController;
  double pageOffset = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.8);
    pageController.addListener(() {
      setState(() => pageOffset = pageController.page);
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.55,
      child: PageView(
        controller: pageController,
        children: <Widget>[
          SlidingCard(
            name: 'Tràng An, Việt Nam',
            date: '4.20-30',
            assetName: '01.jpg',
            offset: pageOffset,
          ),
          SlidingCard(
            name: 'Đà Lạt, Việt Nam',
            date: '4.28-31',
            assetName: '02.jpg',
            offset: pageOffset - 1,
          ),
        ],
      ),
    );
  }
}

class SlidingCard extends StatelessWidget {
  final String name;
  final String date;
  final String assetName;
  final double offset;

  const SlidingCard({
    Key key,
    @required this.name,
    @required this.date,
    @required this.assetName,
    @required this.offset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double gauss = math.exp(-(math.pow((offset.abs() - 0.5), 2) / 0.08));
    return Transform.translate(
      offset: Offset(-32 * gauss * offset.sign, 15),
      child: Card(
        margin: EdgeInsets.only(left: 8, right: 8, bottom: 24),
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              child: Image.asset(
                'images/$assetName',
                height: MediaQuery.of(context).size.height * 0.3,
                alignment: Alignment(-offset.abs(), 0),
                fit: BoxFit.none,
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              child: CardContent(
                name: name,
                date: date,
                offset: gauss,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardContent extends StatelessWidget {
  final String name;
  final String date;
  final double offset;

  const CardContent(
      {Key key,
      @required this.name,
      @required this.date,
      @required this.offset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Transform.translate(
            offset: Offset(8 * offset, 0),
            child: Text(name, style: TextStyle(fontSize: 20)),
          ),
          SizedBox(height: 8),
          Transform.translate(
            offset: Offset(32 * offset, 0),
            child: Text(
              date,
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Spacer(),
          Row(
            children: <Widget>[
              Transform.translate(
                offset: Offset(48 * offset, 0),
                child: RaisedButton(
                  color: Color(0xFF162A49),
                  child: Transform.translate(
                    offset: Offset(24 * offset, 0),
                    child: Text('Đặt ngay'),
                  ),
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  onPressed: () {},
                ),
              ),
              Spacer(),
              Transform.translate(
                offset: Offset(32 * offset, 0),
                child: Text(
                  '0.00 \$',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(width: 16),
            ],
          )
        ],
      ),
    );
  }
}

class ImageCarousel extends StatefulWidget {
  _ImageCarouselState createState() => new _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = new Tween(begin: 0.0, end: 18.0).animate(controller)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    Widget carousel = new Carousel(
      boxFit: BoxFit.cover,
      images: [
        new AssetImage('images/01.jpg'),
        new AssetImage('images/3.png'),
      ],
      animationCurve: Curves.fastOutSlowIn,
      animationDuration: Duration(seconds: 1),
    );

    Widget banner = new Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 20.0),
      child: new Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              bottomRight: Radius.circular(15.0)),
          color: Colors.amber.withOpacity(0.5),
        ),
        padding: const EdgeInsets.all(10.0),
        child: new Text(
          'Banner on top of carousel',
          style: TextStyle(
            fontFamily: 'fira',
            fontSize: animation.value, //18.0,
            //color: Colors.white,
          ),
        ),
      ),
      // ),
      //  ),
    );

    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Center(
        child: new Container(
          padding: const EdgeInsets.all(20.0),
          height: screenHeight / 2,
          child: new ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: new Stack(
              children: [
                carousel,
                banner,
              ],
            ),
          ),
        ),
      ),
    );
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}
