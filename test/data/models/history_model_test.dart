import 'dart:convert';

import 'package:balance_history/data/models/history_model.dart';
import 'package:balance_history/domain/entities/history.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helper/json_reader.dart';

void main() {
  HistoryModel tHistoryModel = HistoryModel(
    balance: 213123,
    confirmedDate: "2022-03-21T21:25:37Z",
    dateTime: DateTime.now(),
  );

  History tHistory = History(
    balance: 213123,
    confirmedDate: "2022-03-21T21:25:37Z",
    dateTime: DateTime.now(),
  );

  group('to entity', () {
    test(
      'should be a subclass of history entity',
      () async {
        // assert
        final result = tHistoryModel.toEntity();
        expect(result, equals(tHistory));
      },
    );
  });

  group('from json', () {
    test(
      'should return a valid model from json',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(
          readJson('helper/dummy_data/dummy_balance_history_response.json'),
        );

        // act
        final result = HistoryModel.fromJson(jsonMap);

        // assert
        expect(result, equals(tHistoryModel));
      },
    );
  });

  group('to json', () {
    test(
      'should return a json map containing proper data',
      () async {
        // act
        final result = tHistoryModel.toJson();

        // assert
        final expectedJsonMap = {
          "ref_balance": 213123,
          "confirmed": "2022-03-21T21:25:37Z"
        };
        expect(result, equals(expectedJsonMap));
      },
    );
  });
}
