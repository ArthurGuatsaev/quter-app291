// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'history_bloc.dart';

class HistoryState {
  const HistoryState({this.hists = const []});
  final List<HistoryModel> hists;

  HistoryState copyWith({
    List<HistoryModel>? hists,
  }) {
    return HistoryState(
      hists: hists ?? this.hists,
    );
  }
}
