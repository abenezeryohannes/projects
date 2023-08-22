part of 'staff_activity_bloc.dart';

abstract class StaffActivityState extends Equatable {
  const StaffActivityState();

  @override
  List<Object> get props => [];
}

class StaffActivityInitial extends StaffActivityState {}

//initial
class InitialStaffActivityState extends StaffActivityState {}

//loading
class LoadingStaffActivityState extends StaffActivityState {}

//adding
class AddingStaffActivityState extends StaffActivityState {}

//editing
class EditingStaffActivityState extends StaffActivityState {}

//deleting
class DeletingStaffActivityState extends StaffActivityState {}

//loaded
class LoadedStaffActivityState extends StaffActivityState {
  final List<StaffAttendanceEntity> patrolls;
  const LoadedStaffActivityState({required this.patrolls});
}

//done adding
class AddedStaffActivityState extends StaffActivityState {
  final StaffActivityEntity activity;
  const AddedStaffActivityState({required this.activity});
}

//done editing
class EditedStaffActivityState extends StaffActivityState {
  final StaffActivityEntity activity;
  const EditedStaffActivityState({required this.activity});
}

//done deleting
class DeletedStaffActivityState extends StaffActivityState {}

//error adding
class ErrorAddingStaffActivityState extends StaffActivityState {
  final Failure failure;
  const ErrorAddingStaffActivityState({required this.failure});
}

//error editing
class ErrorEditingStaffActivityState extends StaffActivityState {
  final Failure failure;
  const ErrorEditingStaffActivityState({required this.failure});
}

//error deleting
class ErrorDeletingStaffActivityState extends StaffActivityState {
  final Failure failure;
  const ErrorDeletingStaffActivityState({required this.failure});
}

//error
class ErrorLoadingStaffActivityState extends StaffActivityState {
  final Failure failure;
  const ErrorLoadingStaffActivityState({required this.failure});
}
