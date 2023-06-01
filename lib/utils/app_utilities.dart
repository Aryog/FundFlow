import 'package:dio/dio.dart';
import 'package:fundflow/interceptors/api_client.dart';
import 'package:fundflow/models/money_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  static Future<money> insertData(String type, String category, String account,
      double? amount, String remarks, DateTime date) async {
    final APIClient apiClient = APIClient();
    String url = 'http://10.0.2.2:5000/record/create';
    String? accessToken = await loadData("accessToken");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': accessToken!
    };
    Map<String, dynamic> body = {
      'type': type,
      'category': category,
      'account': account,
      "amount": amount,
      "remarks": remarks,
      "date": date.toIso8601String(),
    };
    money result = money();
    try {
      final uri = Uri.parse(url);
      var response = await apiClient.dioInstance
          .post(uri.toString(), data: body, options: Options(headers: headers));
      if (response.statusCode == 200) {
        print(response.data);
        result = money.fromJson(response.data);
        return result;
      } else {
        throw Exception('Failed to fetch data from backend');
      }
    } catch (e) {
      print("Error: ${e}");
    }
    return result;
  }

  static Future<bool> updateData(String? id, String type, String category,
      String account, double? amount, String remarks, DateTime date) async {
    final APIClient apiClient = APIClient();
    String url = 'http://10.0.2.2:5000/record/${id}';
    String? accessToken = await loadData("accessToken");
    String? userId = await loadData("userId");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': accessToken!
    };
    Map<String, dynamic> body = {
      'user': userId,
      'type': type,
      'category': category,
      'account': account,
      "amount": amount,
      "remarks": remarks,
      "date": date.toIso8601String(),
    };
    try {
      final uri = Uri.parse(url);
      var response = await apiClient.dioInstance
          .put(uri.toString(), data: body, options: Options(headers: headers));
      if (response.statusCode == 200) {
        print(response.data);
        return true;
      } else {
        throw Exception('Failed to fetch data from backend');
      }
    } catch (e) {
      print("Error: ${e}");
    }
    return false;
  }

  static Future<bool> deleteData(String id) async {
    final APIClient apiClient = APIClient();
    String url = 'http://10.0.2.2:5000/record/${id}';
    String? accessToken = await loadData("accessToken");
    String? userId = await loadData("userId");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': accessToken!
    };
    Map<String, dynamic> body = {
      "user": userId,
    };
    try {
      final uri = Uri.parse(url);
      var response = await apiClient.dioInstance.delete(uri.toString(),
          data: body, options: Options(headers: headers));
      if (response.statusCode == 200) {
        print(response.data);
        return true;
      } else {
        throw Exception('Failed to fetch data from backend');
      }
    } catch (e) {
      print("Error: ${e}");
    }
    return false;
  }

  static Future<String?> loadData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<void> saveData(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }
}
