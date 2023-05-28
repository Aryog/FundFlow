import 'package:flutter/material.dart';
import 'dart:convert';
import '../models/money_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MoneyProvider extends ChangeNotifier {
  List<money> _records = [];
  List<money> get records => _records;

  List<money> _myList = [];
  List<money> get myList => _myList;

  MoneyProvider() {
    initializeData();
  }
  Future<String?> loadData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<List<money>> initializeData() async {
    String url = 'http://10.0.2.2:5000/record/';
    String? accessToken = await loadData("accessToken");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': accessToken!
    };
    try {
      final uri = Uri.parse(url);
      var response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        print(response);
        List<dynamic> responseData = jsonDecode(response.body);
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
}
