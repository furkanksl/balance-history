import 'package:balance_history/data/constant.dart';
import 'package:balance_history/data/models/history_model.dart';
import 'package:balance_history/domain/entities/history.dart';
import 'package:balance_history/domain/usecases/get_all_history.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late MockHistoryRepository mockHistoryRepository;
  late GetAllHistory usecase;

  setUp(() {
    mockHistoryRepository = MockHistoryRepository();
    usecase = GetAllHistory(mockHistoryRepository);
  });

  History tHistory = History(
    balance: 213123,
    confirmedDate: "2022-03-21T21:25:37Z",
  );

  const tAddress = Urls.defaultAddress;

  test(
    'should get user balance history from the repository',
    () async {
      // arrange
      when(mockHistoryRepository.getAllBalanceHistory(tAddress))
          .thenAnswer((_) async => Right([tHistory]));

      // act
      final result = await usecase.execute(tAddress);

      // assert
      expect(result, equals(Right([tHistory])));
    },
  );
}
