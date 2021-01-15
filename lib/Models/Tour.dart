import 'package:http/http.dart' as http;
import 'dart:convert';
class Tour {
  final int id;
  final String name;
  final String codeTour;
  final String startPlace;
  final String endPlace;
  final String province;
  final String national;
  final String startTime;
  final String endTime;
  final String time;
  final String status;
  final String description;
  final String avatarTour;
  final int discountPercent;
  final List<PriceEntities> priceEntities;
  final List<ScheduleEntities> scheduleEntities;
  final List<ImageEntities> imageEntities;


  Tour({this.id, this.name, this.codeTour,this.startPlace,this.endPlace,this.province,this.national,this.startTime,this.endTime,this.time,this.status,this.description,this.avatarTour,this.discountPercent,this.priceEntities,this.imageEntities,this.scheduleEntities});

  factory Tour.fromJson(Map<String, dynamic> json) {
    return Tour(
      id: json['id'],
      name: json['name'],
      codeTour: json['codeTour'],
      startPlace: json['startPlace'],
      endPlace: json['endPlace'],
      province: json['province'],
      national: json['national'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      time: json['time'],
      status: json['status'],
      description: json['description'],
      avatarTour: json['avatarTour'],
      discountPercent: json['discountPercent'],
      priceEntities: json['priceEntities'],
      scheduleEntities: json['scheduleEntities'],
      imageEntities: json['imageEntities'],
    );
  }
}
class PriceEntities{
  final int id;
  final String type;
  final String primary;
  final String price;
  PriceEntities({this.id,this.price,this.primary,this.type});
  factory PriceEntities.fromJson(Map<String,dynamic>json){
    return PriceEntities(
      id: json['id'],
      type: json['type'],
      primary: json['primary'],
      price: json['price']
    );
  }
}
class ImageEntities{
  final int id;
  final String image;

  ImageEntities({this.id,this.image});
  factory ImageEntities.fromJson(Map<String,dynamic>json){
    return ImageEntities(
        id: json['id'],
        image: json['image'],
    );
  }
}
class ScheduleEntities{
  final int id;
  final String time;
  final String place;

  ScheduleEntities({this.id,this.time,this.place});
  factory ScheduleEntities.fromJson(Map<String,dynamic>json){
    return ScheduleEntities(
      id: json['id'],
      time: json['time'],
      place: json['place']
    );
  }
}
Future<Tour> fetchTour() async {
  final response = await http.get('https://run.mocky.io/v3/0f605429-0dbe-4d41-893d-da08c1cb698f?fbclid=IwAR07fYzoYXwFe5NI_9Bl0oyfHIM2tPxxMoAPpqOiv7DezTFLc1jjDXO5ofg');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Tour.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load tour');
  }
}