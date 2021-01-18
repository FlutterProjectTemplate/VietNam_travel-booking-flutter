import 'Image.dart';

class PostRequest{
  final String content;
  final String time;
  final List<ImageEntities> imageEntities;

  PostRequest({this.content, this.imageEntities,this.time});

  factory PostRequest.fromJson(Map<String, dynamic> json) {
    return PostRequest(
      content: json['content'],
      time: json['time'],
      imageEntities: json['imageEntities'],
    );
  }
  Map toJson(){
    return{
      "content":content,
      "imageEntities":imageEntities,
      "time":time,
    };
  }
}