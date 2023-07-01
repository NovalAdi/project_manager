import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:project_manager/cubit/task/task_cubit.dart';
import 'package:project_manager/service/notif_service.dart';

import '../../local/secure_strorage.dart';
import '../../models/notif.dart';
import '../../service/task_service.dart';
import '../home/home_cubit.dart';

part 'notif_state.dart';

class NotifCubit extends Cubit<NotifState> {
  final HomeCubit cubitHome;
  final TaskCubit cubitTask;

  NotifCubit({required this.cubitHome, required this.cubitTask}) : super(NotifState());

  void init() {
    getListNotif();
  }

  void getListNotif() async {
    emit(state.copyWith(isLoading: true));
    final listNotif = await NotifService.getListNotif(id: cubitHome.state.user!.id.toString());
    emit(state.copyWith(listNotif: listNotif));
    emit(state.copyWith(isLoading: false));
  }

  void updateInvitation(int id, String status) async {
    await NotifService.updateInvitation(id: id.toString(), status: status);
    cubitHome.init();
    cubitTask.init();
  }
}
