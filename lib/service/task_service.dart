import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:project_manager/constants/api_config.dart';
import 'package:project_manager/local/secure_strorage.dart';
import 'package:project_manager/models/task.dart';

class TaskService {
  TaskService._();

  static Future<List<Task>?> getTask({
    required String idProject,
    required String idUser,
  }) async {
    try {
      final url = "${ApiConfig.baseUrl}/${ApiConfig.taskProjectEndpoint}/$idProject/user/$idUser";
      final token = await SecureStorage.getToken();
      final header = {'Authorization': 'Bearer $token'};
      final response = await http.get(Uri.parse(url), headers: header);
      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body);
        final status = responseJson['status'];
        if (status == true) {
          final List listDataTask = responseJson['data'];
          List<Task> listTask = [];
          for (final json in listDataTask) {
            listTask.add(Task.fromJson(json));
          }
          return listTask;
        }
      }
    } catch (e) {
      log('getTask p: $e');
    }
    return null;
  }

  static Future<void> updateTask({
    required String id,
    required String status,
  }) async {
    try {
      final url = "${ApiConfig.baseUrl}/${ApiConfig.taskEndpoint}/$id";
      final body = {'status': status};
      final token = await SecureStorage.getToken();
      final header = {'Authorization': 'Bearer $token'};
      await http.post(Uri.parse(url), body: body, headers: header);
    } catch (e) {
      log("updateTask: $e");
    }
  }
}
