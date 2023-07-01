import 'package:project_manager/models/user.dart';

class Notif {
  final int? id;
  final String? message;
  final User? from;
  final String? type;
  final int? idInvitation;
  final int? idTask;

  Notif(
      {this.id,
      this.message,
      this.from,
      this.type,
      this.idInvitation,
      this.idTask});

  factory Notif.fromJson(Map<String, dynamic> json) {
    return Notif(
      id: json['id'],
      message: json['message'],
      from: User.fromJson(json['from_user']),
      type: json['type'],
      idInvitation: json['invitation_id'],
      idTask: json['task_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['from'] = from;
    data['message'] = message;
    data['type'] = type;
    data['invitation_id'] = idInvitation;
    data['task_id'] = idTask;
    return data;
  }
}
