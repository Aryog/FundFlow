import 'package:fundflow/pages/HomeScreen.dart';
import 'package:fundflow/pages/LoginScreen1.dart';
import 'package:fundflow/utils/app_styles.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FundFlow',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(54, 137, 131, 1),
        appBarTheme: AppBarTheme(color: Color.fromRGBO(54, 137, 131, 1)),
      ),
      home: AppLoginScreen(),
    );
  }
}
