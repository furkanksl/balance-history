import 'package:equatable/equatable.dart';

class History extends Equatable {
  final int balance;
  final String confirmedDate;

  const History({
    required this.balance,
    required this.confirmedDate,
  });

  @override
  List<Object?> get props => [
        balance,
        confirmedDate,
      ];
}
