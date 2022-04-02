import 'package:balance_history/data/constant.dart';
import 'package:balance_history/data/models/history_model.dart';
import 'package:dio/dio.dart';

import '../../exception.dart';

abstract class ApiService {
  Future<List<HistoryModel>> getAllBalanceHistory(String? address);
}

class ApiServiceImp implements ApiService {
  var dio = Dio();

  @override
  Future<List<HistoryModel>> getAllBalanceHistory(String? address) async {
    var response = await dio.get(
      Urls.getHistoryByAddress(
        address ?? Urls.defaultAddress,
      ),
    );

    if (response.statusCode == 200) {
      List<HistoryModel> balanceHistoryList = [];

      for (var item in response.data['txrefs']) {
        balanceHistoryList.add(
          HistoryModel.fromJson(item),
        );
      }

      // print(balanceHistoryList.length);

      return balanceHistoryList;
    } else {
      throw ServerException();
    }
  }
}
