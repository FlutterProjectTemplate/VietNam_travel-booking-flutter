import 'dart:math';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Image.dart';
import 'Price.dart';
import 'Schedule.dart';
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
    List<dynamic> priceEntities = json['priceEntities'];
    List<PriceEntities> priceentities=priceEntities.map((p)=>PriceEntities.fromJson(p)).toList();
    List<dynamic> scheduleEntities = json['scheduleEntities'];
    List<ScheduleEntities> scheduleentities=scheduleEntities.map((p)=>ScheduleEntities.fromJson(p)).toList();
    List<dynamic> imageEntities = json['imageEntities'];
    List<ImageEntities> imageentities=imageEntities.map((p)=>ImageEntities.fromJson(p)).toList();
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
      priceEntities: priceentities,
      scheduleEntities: scheduleentities,
      imageEntities: imageentities,
    );
  }
}
