import 'package:balance_history/domain/entities/history.dart';
import 'package:intl/intl.dart';

class UtilityService {
  DateTime toDateTime(String date) => DateFormat(
        'yyyy-MM-ddTHH:mm:ss',
      ).parse(date);

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
}


  // var mylist = await ApiServiceImpl().getAllBalanceHistory();
  // print(UtilityService().toDailyBalanceHistory(mylist).reversed.toList());
  // print(UtilityService().toMonthlyBalanceHistory(
  //     UtilityService().toDailyBalanceHistory(mylist).reversed.toList()));
  // print(UtilityService().toYearlyBalanceHistory(
  //     UtilityService().toDailyBalanceHistory(mylist).reversed.toList()));
