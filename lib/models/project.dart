class Project {
  final int? id;
  final String? name;
  final String? desk;
  final String? token;
  final DateTime? deadline;
  final int? dayLeft;
  final int? totalTask;
  final num? percentage;
  final int? done;
  final int? pending;
  final int? undone;

  Project({
    this.id,
    this.name,
    this.desk,
    this.token,
    this.deadline,
    this.dayLeft,
    this.totalTask,
    this.percentage,
    this.done,
    this.pending,
    this.undone,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      name: json['name'],
      desk: json['desk'],
      token: json['token'],
      deadline: DateTime.parse(json['deadline']),
      dayLeft: json['day_left'],
      totalTask: json['total_task'],
      percentage: json['percentage'],
      done: json['done'],
      pending: json['pending'],
      undone: json['undone'],
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
    data['total_task'] = totalTask;
    data['done'] = done;
    data['pending'] = pending;
    data['undone'] = undone;
    return data;
  }
}
