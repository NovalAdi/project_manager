part of 'home_cubit.dart';

class HomeState extends Equatable {
  final bool isLoading;
  final bool isTaskLoading;
  final List<Task> listTask;
  final String status;
  final User? user;
  final Project? mainProject;

  const HomeState({
    this.isLoading = false,
    this.isTaskLoading = false,
    this.listTask = const [],
    this.status = 'undone',
    this.user,
    this.mainProject,
  });

  HomeState copyWith({
    bool? isLoading,
    bool? isTaskLoading,
    List<Task>? listTask,
    String? status,
    User? user,
    Project? mainProject,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      isTaskLoading: isTaskLoading ?? this.isTaskLoading,
      listTask: listTask ?? this.listTask,
      status: status ?? this.status,
      user: user ?? this.user,
      mainProject: mainProject ?? this.mainProject,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isTaskLoading,
        listTask,
        status,
        user,
        mainProject,
      ];
}
