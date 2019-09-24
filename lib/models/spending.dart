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

  factory Spending.fromJsonMap(Map<String, dynamic> jsonMap) =>
      fromJsonMap(jsonMap);
  factory Spending.fromJson(String jsonString) => fromJson(jsonString);
}

Spending fromJson(String jsonData) {
  return fromJsonMap(json.decode(jsonData));
}

Spending fromJsonMap(Map<String, dynamic> jsonMap) {
  int amount = jsonMap['amount'] as int;
  return Spending(
    id: jsonMap['id'] as String,
    currency: jsonMap['currency'] as String,
    amount: amount.toDouble(),
    kind: SpendKind.fromJsonMap(jsonMap['kind']),
    timestamp: jsonMap['timestamp'] as String,
  );
}
