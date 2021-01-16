class LoginRequest{
  final String username;
  final String password;

  LoginRequest({this.username, this.password});

  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    return LoginRequest(
        username: json['username'],
        password: json['password']
    );
  }
  Map toJson(){
    return{
      "username":username,
      "password":password,
    };
  }
}