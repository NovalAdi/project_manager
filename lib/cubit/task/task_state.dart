part of 'task_cubit.dart';

class TaskState extends Equatable {
  bool isLoading;
  List<Task>? tasks;


  TaskState({
    this.isLoading = false,
    this.tasks,
  });

  TaskState copyWith({
    bool? isLoading,
    List<Task>? tasks,
  }) {
    return TaskState(
      isLoading: isLoading ?? this.isLoading,
      tasks: tasks ?? this.tasks,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        tasks,
      ];
}
