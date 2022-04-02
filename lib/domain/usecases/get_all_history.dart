import 'package:balance_history/domain/entities/history.dart';
import 'package:balance_history/domain/repositories/history_repository.dart';
import 'package:dartz/dartz.dart';

import '../../data/failure.dart';

class GetAllHistory {
  final HistoryRepository repository;

  GetAllHistory(this.repository);

  Future<Either<Failure, List<History>>> execute(String address) {
    return repository.getAllBalanceHistory(address);
  }
}
