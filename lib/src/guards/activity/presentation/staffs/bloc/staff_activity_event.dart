part of 'staff_activity_bloc.dart';

abstract class StaffActivityEvent extends Equatable {
  const StaffActivityEvent();

  @override
  List<Object> get props => [];
}

//initial
class OnInitialStaffActivityEvent extends StaffActivityEvent {}

//load
class OnLoadStaffAttendanceEvent extends StaffActivityEvent {
  final int? page;
  final int? limit;
  final DateTime? startTime;
  final DateTime? endTime;
  final String? type;
  const OnLoadStaffAttendanceEvent({
    required this.page,
    required this.limit,
    this.startTime,
    this.endTime,
    this.type,
  });
}

//adding
class OnAddStaffActivityEvent extends StaffActivityEvent {
  final ActivityEntity activity;
  const OnAddStaffActivityEvent({required this.activity});
}

//deleting
class OnDeletStaffActivityEvent extends StaffActivityEvent {
  final ActivityEntity activity;
  const OnDeletStaffActivityEvent({required this.activity});
}

//editing
class OnEditStaffActivityEvent extends StaffActivityEvent {
  final int id;
  final ActivityEntity activity;
  const OnEditStaffActivityEvent({required this.id, required this.activity});
}
