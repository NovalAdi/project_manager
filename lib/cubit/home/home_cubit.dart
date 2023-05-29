import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../local/secure_strorage.dart';
import '../../models/project.dart';
import '../../models/user.dart';
import '../../service/project_service.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());

  void init() {
    getMainProject();
  }

  void getMainProject() async {
    emit(state.copyWith(isLoading: true));
    final user = await SecureStorage.getUser();
    if (user == null) {
      emit(state.copyWith(isLoading: false));
      return;
    }
    emit(state.copyWith(user: user));
    final listProject =
        await ProjectService.getMainProject(id: user.id.toString());
    emit(state.copyWith(listProject: listProject));
    final cacheIndex = await SecureStorage.getMainProjectIndex();
    if (cacheIndex != null) {
      emit(state.copyWith(mainProjectIndex: int.parse(cacheIndex)));
    }
    emit(state.copyWith(project: state.listProject![state.mainProjectIndex]));
    emit(state.copyWith(isLoading: false));
  }
}
