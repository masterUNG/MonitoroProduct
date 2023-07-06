import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String email;
  final String name;
  final String password;
  final String typeuser;
  final String uid;
  final GeoPoint? geoPoint;
  UserModel({
    required this.email,
    required this.name,
    required this.password,
    required this.typeuser,
    required this.uid,
     this.geoPoint,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'name': name,
      'password': password,
      'typeuser': typeuser,
      'uid': uid,
      'geoPoint': geoPoint,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: (map['email'] ?? '') as String,
      name: (map['name'] ?? '') as String,
      password: (map['password'] ?? '') as String,
      typeuser: (map['typeuser'] ?? '') as String,
      uid: (map['uid'] ?? '') as String,
      geoPoint: map['geoPoint']  ?? const GeoPoint(0, 0),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
