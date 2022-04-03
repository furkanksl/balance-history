import 'dart:io';

import 'package:balance_history/data/constant.dart';
import 'package:balance_history/data/exception.dart';
import 'package:balance_history/data/failure.dart';
import 'package:balance_history/data/models/history_model.dart';
import 'package:balance_history/data/repositories/history_repository_impl.dart';
import 'package:balance_history/domain/entities/history.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late MockApiService mockApiService;
  late HistoryRepositoryImpl repository;

  List<History> tBalanceHistoryList = [];

  const tHistoryModel = HistoryModel(
    balance: 213123,
    confirmedDate: "2022-03-21T21:25:37Z",
  );

  const tHistory = History(
    balance: 213123,
    confirmedDate: "2022-03-21T21:25:37Z",
  );

  setUp(() {
    mockApiService = MockApiService();
    repository = HistoryRepositoryImpl(
      apiService: mockApiService,
    );
  });

  group('get user balance history', () {
    const tAddress = Urls.defaultAddress;

    test(
      'should return user balance history when a call to api service is successful',
      () async {
        // arrange
        when(mockApiService.getAllBalanceHistory(tAddress))
            .thenAnswer((_) async => tBalanceHistoryList);

        // act
        final result = await repository.getAllBalanceHistory(tAddress);
        tBalanceHistoryList.add(tHistory);

        // assert
        verify(mockApiService.getAllBalanceHistory(tAddress));
        expect(
          result,
          equals(
            Right(tBalanceHistoryList),
          ),
        );
      },
    );

    test(
      'should return server failure when a call to api service is unsuccessful',
      () async {
        // arrange
        when(mockApiService.getAllBalanceHistory(tAddress))
            .thenThrow(ServerException());

        // act
        final result = await repository.getAllBalanceHistory(tAddress);

        // assert
        verify(mockApiService.getAllBalanceHistory(tAddress));
        expect(
          result,
          equals(
            const Left(ServerFailure('')),
          ),
        );
      },
    );

    test(
      'should return connection failure when the device has no internet',
      () async {
        // arrange
        when(mockApiService.getAllBalanceHistory(tAddress)).thenThrow(
          const SocketException('Failed to connect to the network'),
        );

        // act
        final result = await repository.getAllBalanceHistory(tAddress);

        // assert
        verify(mockApiService.getAllBalanceHistory(tAddress));
        expect(
          result,
          equals(
            const Left(
              ConnectionFailure('Failed to connect to the network'),
            ),
          ),
        );
      },
    );
  });
}
