import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../models/money_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/app_utilities.dart';
import '../interceptors/api_client.dart';

class MoneyProvider extends ChangeNotifier {
  List<money> _records = [];
  List<money> get records => _records;

  List<money> _myList = [];
  List<money> get myList => _myList;

  money _stateAdd = money(account: null, remarks: '');
  money get stateAdd => _stateAdd;

  final APIClient apiClient = APIClient();

  MoneyProvider() {
    initializeData();
  }

  Future<List<money>> initializeData() async {
    String url = 'http://10.0.2.2:5000/record/';
    String? accessToken = await Utils.loadData("accessToken");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': accessToken!
    };
    try {
      final uri = Uri.parse(url);
      var response = await apiClient.dioInstance
          .get(uri.toString(), options: Options(headers: headers));

      if (response.statusCode == 200) {
        List<dynamic> responseData = response.data;
        _records = [];
        _myList = [];
        responseData.forEach((data) {
          _records.add(money.fromJson(data));
        });
        _myList = _records;
      } else {
        throw Exception('Failed to fetch data from backend');
      }
    } catch (e) {
      print("Error ${e}");
    }
    return _records;
  }

  void addToList(money record) {
    _myList.add(record);
    notifyListeners();
  }

  void removeFromList(money record) {
    _myList.remove(record);
    notifyListeners();
  }

  void updateAccount(String value) {
    _stateAdd.account = value;
    notifyListeners();
  }

  void updateRemarks(String value) {
    _stateAdd.remarks = value;
    notifyListeners();
  }

  void resetStateAdd() {
    _stateAdd = money(account: null, remarks: '');
    notifyListeners();
  }
}
