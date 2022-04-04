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

  List<History> toDailyBalanceHistory(List<History> list) {
    List<History> dailyOrderedList = [list[0]];

    for (var i = 1; i < list.length; i++) {
      dailyOrderedList.add(list[i]);

      bool areDaysSame = list[i].dateTime!.day == list[i - 1].dateTime!.day;
      bool areMonthsSame =
          list[i].dateTime!.month == list[i - 1].dateTime!.month;
      bool areYearsSame = list[i].dateTime!.year == list[i - 1].dateTime!.year;

      if (areDaysSame && areMonthsSame && areYearsSame) {
        dailyOrderedList.remove(list[i - 1]);
      }
    }

    List<History> tempList = List<History>.generate(
      30,
      (index) => History(
        balance: 0,
        confirmedDate: '',
        dateTime: DateTime(
          DateTime.now().year,
          DateTime.now().month,
          index + 1,
        ),
      ),
    ).toList();

    for (var i = 0; i < tempList.length; i++) {
      for (var j = 0; j < dailyOrderedList.length; j++) {
        bool areYearsSame =
            dailyOrderedList[j].dateTime!.year == tempList[i].dateTime!.year;
        bool areDaysSame =
            dailyOrderedList[j].dateTime!.day == tempList[i].dateTime!.day;
        bool areMonthsSame =
            dailyOrderedList[j].dateTime!.month == tempList[i].dateTime!.month;

        if (areYearsSame && areDaysSame && areMonthsSame) {
          tempList[i] = dailyOrderedList[j];
        }
      }
    }
    for (var item in tempList) {
      print(item.dateTime.toString());
    }
    return tempList;
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

  num satoshisToBTC(num satoshis) => satoshis == 0 ? 0 : satoshis * 0.00000001;

  num btcToUSD(num btc) => btc * oneBtcToUsd;

  num satoshisToUSD(num satoshis) => btcToUSD(satoshisToBTC(satoshis));
}
