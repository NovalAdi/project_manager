import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:project_manager/service/auth_service.dart';

import '../../local/secure_strorage.dart';
import '../../models/project.dart';
import '../../models/user.dart';
import '../../service/project_service.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());

  @override
  void onChange(Change<HomeState> change) {
    log('$change');
    super.onChange(change);
  }

  void init() {
    getUser();
    getMainProject();
  }

  void getUser() async {
    emit(state.copyWith(isLoading: true));
    await AuthService.getUser();
    final user = await SecureStorage.getUser();
    emit(state.copyWith(user: user));
    emit(state.copyWith(isLoading: false));
  }

  void reset() {
    emit(state.copyWith(
      isLoading: false,
      isTaskLoading: false,
      user: null,
      listProject: null,
      project: null,
      mainProjectIndex: 0,
      done: 0,
      pending: 0,
      percentage: 0,
    ));
  }

  void getMainProject() async {
    emit(state.copyWith(isLoading: true));
    final user = await SecureStorage.getUser();
    if (user == null) {
      emit(state.copyWith(isLoading: false));
      return;
    }
    emit(state.copyWith(user: user));
    final cacheIndex = await SecureStorage.getMainProjectIndex();
    if (cacheIndex != null) {
      emit(state.copyWith(mainProjectIndex: int.parse(cacheIndex)));
    }
    final listProject =
        await ProjectService.getMainProject(id: user.id.toString());
    emit(state.copyWith(listProject: listProject));
    log('${state.listProject.length}');
    if (state.listProject.isNotEmpty) {
      emit(state.copyWith(project: state.listProject[state.mainProjectIndex]));
    }
    if (state.listProject.isEmpty) {
      emit(state.changeNullProject());
    }

    emit(state.copyWith(isLoading: false));
  }
}
