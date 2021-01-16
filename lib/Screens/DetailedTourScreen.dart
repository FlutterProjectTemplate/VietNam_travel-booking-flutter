import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/Models/Tour.dart';
import 'package:mobile/Netword/Api.dart';
import 'package:mobile/Screens/CommentScreen.dart';
import 'package:mobile/Screens/SearchScreen.dart';
import 'package:mobile/Screens/TourBookingScreen.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'PostScreen.dart';
import 'package:http/http.dart' as http;
Color mBackgroundColor = Color(0xFFFEFEFE);

Color mPrimaryColor = Color(0xFFf36f7c);

Color mSecondaryColor = Color(0xFFfff2f3);

class DetailedTourScreen extends StatefulWidget {
  final int tourId;

  DetailedTourScreen(@required this.tourId) ;
  @override
  _DetailedTourScreenState createState() => _DetailedTourScreenState();
}

class _DetailedTourScreenState extends State<DetailedTourScreen> {
  final double rating=5;
  final String product="images/04.jpg";

  Tour tour;
  Api _api=new Api();
  Future fetchTour(int id) async {
    http.Response response;
    response= await http.get('https://travelbooking4uit.herokuapp.com/api/public/tour/$id');
    if(response.statusCode==200){
      setState(() {
        tour=Tour.fromJson(jsonDecode(response.body));
      });
    }
  }
  @override
  void initState() {
    super.initState();
    fetchTour(widget.tourId);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyHeader(tour),
          PlaceAndName(tour),
          SizedBox(
            height: 36,
          ),
          About(tour),
          Attrabute(tour),
          BookNowButton(tour),
        ],
    ),
      ),
    );
  }
}


class About extends StatelessWidget {
  final Tour tour;

  const About(
    @required this.tour,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "About",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Oki Islands are located in the Sea of Japan (a shallow, basin-like sea)'
                'that has a large cold body of water, and the Tsushima Warm Current that '
                'flows through the sea. As a result, the marine biodiversity of Oki can be '
                'enjoyed through local food and also underwater. ',
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
            ),
          ),
          Text(
            'Read more',
            style: TextStyle(
                color: mPrimaryColor,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold
            ),

          )
        ],
      ),
    );
  }
}
class PlaceAndName extends StatelessWidget {
  final Tour tour;

  const PlaceAndName(
    @required this.tour,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 30,
        right: 30,
        top: 12,
        bottom: 24,
      ),
      decoration: BoxDecoration(
          color: mSecondaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(36),
            bottomRight: Radius.circular(36),
          )
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Oki Islands',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Sea of Japan',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Row(
            children: [
              WebsafeSvg.asset('images/star.svg'),
              Text('4.8')
            ],
          )
        ],
      ),
    );
  }
}
class Attrabute extends StatelessWidget {
  final Tour tour;

  const Attrabute(
    @required this.tour,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30,vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AttrabuteItem(
            iconUrl: 'images/mark.svg',
            isSelect: true,
          ),
          AttrabuteItem(
            iconUrl: 'images/compass.svg',
          ),
          AttrabuteItem(
            iconUrl: 'images/hotel.svg',
          ),
          AttrabuteItem(
            iconUrl: 'images/travel.svg',
          ),
          AttrabuteItem(
            iconUrl: 'images/share.svg',
          )
        ],
      ),
    );
  }
}
class AttrabuteItem extends StatelessWidget {
  final String iconUrl;
  final bool isSelect;
  final Tour tour;

  const AttrabuteItem({
    this.iconUrl,
    this.isSelect = false,
    @required this.tour,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isSelect ? mPrimaryColor : Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          isSelect
              ? BoxShadow()
              : BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Image.asset(
        iconUrl,
        color: isSelect ? Colors.white : mPrimaryColor,
      ),
    );
  }
}
class BookNowButton extends StatelessWidget {

  final Tour tour;

  const BookNowButton(
    @required this.tour,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30,vertical: 16),
      child: FlatButton(
        color: mPrimaryColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
        ),
        onPressed: () {Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => TourBookingScreen(tour.id),
          ),
        );},
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          alignment: Alignment.center,
          child: Text(
            'Đặt ngay',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),

          ),
        ),
      ),
    );
  }
}
class MyHeader extends StatelessWidget {
  final Tour tour;

  const MyHeader(

    @required this.tour,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400,
      child: Stack(
        children: [
          Image.network(
            tour.imageEntities[0].image,
            height: 400,
            fit: BoxFit.cover,
          ),
          Positioned(
            left: 30,
            top: 60,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: mBackgroundColor,
                    borderRadius: BorderRadius.circular(8)),
                child: Icon(
                  Icons.arrow_back_ios,
                ),
              ),
            ),
          ),
          Positioned(
            right: 16,
            bottom: 16,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: mSecondaryColor,
                  borderRadius: BorderRadius.circular(36)
              ),
              child: WebsafeSvg.asset('assets/icons/favorite.svg'),
            ),
          ),
        ],
      ),
    );
  }
}
