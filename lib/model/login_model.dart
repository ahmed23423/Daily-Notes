import 'dart:io';

import 'package:dio/dio.dart';
import 'package:project_ahmed_ahmed/host%20api/host%20api.dart';

class LoginModel {
  static Future<Map<String, dynamic>?> theSignUp(
      {required String email,
      required String passowrd,
      required String firstName,
      required String lastName}) async {
    const String apiSignUp = HOST_API + 'signup';
    Response? response;
    try {
      response = await Dio().post(apiSignUp, data: {
        'email': email,
        'password': passowrd,
        'first_name': firstName,
        'second_name': lastName,
      }).catchError((e) async {
        throw e.message;
      });
    } catch (e) {
      print(e);
    }
    return response != null ? response.data : null;
  }

static Future<Map<String, dynamic>?> theSignIn(
      {required String email,
      required String passowrd,
      }) async {
    const String apiSignUp = HOST_API + 'signin';
    Response? response;
    try {
      response = await Dio().post(apiSignUp, data: {
        'email': email,
        'password': passowrd,
      }).catchError((e) async {
        throw e.message;
      });
    } catch (e) {
      print(e);
    }
    return response != null ? response.data : null;
  }
}
