import 'package:ispend_app/models/spendKind.dart';

class Spending {
  String id;
  String currency;
  double amount;
  SpendKind kind;

  Spending(String currency, double amount, String spendKindID) {
    this.currency = currency;
    this.amount = amount;
    this.kind = new SpendKind("");
    this.kind.id = spendKindID;
  }
}
