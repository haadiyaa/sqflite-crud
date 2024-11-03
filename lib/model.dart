import 'dart:convert';

class ModelClass {
  int? id;
  final String name;

  ModelClass({this.id,required this.name});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory ModelClass.fromMap(Map<String, dynamic> map) {
    return ModelClass(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelClass.fromJson(String source) => ModelClass.fromMap(json.decode(source) as Map<String, dynamic>);
}
