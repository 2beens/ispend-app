import 'dart:convert';

class SpendKind {
  String id;
  String name;

  SpendKind({this.id, this.name});

  factory SpendKind.fromJsonMap(Map<String, dynamic> json) =>
      _fromJsonMap(json);
  factory SpendKind.fromJson(String json) => _fromJson(json);
}

SpendKind _fromJson(String jsonData) {
  return _fromJsonMap(json.decode(jsonData));
}

SpendKind _fromJsonMap(Map<String, dynamic> json) {
  return SpendKind(
    id: json['id'] as String,
    name: json['name'] as String,
  );
}
