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