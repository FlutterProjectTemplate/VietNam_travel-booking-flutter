class OrderDetail {
  int amount;
  int price;

  OrderDetail({this.amount, this.price});

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      amount: json['amount'],
      price: json['price'],
    );
  }

  Map toJson() {
    return {
      "amount": amount,
      "price": price,
    };
  }
}

class Contact {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String idCardNumber;
  final int idTour;
  final int idUser;
  final List<OrderDetail> orderDetailRequests;

  Contact(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.idTour,
      this.idUser,
      this.idCardNumber,
      this.orderDetailRequests});

  Map toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "phone": phone,
      "idTour": idTour,
      "idUser": idUser,
      "idCardNumber": idCardNumber,
      "orderDetailRequests": orderDetailRequests,
    };
  }

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      idCardNumber: json['idCardNumber'],
      idTour: json['idTour'],
      idUser: json['idUser'],
      orderDetailRequests: json['orderDetailRequests'],
    );
  }
}

class OrderResponse {
  final int id;
  final int total_price;
  final String tourName;
  final int amount;
  final int price;
  final String urlImage;
  final Contact contact;
  final String orderDate;
  OrderResponse(
      {this.id,this.orderDate,
        this.total_price,
      this.tourName,
      this.amount,
      this.price,
      this.urlImage,
      this.contact});

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
        id: json['id'],
        total_price: json['total_price'],
        tourName: json['tourName'],
        amount: json['amount'],
        price: json['price'],
        urlImage: json['urlImage'],
        orderDate: json['orderDate'],
        contact: json['contact']);

  }

  Map toJson() {
    return {
      "id": id,
      "total_price": total_price,
      "tourName": tourName,
      "amount": amount,
      "price": price,
      "urlImage": urlImage,
      "contact": contact,
    };
  }
}
