import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final int? id;
  final String? name;
  final String? desk;
  final String? status;
  final bool? done;

  const Task({
    this.id,
    this.name,
    this.desk,
    this.status,
    this.done,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      name: json['name'],
      desk: json['desk'],
      status: json['status'],
      done: json['status'] == 'done',
    );
  }

  Task copyWith({
    String? name,
    String? desk,
    String? status,
    bool? done,
  }) {
    return Task(
      name: name ?? this.name,
      desk: desk ?? this.desk,
      status: status ?? this.status,
      done: done ?? this.done,
    );
  }

  @override
  List<Object?> get props => [
        name,
        desk,
        status,
        done,
      ];
}
