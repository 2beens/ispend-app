import 'dart:convert';

import 'package:ispend_app/models/spending.dart';

// json serialization
// https://www.woolha.com/tutorials/flutter-dart-convert-deserialize-json-string-to-object

class APIResponse {
  int status;
  bool isError;
  String message;
  String data;

  APIResponse({this.status, this.isError, this.message, this.data});

  factory APIResponse.fromJsonMap(Map<String, dynamic> json) =>
      _responseFromJsonMap(json);
  factory APIResponse.fromJson(String json) => _responseFromJson(json);
}

APIResponse _responseFromJson(String jsonData) {
  return _responseFromJsonMap(json.decode(jsonData));
}

APIResponse _responseFromJsonMap(Map<String, dynamic> json) {
  return APIResponse(
    status: json['status'] as int,
    isError: json['is_error'] as bool,
    message: json['message'] as String,
    data: json['data'] as String,
  );
}

// ^^^^^^^^
// TODO: use inheritance instead of this code redundance
// vvvvvvvv

class GetSpendingsAPIResponse {
  int status;
  bool isError;
  String message;
  List<dynamic> data;

  GetSpendingsAPIResponse({this.status, this.isError, this.message, this.data});

  factory GetSpendingsAPIResponse.fromJsonMap(Map<String, dynamic> json) =>
      _spendingsResponseFromJsonMap(json);
  factory GetSpendingsAPIResponse.fromJson(String json) => _spendingsResponseFromJson(json);
}

GetSpendingsAPIResponse _spendingsResponseFromJson(String jsonData) {
  return _spendingsResponseFromJsonMap(json.decode(jsonData));
}

GetSpendingsAPIResponse _spendingsResponseFromJsonMap(Map<String, dynamic> json) {
  return GetSpendingsAPIResponse(
    status: json['status'] as int,
    isError: json['is_error'] as bool,
    message: json['message'] as String,
    data: json['data'] as List<dynamic>,
  );
}