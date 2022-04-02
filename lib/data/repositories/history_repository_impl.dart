import 'dart:io';

import 'package:dartz/dartz.dart';

import 'package:balance_history/data/failure.dart';
import 'package:balance_history/data/services/api/api_service.dart';
import 'package:balance_history/domain/entities/history.dart';
import 'package:balance_history/domain/repositories/history_repository.dart';

import '../exception.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final ApiService apiService;

  HistoryRepositoryImpl({
    required this.apiService,
  });

  @override
  Future<Either<Failure, List<History>>> getAllBalanceHistory(
      String address) async {
    try {
      final result = await apiService.getAllBalanceHistory(address);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
