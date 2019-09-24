import 'dart:convert';

import 'package:ispend_app/models/spendKind.dart';

class Spending {
  String id;
  String currency;
  double amount;
  SpendKind kind;
  // TODO: change to real date
  String timestamp;

  Spending({this.id, this.currency, this.amount, this.timestamp, this.kind});

  factory Spending.fromJsonMap(Map<String, dynamic> json) =>
      _fromJsonMap(json);
  factory Spending.fromJson(String json) => _fromJson(json);
}

Spending _fromJson(String jsonData) {
  return _fromJsonMap(json.decode(jsonData));
}

Spending _fromJsonMap(Map<String, dynamic> json) {
  return Spending(
    id: json['id'] as String,
    currency: json['currency'] as String,
    amount: json['amount'] as double,
    kind: json['kind'] as SpendKind,
    timestamp: json['timestamp'] as String,
  );
}
