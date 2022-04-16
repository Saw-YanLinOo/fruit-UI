import 'dart:convert';

class User {
  String name;
  String phone;
  String password;
  String hadLogin;

  User({required this.name,required this.phone,required this.password,required this.hadLogin});

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        phone = json['phone'],
        password = json['password'],
        hadLogin = json['hadLogin'];

  Map<String, dynamic> toJson() => {
    'name': name,
    'phone': phone,
    'password': password,
    'hadLogin': hadLogin,
  };
}