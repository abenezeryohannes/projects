part of 'guest_activity_bloc.dart';

abstract class GuestActivityEvent extends Equatable {
  const GuestActivityEvent();

  @override
  List<Object> get props => [];
}

//initial
class OnInitialGuestctivityEvent extends GuestActivityEvent {}

//load
class OnLoadGuestctivityEvent extends GuestActivityEvent {
  final int? page;
  final int? limit;
  final DateTime? startTime;
  final DateTime? endTime;
  final String? type;
  const OnLoadGuestctivityEvent({
    required this.page,
    required this.limit,
    this.startTime,
    this.endTime,
    this.type,
  });
}

//adding
class OnAddGuestctivityEvent extends GuestActivityEvent {
  final ActivityEntity activity;
  const OnAddGuestctivityEvent({required this.activity});
}

//deleting
class OnDeletGuestctivityEvent extends GuestActivityEvent {
  final ActivityEntity activity;
  const OnDeletGuestctivityEvent({required this.activity});
}

//editing
class OnEditGuestctivityEvent extends GuestActivityEvent {
  final int id;
  final ActivityEntity activity;
  const OnEditGuestctivityEvent({required this.id, required this.activity});
}
