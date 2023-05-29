import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:project_manager/local/secure_strorage.dart';
import 'package:project_manager/service/project_service.dart';

import '../../models/project.dart';
import '../../service/task_service.dart';
import '../home/home_cubit.dart';
import '../task/task_cubit.dart';

part 'project_state.dart';

class ProjectCubit extends Cubit<ProjectState> {
  final HomeCubit cubitHome;
  final TaskCubit cubitTask;

  ProjectCubit({required this.cubitHome, required this.cubitTask})
      : super(ProjectState());

  @override
  void onChange(Change<ProjectState> change) {
    log('$change');
    super.onChange(change);
  }

  void getListProject() async {
    emit(state.copyWith(isLoading: true));
    final listProject = await ProjectService.getMainProject(
        id: cubitHome.state.user!.id.toString());
    emit(state.copyWith(listProject: listProject));
    emit(state.copyWith(isLoading: false));
  }

  void setMainProject() async {
    int index = cubitHome.state.mainProjectIndex;
    final cacheIndex = await SecureStorage.getMainProjectIndex();
    if (cacheIndex == null) {
      await SecureStorage.cacheMainProjectIndex(index: index.toString());
    } else {
      index = int.parse(cacheIndex);
    }
    cubitHome
        .emit(cubitHome.state.copyWith(project: state.listProject![index]));
  }

  void setTask(int id) async {
    final tasks = await TaskService.getTask(
        idProject: id.toString(), idUser: cubitHome.state.user!.id.toString());
    cubitTask.emit(cubitTask.state.copyWith(tasks: tasks));
  }

  void updateMainProjectIndex(String index, int id) async {
    final cacheIndex = await SecureStorage.getMainProjectIndex();
    if (cacheIndex == null) {
      await SecureStorage.cacheMainProjectIndex(index: index);
    } else {
      await SecureStorage.updateMainProjectIndex(index);
    }
    setMainProject();
    setTask(id);
  }
}
