
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