import 'package:balance_history/domain/entities/history.dart';
import 'package:equatable/equatable.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object?> get props => [];
}

class BalanceHistoryEmpty extends HistoryState {}

class BalanceHistoryLoading extends HistoryState {}

class BalanceHistoryError extends HistoryState {
  final String message;

  const BalanceHistoryError(this.message);

  @override
  List<Object?> get props => [message];
}

class BalanceHistoryHasData extends HistoryState {
  final List<History> result;

  const BalanceHistoryHasData(this.result);

  @override
  List<Object?> get props => [result];
}
