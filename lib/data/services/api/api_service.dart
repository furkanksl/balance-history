import 'package:balance_history/data/constant.dart';
import 'package:balance_history/data/models/history_model.dart';
import 'package:dio/dio.dart';

import '../../../domain/entities/history.dart';
import '../../exception.dart';

abstract class ApiService {
  Future<List<History>> getAllBalanceHistory({String? address});
}

class ApiServiceImpl implements ApiService {
  var dio = Dio();

  @override
  Future<List<History>> getAllBalanceHistory({String? address}) async {
    var response = await dio.get(
      Urls.getHistoryByAddress(
        address ?? Urls.defaultAddress,
      ),
    );

    if (response.statusCode == 200) {
      List<History> balanceHistoryList = [];

      for (var item in response.data['txrefs']) {
        balanceHistoryList.add(
          HistoryModel.fromJson(item).toEntity(),
        );
      }

      // print(balanceHistoryList.length);

      return balanceHistoryList;
    } else {
      throw ServerException();
    }
  }
}
