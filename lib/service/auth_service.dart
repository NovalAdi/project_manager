import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../constants/api_config.dart';
import '../local/secure_strorage.dart';
import '../models/user.dart';

class AuthService {
  AuthService._();

  static Future<bool> register({
    required String username,
    required String email,
    required String password,
    required String role,
  }) async {
    try {
      const url = '${ApiConfig.baseUrl}/${ApiConfig.registerEndpoint}';
      final data = {
        'username': username,
        'email': email,
        'password': password,
        'role': role,
      };
      final response = await http.post(
        Uri.parse(url),
        body: data,
      );
      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body);
        final status = responseJson['status'];
        if (status == true) {
          final data = responseJson['data'];
          final token = data['token'];
          final user = User.fromJson(data);
          // ! Cache User dan token
          await SecureStorage.cacheToken(token: token);
          await SecureStorage.cacheUser(user: user);
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      log('$e');
      return false;
    }
  }

  static Future<bool> login({
    required String username,
    required String password,
  }) async {
    try {
      const url = '${ApiConfig.baseUrl}/${ApiConfig.loginEndpoint}';
      final data = {
        'username': username,
        'password': password,
      };
      final response = await http.post(
        Uri.parse(url),
        body: data,
      );
      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body);
        log("login: ${responseJson.toString()}");
        final status = responseJson['status'];
        if (status == true) {
          final data = responseJson['data'];
          log("data $data");
          final token = data['token'];
          final user = User.fromJson(data['user']);
          // ! Cache User dan token
          await SecureStorage.cacheToken(token: token);
          await SecureStorage.cacheUser(user: user);
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      log('$e');
      return false;
    }
  }

  static Future<bool> logout() async {
    try {
      const url = '${ApiConfig.baseUrl}/${ApiConfig.logoutEndpoint}';
      final token = await SecureStorage.getToken();
      log(token.toString());
      final headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
      final response = await http.get(Uri.parse(url), headers: headers);
      log(response.body);
      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body);
        log(responseJson.toString());
        final status = responseJson['status'];
        if (status == true) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      log('Error $e');
      return false;
    }
  }
}
