import 'dart:convert';

// json serialization
// https://www.woolha.com/tutorials/flutter-dart-convert-deserialize-json-string-to-object

class APIResponse {
  int status;
  bool isError;
  String message;
  dynamic data;

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
    data: json['data'] as dynamic,
  );
}
