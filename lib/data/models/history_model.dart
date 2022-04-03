// ignore_for_file: must_be_immutable

import 'package:balance_history/data/services/utility_service.dart';
import 'package:balance_history/domain/entities/history.dart';
import 'package:equatable/equatable.dart';

class HistoryModel extends Equatable {
  final int balance;
  final String confirmedDate;
  DateTime? dateTime;

  HistoryModel({
    required this.balance,
    required this.confirmedDate,
    this.dateTime,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
        balance: json['ref_balance'],
        confirmedDate: json['confirmed'],
        dateTime: UtilityService().toDateTime(json['confirmed']),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ref_balance'] = balance;
    data['confirmed'] = confirmedDate;
    return data;
  }

  History toEntity() => History(
        balance: balance,
        confirmedDate: confirmedDate,
        dateTime: dateTime!,
      );

  @override
  List<Object?> get props => [
        balance,
        confirmedDate,
      ];
}
