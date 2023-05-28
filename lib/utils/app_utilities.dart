import 'package:fundflow/models/money_model.dart';

class Utils {
  static String getMonth(int? month) {
    switch (month) {
      case DateTime.january:
        return 'Jan';
      case DateTime.february:
        return 'Feb';
      case DateTime.march:
        return 'Mar';
      case DateTime.april:
        return 'Apr';
      case DateTime.may:
        return 'May';
      case DateTime.june:
        return 'Jun';
      case DateTime.july:
        return 'Jul';
      case DateTime.august:
        return 'Aug';
      case DateTime.september:
        return 'Sep';
      case DateTime.october:
        return 'Oct';
      case DateTime.november:
        return 'Nov';
      case DateTime.december:
        return 'Dec';
      default:
        return '';
    }
  }

  static String getWeekday(int? weekdayNumber) {
    switch (weekdayNumber) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  static String getTotalIncome(List<money> myList) {
    double total = 0.0;
    myList.forEach((element) {
      if (element.type == "Income") total += element.amount!;
    });
    return "${total}";
  }

  static String getTotalExpense(List<money> myList) {
    double total = 0.0;
    myList.forEach((element) {
      if (element.type == "Expense") total += element.amount!;
    });
    return "${total}";
  }

  static String getTotalBalance(List<money> myList) {
    double total = 0.0;
    myList.forEach((element) {
      if (element.type == "Income") {
        total += element.amount!;
      } else {
        total -= element.amount!;
      }
    });
    return "${total}";
  }
}
