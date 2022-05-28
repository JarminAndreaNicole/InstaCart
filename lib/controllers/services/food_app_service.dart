import 'dart:convert';
import 'package:http/http.dart' as http;


class FoodAppService {
  final String _url='https://instacarts.herokuapp.com';
  Future<http.Response> loginUser({ required String Email, required Password}) async {
    final http.Response response = await http.post(
      Uri.parse('$_url/login'),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Access-Control-Allow-Headers': 'Access-Control-Allow-Origin, Accept'},
      body: jsonEncode(<String, dynamic>{
        'email'   	: Email,
        'password' : Password,
      }),
    );
    return response;
  }

  Future<http.Response> signupPage({ required String Fullname, required Email, required Address, required Username,  required Password, }) async {
    final http.Response response = await http.post(
      Uri.parse('$_url/User'),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Access-Control-Allow-Headers': 'Access-Control-Allow-Origin, Accept'},
      body: jsonEncode(<String, dynamic>{
        'Fullname' : Fullname,
        'Email'   	: Email,
        'Address' : Address,
        'Username' : Username,
        'Password' : Password
      }),
    );
    return response;
  }
}