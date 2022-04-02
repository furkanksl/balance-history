import 'package:equatable/equatable.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object?> get props => [];
}

class OnAddressChanged extends HistoryEvent {
  final String address;

  const OnAddressChanged(this.address);

  @override
  List<Object?> get props => [address];
}
