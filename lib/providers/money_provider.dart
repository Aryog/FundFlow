import 'package:flutter/material.dart';
import 'dart:convert';
import '../models/money_model.dart';
import 'package:http/http.dart' as http;

class MoneyProvider extends ChangeNotifier {
  List<money> _records = [];
  List<money> get records => _records;

  final List<money> _myList = [];
  List<money> get myList => _myList;

  MoneyProvider() {
    _initializeData();
  }

  Future<List<money>> _initializeData() async {
    String url = 'http://10.0.2.2:5000/record/';
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    try {
      final uri = Uri.parse(url);
      var response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        print(response);
        List<dynamic> responseData = jsonDecode(response.body);
        responseData.forEach((data) {
          _records.add(money.fromJson(data));
        });
      } else {
        throw Exception('Failed to fetch data');
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
