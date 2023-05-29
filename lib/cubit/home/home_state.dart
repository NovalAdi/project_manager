part of 'home_cubit.dart';

class HomeState extends Equatable {
  bool isLoading;
  bool isTaskLoading;
  User? user;
  int mainProjectIndex;
  List<Project>? listProject;
  Project? project;
  int done;
  int pending;
  int undone;
  num percentage;

  HomeState({
    this.isLoading = false,
    this.isTaskLoading = false,
    this.user,
    this.listProject,
    this.project,
    this.mainProjectIndex = 0,
    this.done = 0,
    this.pending = 0,
    this.undone = 0,
    this.percentage = 0,
  });

  HomeState copyWith({
    bool? isLoading,
    bool? isTaskLoading,
    User? user,
    List<Project>? listProject,
    Project? project,
    int? mainProjectIndex,
    int? done,
    int? pending,
    int? undone,
    num? percentage,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      isTaskLoading: isTaskLoading ?? this.isTaskLoading,
      user: user ?? this.user,
      listProject: listProject ?? this.listProject,
      project: project ?? this.project,
      mainProjectIndex: mainProjectIndex ?? this.mainProjectIndex,
      done: done ?? this.done,
      pending: pending ?? this.pending,
      percentage: percentage ?? this.pending,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isTaskLoading,
        user,
        listProject,
        project,
        mainProjectIndex,
        done,
        pending,
        undone,
        percentage,
      ];
}
