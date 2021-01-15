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