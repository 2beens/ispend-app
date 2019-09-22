import 'package:http/http.dart' as http;
import 'package:ispend_app/config.dart';
import 'package:ispend_app/network/apiResponse.dart';

class NetworkManager {
  static Future<String> sendRequest(String url, dynamic body) async {
    var response = await http.post(url, body: body);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    return response.body;
  }

  static Future<APIResponse> sendLogin(String username, String password) async {
    var url = Config.serverURL + '/users/login';
    var response = await http
        .post(url, body: {'username': username, 'password': password});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    return APIResponse.fromJson(response.body);
  }

  static Future<APIResponse> sendRegister(String email, String username, String password) async {
    var url = Config.serverURL + '/users';
    var response = await http
        .post(url, body: {'email': email, 'username': username, 'password': password});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    return APIResponse.fromJson(response.body);
  }
}
