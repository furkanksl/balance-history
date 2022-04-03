import 'package:balance_history/domain/entities/history.dart';
import 'package:intl/intl.dart';

enum ORDER_TYPE {
  daily,
  monthly,
  yearly,
}

class UtilityService {
  static const oneBtcToUsd = 50.000;

  DateTime toDateTime(String date) =>
      DateFormat('yyyy-MM-ddTHH:mm:ss').parse(date);

  List<History> toDailyBalanceHistory(List<History> list) {
    List<History> dailyOrderedList = [list[0]];

    for (var i = 1; i < list.length; i++) {
      dailyOrderedList.add(list[i]);

      bool areDaysSame = list[i].dateTime!.day == list[i - 1].dateTime!.day;
      bool areMonthsSame =
          list[i].dateTime!.month == list[i - 1].dateTime!.month;

      if (areDaysSame && areMonthsSame) {
        dailyOrderedList.remove(list[i - 1]);
      }
    }

    return dailyOrderedList;
  }

  List<History> toMonthlyBalanceHistory(List<History> list) {
    List<History> monthlyOrderedList = [list[0]];

    for (var i = 1; i < list.length; i++) {
      monthlyOrderedList.add(list[i]);

      bool areYearsSame = list[i].dateTime!.year == list[i - 1].dateTime!.year;
      bool areMonthsSame =
          list[i].dateTime!.month == list[i - 1].dateTime!.month;

      if (areYearsSame && areMonthsSame) {
        monthlyOrderedList.remove(list[i - 1]);
      }
    }

    return monthlyOrderedList;
  }

  List<History> toYearlyBalanceHistory(List<History> list) {
    List<History> yearlyOrderedList = [list[0]];

    for (var i = 1; i < list.length; i++) {
      yearlyOrderedList.add(list[i]);

      bool areYearsSame = list[i].dateTime!.year == list[i - 1].dateTime!.year;

      if (areYearsSame) {
        yearlyOrderedList.remove(list[i - 1]);
      }
    }

    return yearlyOrderedList;
  }

  num satoshisToBTC(num satoshis) => satoshis * 0.00000001;

  num btcToUSD(num btc) => btc * oneBtcToUsd;

  List<History> getOrderedBalanceHistory({
    required ORDER_TYPE type,
    required List<History> list,
  }) {
    switch (type) {
      case ORDER_TYPE.daily:
        return toDailyBalanceHistory(list).reversed.toList();

      case ORDER_TYPE.monthly:
        return toMonthlyBalanceHistory(
          UtilityService().toDailyBalanceHistory(list).reversed.toList(),
        );

      case ORDER_TYPE.yearly:
        return toYearlyBalanceHistory(
          UtilityService().toDailyBalanceHistory(list).reversed.toList(),
        );

      default:
        return [];
    }
  }
}
