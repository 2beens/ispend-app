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
  int id = json['id'] as int;
  return SpendKind(
    id: id.toString(),
    name: json['name'] as String,
  );
}
