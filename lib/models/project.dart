import 'package:project_manager/models/task.dart';
import 'package:project_manager/models/user.dart';

class Project {
  final int? id;
  final String? name;
  final String? desk;
  final String? token;
  final DateTime? deadline;
  final int? dayLeft;
  final num? percentage;
  final List<User>? participant;
  final List<Task>? tasks;

  Project({
    this.id,
    this.name,
    this.desk,
    this.token,
    this.deadline,
    this.dayLeft,
    this.percentage,
    this.participant,
    this.tasks,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      name: json['name'],
      desk: json['desk'],
      token: json['token'],
      deadline: DateTime.parse(json['deadline']),
      dayLeft: json['day_left'],
      percentage: json['percentage'],
      participant: json['participant'] != null ? (json['participant'] as List).map((e) => User.fromJson(e)).toList() : [],
      tasks: json['tasks'] != null ? (json['tasks'] as List).map((e) => Task.fromJson(e)).toList() : []
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['desk'] = desk;
    data['token'] = token;
    data['deadline'] = deadline;
    data['day_left'] = dayLeft;
    data['participant'] = participant;
    data['tasks'] = tasks;
    return data;
  }
}
