import 'package:flutter/material.dart';
import 'package:fundflow/utils/app_styles.dart';

class AppHomeScreen extends StatelessWidget {
  const AppHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Text(
        "Hello World",
        style: Styles.headLineStyle1,
      )),
    );
  }
}
