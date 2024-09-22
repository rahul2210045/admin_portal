import 'dart:convert';

import 'package:http/http.dart' as http;

class LoginApi {
  final String baseUrl = "https://cine-admin-xar9.onrender.com/admin/login"; 

  Future<bool> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Accept": "application/json",
        },
        body: jsonEncode(<String, String>{
          'adminid': username,
          'password': password,
        }),
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {

        // dynamic setCookieHeader = response.headers['Set-Cookie'];

        // List<String>? cookies;
        // // print(response.Cookies);
        // print('Response headers: ${response.headers}');
        // print('Cookies from response: ${response.headers['Set-Cookie']}');

        // if (setCookieHeader is String) {
        //   cookies = [setCookieHeader];
        // } else if (setCookieHeader is List<String>) {
        //   cookies = setCookieHeader;
        // } else {
        //   cookies = [];
        // }

        // print('Response Headers: $setCookieHeader');

        // String accessToken = '';
        // // String

        // if (cookies.isNotEmpty) {
        //   accessToken = cookies
        //       .map((cookie) => cookie.split(';').first)
        //       .firstWhere((value) => value.startsWith('accessToken='),
        //           orElse: () => '');
        // }
        // String actualAccessToken = accessToken.substring("accesstoken=".length);

        // print('Access Token from Cookie: $actualAccessToken');
        // PreferencesManager().token = actualAccessToken;

        // if (actualAccessToken.isNotEmpty) {
        //   // prefs.setString('token', actualAccessToken);
        //   print('Token stored in prefs: $actualAccessToken');
        // } else {
        //   // Handle the case where the token is empty
        //   print('Token is empty');
        // }

        return true; 
      } else {
        return false;
      }
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }
}
