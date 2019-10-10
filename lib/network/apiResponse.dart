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
    isError: json['isError'] as bool,
    message: json['message'] as String,
    data: json['data'] as String,
  );
}

// ^^^^^^^^
// TODO: use inheritance instead of this code redundance
// vvvvvvvv

class GetDynamicAPIResponse {
  int status;
  bool isError;
  String message;
  List<dynamic> data;

  GetDynamicAPIResponse({this.status, this.isError, this.message, this.data});

  factory GetDynamicAPIResponse.fromJsonMap(Map<String, dynamic> json) =>
      _spendingsResponseFromJsonMap(json);
  factory GetDynamicAPIResponse.fromJson(String json) => _spendingsResponseFromJson(json);
}

GetDynamicAPIResponse _spendingsResponseFromJson(String jsonData) {
  return _spendingsResponseFromJsonMap(json.decode(jsonData));
}

GetDynamicAPIResponse _spendingsResponseFromJsonMap(Map<String, dynamic> json) {
  return GetDynamicAPIResponse(
    status: json['status'] as int,
    isError: json['isError'] as bool,
    message: json['message'] as String,
    data: json['data'] as List<dynamic>,
  );
}