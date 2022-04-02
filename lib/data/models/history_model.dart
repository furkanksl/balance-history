import 'package:balance_history/domain/entities/history.dart';
import 'package:equatable/equatable.dart';

class HistoryModel extends Equatable {
  final int balance;
  final String confirmedDate;

  const HistoryModel({required this.balance, required this.confirmedDate});

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
        balance: json['ref_balance'],
        confirmedDate: json['confirmed'],
      );

  History toEntity() => History(
        balance: balance,
        confirmedDate: confirmedDate,
      );

  @override
  List<Object?> get props => [
        balance,
        confirmedDate,
      ];
}
