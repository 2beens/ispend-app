import 'dart:convert';

class SpendKind {
  String id;
  String name;

  SpendKind({this.id, this.name});

  factory SpendKind.fromJsonMap(Map<String, dynamic> json) => fromJsonMap(json);
  factory SpendKind.fromJson(String json) => fromJson(json);
}

SpendKind fromJson(String jsonData) {
  return fromJsonMap(json.decode(jsonData));
}

SpendKind fromJsonMap(Map<String, dynamic> json) {
  return SpendKind(
    id: json['id'] as String,
    name: json['name'] as String,
  );
}
