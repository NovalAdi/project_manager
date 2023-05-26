import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:project_manager/models/project.dart';
import 'package:project_manager/service/project_service.dart';
import 'package:project_manager/service/task_service.dart';

import '../../local/secure_strorage.dart';
import '../../models/task.dart';
import '../../models/user.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());

  void getUser() async {

    emit(state.copyWith(isLoading: true));
    User? user = await SecureStorage.getUser();
    if(user == null){
      emit(state.copyWith(isLoading: false));
      return;
    }
    emit(state.copyWith(user: user));
    getTask(user.id!.toString());
    getMainProject();

    emit(state.copyWith(isLoading: false));
  }

  void getTask(String id) async {
    // emit(state.copyWith(isLoading: true));
    List<Task>? listTask = await TaskService.getTask(id: id);
    emit(state.copyWith(listTask: listTask));
    // emit(state.copyWith(isLoading: false));
  }

  void updateTask(String status, String id) async {
    // emit(state.copyWith(isLoading: true));
    await TaskService.updateTask(id: id, status: status);
    emit(state.copyWith(status: status));
    // emit(state.copyWith(isLoading: false));
  }

  void setStatus(String status, String id) {
    // emit(state.copyWith(isDone: !state.isDone));
    if (status == 'undone') {
      updateTask('done', id);
    } else if(status == 'done') {
      updateTask('undone', id);
    }
  }

  void getMainProject() async {
    emit(state.copyWith(isLoading: true));
    Project? mainProject = await ProjectService.getMainProject(id: state.user!.id.toString());
    log('${mainProject?.toJson()} MAIN Project');
    emit(state.copyWith(mainProject: mainProject));
    emit(state.copyWith(isLoading: false));
  }

}
