import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

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
      log('register $e');
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
      log(url);
      final token = await SecureStorage.getToken();
      log('${token}');
      final headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
      final response = await http.post(Uri.parse(url), headers: headers);
      log(response.body);
      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body);
        log(responseJson.toString());
        final status = responseJson['status'];
        if (status == true) {
          await SecureStorage.deleteDataLokal();
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

  static Future<void> getUser() async {
    try {
      final user = await SecureStorage.getUser();
      log('pppp $user');
      if (user != null) {
        final url = '${ApiConfig.baseUrl}/${ApiConfig.userEndpoint}/${user.id}';
        final token = await SecureStorage.getToken();
        final headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
        final response = await http.get(Uri.parse(url), headers: headers);
        if (response.statusCode == 200) {
          final responseJson = jsonDecode(response.body);
          final data = responseJson['data'];
          final userData = User.fromJson(data);
          final status = responseJson['status'];
          if (status == true) {
            log('PPP $userData');
            await SecureStorage.updateUser(userData);
          }
        }
      }
    } catch (e) {
      log('getUser $e');
    }
  }

  static Future<bool?> uploadImage(int id) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final file = await MultipartFile.fromFile(pickedFile.path);

      try {
        final dio = Dio();
        final token = await SecureStorage.getToken();
        final headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
        final response = await dio.post(
          '${ApiConfig.baseUrl}/${ApiConfig.userEndpoint}/$id',
          data: FormData.fromMap({
            'image': file,
          }),
          options: Options(
            headers: headers,
          ),
        );
        log(response.data.toString());
        return true;
      } catch (e, str) {
        log("upload image $e");
        debugPrintStack(stackTrace: str);
      }
    }
    return false;
  }

  static Future<bool> updateUser({
    required String username,
    required String email,
    required String id,
  }) async {
    try {
      final url = "${ApiConfig.baseUrl}/${ApiConfig.userEndpoint}/$id";
      log(url);
      final token = await SecureStorage.getToken();
      final headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
      final body = {
        'username': username,
        'email': email,
      };
      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      log(response.body);
      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body);
        final status = responseJson['status'];
        if (status == true) {
          return true;
        }
      }
    } catch (e) {
      log('updateUser $e');
    }
    return false;
  }
}
