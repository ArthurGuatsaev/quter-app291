part of 'history_bloc.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

class GetHistoryEvent extends HistoryEvent {}

class SaveHistoryEvent extends HistoryEvent {
  final HistoryModel hist;
  const SaveHistoryEvent({required this.hist});
}

class ReseteHistoryEvent extends HistoryEvent {}
