import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:project_manager/cubit/home/home_cubit.dart';
import 'package:project_manager/service/task_service.dart';

import '../../models/task.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final HomeCubit cubit;

  TaskCubit({required this.cubit}) : super(TaskState());

  @override
  void onChange(Change<TaskState> change) {
    log('$change');
    super.onChange(change);
  }

  void init() {
    getTask();
  }

  void reset() {
    emit(state.copyWith(
      isLoading: false,
      tasks: null,
    ));
  }

  void getTask() async {
    if (cubit.state.project == null || cubit.state.user == null) return;
    emit(state.copyWith(isLoading: true));
    final tasks = await TaskService.getTask(
        idProject: cubit.state.project!.id.toString(),
        idUser: cubit.state.user!.id.toString());
    emit(state.copyWith(tasks: tasks));
    emit(state.copyWith(isLoading: false));
  }

  void setStatus(int taskId, {String taskStatus = '', String status = ''}) async {
    String statusSend = 'undone';
    if (taskStatus == 'undone') {
      statusSend = 'done';
    }
    if (status == '') {
      await TaskService.updateTask(id: taskId.toString(), status: statusSend);
    } else {
      await TaskService.updateTask(id: taskId.toString(), status: status);
    }
    getTask();
  }
}
