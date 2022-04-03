import 'package:equatable/equatable.dart';

class History extends Equatable {
  final int balance;
  final String confirmedDate;
  DateTime? dateTime;

  History({required this.balance, required this.confirmedDate, this.dateTime});

  @override
  List<Object?> get props => [
        balance,
        confirmedDate,
      ];
}
