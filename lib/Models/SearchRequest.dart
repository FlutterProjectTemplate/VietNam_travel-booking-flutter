class SearchRequest{
  final String endPlace;
  final String endTime;
  final String name;
  final String national;
  final String province;
  final String startPlace;
  final String startTime;
  final String time;
  SearchRequest({this.endPlace, this.endTime,this.name,this.national,this.province,this.startPlace,this.startTime,this.time});

  factory SearchRequest.fromJson(Map<String, dynamic> json) {
    return SearchRequest(
        endPlace: json['endPlace'],
        endTime: json['endTime'],
      name: json['name'],
      national: json['national'],
      province: json['province'],
      startPlace: json['startPlace'],
      startTime: json['startTime'],
      time: json['time'],
    );
  }
  Map toJson(){
    return{
      "endPlace":endPlace,
      "endTime":endTime,
      "name":name,
      "national":national,
      "province":province,
      "startPlace":startPlace,
      "startTime":startTime,
      "time":time,
    };
  }
}