import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:project_manager/models/notif.dart';

import '../constants/api_config.dart';
import '../local/secure_strorage.dart';

class NotifService {
  NotifService._();

  static Future<List<Notif>?> getListNotif({required String id}) async {
    try {
      final url = "${ApiConfig.baseUrl}/user/$id/${ApiConfig.notifEndpoint}";
      log(url);
      final token = await SecureStorage.getToken();
      final header = {'authorization': 'Bearer $token'};
      final response = await http.get(Uri.parse(url), headers: header);
      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body);
        final status = responseJson['status'];
        if (status == true) {
          final List listDataNotif = responseJson['data'];
          List<Notif> listNotif = [];
          for (final json in listDataNotif) {
            listNotif.add(Notif.fromJson(json));
          }
          return listNotif;
        }
      }
    } catch (e) {
      log("getListNotif: $e");
    }
    return null;
  }

  static Future<void> updateInvitation({
    required String id,
    required String status,
  }) async {
    try {
      final url = "${ApiConfig.baseUrl}/${ApiConfig.invitationEndpoint}/$id";
      final body = {'status': status};
      final token = await SecureStorage.getToken();
      final header = {'Authorization': 'Bearer $token'};
      await http.post(Uri.parse(url), body: body, headers: header);
    } catch (e) {
      log("updateInvitation: $e");
    }
  }
}
