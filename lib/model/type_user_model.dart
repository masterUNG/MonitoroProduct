import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class TypeUserModel {
  final String typeuser;
  TypeUserModel({
    required this.typeuser,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'typeuser': typeuser,
    };
  }

  factory TypeUserModel.fromMap(Map<String, dynamic> map) {
    return TypeUserModel(
      typeuser: (map['typeuser'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TypeUserModel.fromJson(String source) => TypeUserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
