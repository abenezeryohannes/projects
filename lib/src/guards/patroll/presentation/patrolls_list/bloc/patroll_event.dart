part of 'patroll_bloc.dart';

abstract class PatrollEvent extends Equatable {
  const PatrollEvent();

  @override
  List<Object> get props => [];
}

//initial
class OnInitialPatrollEvent extends PatrollEvent {}

//load
class OnLoadPatrollEvent extends PatrollEvent {
  final int? page;
  final int? limit;
  final DateTime? startTime;
  final DateTime? endTime;
  const OnLoadPatrollEvent({
    required this.page,
    required this.limit,
    this.startTime,
    this.endTime,
  });
}

//adding
class OnAddPatrollEvent extends PatrollEvent {
  final PatrollEntity patroll;
  const OnAddPatrollEvent({required this.patroll});
}

//deleting
class OnDeletPatrollEvent extends PatrollEvent {
  final PatrollEntity patroll;
  const OnDeletPatrollEvent({required this.patroll});
}

//editing
class OnEditPatrollEvent extends PatrollEvent {
  final int id;
  final PatrollEntity patroll;
  const OnEditPatrollEvent({required this.id, required this.patroll});
}
