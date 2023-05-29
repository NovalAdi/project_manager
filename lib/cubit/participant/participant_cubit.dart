import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:project_manager/service/project_service.dart';

import '../../models/user.dart';
import '../home/home_cubit.dart';

part 'participant_state.dart';

class ParticipantCubit extends Cubit<ParticipantState> {
  final HomeCubit cubit;

  ParticipantCubit({required this.cubit}) : super(ParticipantState());

  @override
  void onChange(Change<ParticipantState> change) {
    log('$change');
    super.onChange(change);
  }

  void init() {
    getProjectParticipant();
  }

  void getProjectParticipant() async {
    if (cubit.state.project == null) return;
    emit(state.copyWith(isLoading: true));
    final listParticipant = await ProjectService.getProjectParticipant(
        id: cubit.state.project!.id.toString());
    emit(state.copyWith(participant: listParticipant));
    emit(state.copyWith(isLoading: false));
  }
}
