part of 'project_cubit.dart';

class ProjectState extends Equatable {
  bool isLoading;
  List<Project>? listProject;

  ProjectState({this.isLoading = false, this.listProject});

  ProjectState copyWith({bool? isLoading, List<Project>? listProject}) {
    return ProjectState(
      isLoading: isLoading ?? this.isLoading,
      listProject: listProject ?? this.listProject,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        listProject,
      ];
}
