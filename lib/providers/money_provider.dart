import 'package:flutter/material.dart';
import 'dart:convert';
import '../models/money_model.dart';
import 'package:http/http.dart' as http;

class MoneyProvider extends ChangeNotifier {
  List<money> _records = [];
  List<money> get records => _records;

  List<money> _myList = [];
  List<money> get myList => _myList;

  MoneyProvider() {
    initializeData();
  }

  Future<List<money>> initializeData() async {
    String url = 'http://10.0.2.2:5000/record/';
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0NmI5ZjA4OGZmMTUxY2QzZTczZDg1MSIsImlhdCI6MTY4NTIwNDIyMiwiZXhwIjoxNjg1MjA1MTIyfQ.AX8m8bf0qYtkSn35DCtjE8Qjcy3Bo314EKd9k38e1lU'
    };
    _records = [];
    try {
      final uri = Uri.parse(url);
      var response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        print(response);
        List<dynamic> responseData = jsonDecode(response.body);
        responseData.forEach((data) {
          _records.add(money.fromJson(data));
        });
        responseData.forEach((data) {
          _myList.add(money.fromJson(data));
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
