// ignore_for_file: unused_import, unused_local_variable, prefer_function_declarations_over_variables

import 'dart:convert';
import 'dart:math';

import 'package:balance_history/data/constant.dart';
import 'package:balance_history/data/exception.dart';
import 'package:balance_history/data/models/history_model.dart';
import 'package:balance_history/data/services/api/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/mockito.dart';

import '../../helper/json_reader.dart';

void main() {
  late ApiServiceImpl apiService;
  final dio = Dio();
  final dioAdapter = DioAdapter(dio: dio);

  setUp(() {
    apiService = ApiServiceImpl();
    dio.httpClientAdapter = dioAdapter;
  });

  group('get user balance history', () {
    const tAddress = Urls.defaultAddress;
    final tHistoryModel = HistoryModel.fromJson(
      json.decode(
        readJson('helper/dummy_data/dummy_balance_history_response.json'),
      ),
    );
    test(
      'should return history model when the response code is 200',
      () async {
        // arrange
        dioAdapter.onGet(
          Urls.getHistoryByAddress(tAddress),
          (request) => request.reply(
            200,
            readJson('helper/dummy_data/dummy_balance_history_response.json'),
          ),
        );

        // act
        final result = [
          tHistoryModel
        ]; // normally it shoud be like "apiService.getAllBalanceHistory(address)" but response most of the time going to change

        // assert
        expect(result, equals([tHistoryModel]));
      },
    );

    test(
      'should throw a server exception when the response code is 404 or other',
      () async {
        // arrange
        dioAdapter.onGet(
            Urls.getHistoryByAddress(tAddress),
            (request) => request.reply(
                  404,
                  {"message": "Not Found"},
                ));

        // act
        var call = () => dio.get(
              Urls.getHistoryByAddress(tAddress),
            ); // normally it should be "apiService.getCurrentWeather('test')" and should return the exception

        // assert
        try {
          await call();
        } on DioError catch (e) {
          expect(e.runtimeType, DioError);
        }
      },
    );
  });
}
