import 'package:balance_history/domain/usecases/get_all_history.dart';
import 'package:balance_history/presentation/bloc/history_bloc/history_event.dart';
import 'package:balance_history/presentation/bloc/history_bloc/history_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final GetAllHistory _getAllHistory;

  HistoryBloc(this._getAllHistory) : super(BalanceHistoryEmpty()) {
    on<OnAddressChanged>(
      (event, emit) async {
        final cityName = event.address;

        emit(BalanceHistoryLoading());

        final result = await _getAllHistory.execute(cityName);
        result.fold(
          (failure) {
            emit(BalanceHistoryError(failure.message));
          },
          (data) {
            emit(BalanceHistoryHasData(data));
          },
        );
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
