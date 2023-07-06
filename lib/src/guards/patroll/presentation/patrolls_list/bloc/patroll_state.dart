part of 'patroll_bloc.dart';

abstract class PatrollState extends Equatable {
  const PatrollState();

  @override
  List<Object> get props => [];
}

//initial
class InitialPatrollState extends PatrollState {}

//loading
class LoadingPatrollState extends PatrollState {}

//adding
class AddingPatrollState extends PatrollState {}

//editing
class EditingPatrollState extends PatrollState {}

//deleting
class DeletingPatrollState extends PatrollState {}

//loaded
class LoadedPatrollState extends PatrollState {
  final List<PatrollEntity> patrolls;
  const LoadedPatrollState({required this.patrolls});
}

//done adding
class AddedPatrollState extends PatrollState {
  final PatrollEntity patroll;
  const AddedPatrollState({required this.patroll});
}

//done editing
class EditedPatrollState extends PatrollState {
  final PatrollEntity patroll;
  const EditedPatrollState({required this.patroll});
}

//done deleting
class DeletedPatrollState extends PatrollState {}

//error adding
class ErrorAddingPatrollState extends PatrollState {
  final Failure failure;
  const ErrorAddingPatrollState({required this.failure});
}

//error editing
class ErrorEditingPatrollState extends PatrollState {
  final Failure failure;
  const ErrorEditingPatrollState({required this.failure});
}

//error deleting
class ErrorDeletingPatrollState extends PatrollState {
  final Failure failure;
  const ErrorDeletingPatrollState({required this.failure});
}

//error
class ErrorLoadingPatrollState extends PatrollState {
  final Failure failure;
  const ErrorLoadingPatrollState({required this.failure});
}
