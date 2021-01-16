class LoginResponse{
  final int id;
  final String name;
  final String username;
  final String phone;
  final String token;

  LoginResponse({this.id, this.name, this.username, this.phone, this.token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      phone: json['phone'],
      token: json['token'],
    );
  }
}