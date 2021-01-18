class User {
  final int id;
  final String name;
  final String password;
  final String phone;
  final String username;

  User({this.id, this.name, this.password, this.phone, this.username});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      password: json['password'],
      phone: json['phone'],
      username: json['username'],
    );
  }

  Map toJson() {
    return {
      "id": id,
      "name": name,
      "password": password,
      "phone": phone,
      "username": username,
    };
  }
}
