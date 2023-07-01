part of 'notif_cubit.dart';

class NotifState extends Equatable {
  bool isLoading;
  List<Notif>? listNotif;

  NotifState({this.isLoading = false, this.listNotif});

  NotifState copyWith({
    bool? isLoading,
    List<Notif>? listNotif,
  }) {
    return NotifState(
      isLoading: isLoading ?? this.isLoading,
      listNotif: listNotif ?? this.listNotif,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        listNotif,
      ];
}
