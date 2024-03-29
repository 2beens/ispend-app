import 'package:http/http.dart' as http;
import 'package:ispend_app/config.dart';
import 'package:ispend_app/models/spending.dart';
import 'package:ispend_app/network/apiResponse.dart';

class APIManager {
  static Future<String> sendRequest(String url, dynamic body) async {
    var response = await http.post(url, body: body);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    return response.body;
  }

  static Future<APIResponse> sendLogin(String username, String password) async {
    var url = Config.serverURL + '/users/login';
    if (username == "" && password == "") {
      username = "lazar";
      password = "lazar1";
    }
    var response = await http
        .post(url, body: {'username': username, 'password': password});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    return APIResponse.fromJson(response.body);
  }

  static Future<APIResponse> sendRegister(
      String email, String username, String password) async {
    var url = Config.serverURL + '/users';
    var response = await http.post(url,
        body: {'email': email, 'username': username, 'password': password});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    return APIResponse.fromJson(response.body);
  }

  static Future<APIResponse> sendNewSpending(
      String username, Spending spending) async {
    var url = Config.serverURL + '/spending';
    var response = await http.post(url, body: {
      'username': username,
      'currency': spending.currency,
      'amount': spending.amount.toString(),
      'kind_id': spending.kind.id,
    });
    print('Response status [sendNewSpending]: ${response.statusCode}');
    print('Response body [sendNewSpending]: ${response.body}');
    return APIResponse.fromJson(response.body);
  }

  static Future<GetDynamicAPIResponse> getSpends(String username) async {
    var url = Config.serverURL + '/spending/all/' + username;
    var response = await http.get(url);
    print('Response status [getSpends]: ${response.statusCode}');
    print('Response body [getSpends]: ${response.body}');
    return GetDynamicAPIResponse.fromJson(response.body);
  }

  static Future<GetDynamicAPIResponse> getSpendKinds(String username) async {
    var url = Config.serverURL + '/spending/kind/' + username;
    var response = await http.get(url);
    print('Response status [getSpendKinds]: ${response.statusCode}');
    print('Response body [getSpendKinds]: ${response.body}');
    return GetDynamicAPIResponse.fromJson(response.body);
  }
}
