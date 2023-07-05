import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String email;
  final String name;
  final String password;
  final String typeuser;
  final String uid;
  UserModel({
    required this.email,
    required this.name,
    required this.password,
    required this.typeuser,
    required this.uid,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'name': name,
      'password': password,
      'typeuser': typeuser,
      'uid': uid,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: (map['email'] ?? '') as String,
      name: (map['name'] ?? '') as String,
      password: (map['password'] ?? '') as String,
      typeuser: (map['typeuser'] ?? '') as String,
      uid: (map['uid'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
