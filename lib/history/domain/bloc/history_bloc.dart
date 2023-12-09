import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quotex291/history/domain/model/history_model.dart';
import 'package:quotex291/history/domain/repository/hist_repo.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final HistoryRepository histRepo;
  HistoryBloc({required this.histRepo}) : super(const HistoryState()) {
    on<GetHistoryEvent>(getHistores);
    on<SaveHistoryEvent>(saveHistores);
    on<ReseteHistoryEvent>(reseteHistores);
  }
  getHistores(GetHistoryEvent event, Emitter<HistoryState> emit) async {
    final hists = await histRepo.getHistoryRepo();
    emit(state.copyWith(hists: hists));
  }

  saveHistores(SaveHistoryEvent event, Emitter<HistoryState> emit) async {
    await histRepo.saveHistory(hist: event.hist);
    add(GetHistoryEvent());
  }

  reseteHistores(ReseteHistoryEvent event, Emitter<HistoryState> emit) async {
    await histRepo.reseteHistory();
    add(GetHistoryEvent());
  }
}
