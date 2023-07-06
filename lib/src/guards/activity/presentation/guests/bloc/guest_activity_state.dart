part of 'guest_activity_bloc.dart';

abstract class GuestActivityState extends Equatable {
  const GuestActivityState();

  @override
  List<Object> get props => [];
}

class GuestActivityInitial extends GuestActivityState {}

//initial
class InitialGuestActivityState extends GuestActivityState {}

//loading
class LoadingGuestActivityState extends GuestActivityState {}

//adding
class AddingGuestActivityState extends GuestActivityState {}

//editing
class EditingGuestActivityState extends GuestActivityState {}

//deleting
class DeletingGuestActivityState extends GuestActivityState {}

//loaded
class LoadedGuestActivityState extends GuestActivityState {
  final List<PatrollEntity> patrolls;
  const LoadedGuestActivityState({required this.patrolls});
}

//done adding
class AddedGuestActivityState extends GuestActivityState {
  final PatrollEntity patroll;
  const AddedGuestActivityState({required this.patroll});
}

//done editing
class EditedGuestActivityState extends GuestActivityState {
  final PatrollEntity patroll;
  const EditedGuestActivityState({required this.patroll});
}

//done deleting
class DeletedGuestActivityState extends GuestActivityState {}

//error adding
class ErrorAddingGuestActivityState extends GuestActivityState {
  final Failure failure;
  const ErrorAddingGuestActivityState({required this.failure});
}

//error editing
class ErrorEditingGuestActivityState extends GuestActivityState {
  final Failure failure;
  const ErrorEditingGuestActivityState({required this.failure});
}

//error deleting
class ErrorDeletingGuestActivityState extends GuestActivityState {
  final Failure failure;
  const ErrorDeletingGuestActivityState({required this.failure});
}

//error
class ErrorLoadingGuestActivityState extends GuestActivityState {
  final Failure failure;
  const ErrorLoadingGuestActivityState({required this.failure});
}
