import 'package:balance_history/domain/entities/history.dart';
import 'package:dartz/dartz.dart';

import '../../data/failure.dart';

abstract class HistoryRepository {
  Future<Either<Failure, List<History>>> getAllBalanceHistory(String address);
}
