import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final int? id;
  final String? name;
  final String? desk;
  final String? status;

  Task({
    this.id,
    this.name,
    this.desk,
    this.status,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      name: json['name'],
      desk: json['desk'],
      status: json['status'],
    );
  }

  Task copyWith({
    String? name,
    String? desk,
    String? status,
  }) {
    return Task(
      name: name ?? this.name,
      desk: desk ?? this.desk,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        name,
        desk,
        status,
      ];
}
