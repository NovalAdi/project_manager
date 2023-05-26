import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:project_manager/constants/api_config.dart';
import 'package:project_manager/local/secure_strorage.dart';
import 'package:project_manager/models/project.dart';

class ProjectService {
  ProjectService._();

  static Future<Project?> getMainProject({required String id}) async {
    try {
      final url = "${ApiConfig.baseUrl}/${ApiConfig.projectEndpoint}/main/$id";
      log(url);
      final token = await SecureStorage.getToken();
      final header = {'authorization': 'Bearer $token'};
      final response = await http.get(Uri.parse(url), headers: header);
      if (response.statusCode == 200) {
        log(response.body);
        final responseJson = jsonDecode(response.body);
        final status = responseJson['status'];
        if (status == true) {
          final Project project = Project.fromJson(responseJson['data']);
          log('$project');
          return project;
        }
       }
    } catch (e) {
      log("getMainProject: $e");
    }
    return null;
  }

  static Future<List<Project>?> getProject({required int id}) async {
    try {
      final url = "${ApiConfig.baseUrl}/${ApiConfig.projectEndpoint}/$id";
      final token = await SecureStorage.getToken();
      final header = {'authorization': 'Bearer $token'};
      final response = await http.get(Uri.parse(url), headers: header);
      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body);
        final status = responseJson['status'];
        if (status == 'true') {
          final List listDataProject = responseJson['data'];
          List<Project> listProject = [];
          for (final json in listDataProject) {
            listProject.add(Project.fromJson(json));
          }
          return listProject;
        }
      }
    } catch (e) {
      log('getProject: $e');
    }
    return null;
  }
}
