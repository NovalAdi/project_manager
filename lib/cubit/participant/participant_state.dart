part of 'participant_cubit.dart';

class ParticipantState extends Equatable {
  bool isLoading;
  List<User>? participant;

  ParticipantState({this.isLoading = false, this.participant});

  ParticipantState copyWith({
    bool? isLoading,
    List<User>? participant,
  }) {
    return ParticipantState(
        isLoading: isLoading ?? this.isLoading,
        participant: participant ?? this.participant);
  }

  @override
  List<Object?> get props => [
        isLoading,
        participant,
      ];
}
