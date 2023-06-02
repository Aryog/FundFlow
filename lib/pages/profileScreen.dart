import 'package:flutter/material.dart';
import 'package:fundflow/utils/app_styles.dart';
import 'package:fundflow/utils/app_utilities.dart';

class AppProfileScreen extends StatefulWidget {
  const AppProfileScreen({super.key});

  @override
  State<AppProfileScreen> createState() => _AppProfileScreenState();
}

class _AppProfileScreenState extends State<AppProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: ListView(
        children: [
          Center(
            child: Container(
              width: 200,
              child: ElevatedButton(
                onPressed: () async {
                  await Utils.clearSharedPreferences();
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: Text("Logout"),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Styles.primaryColor),
              ),
            ),
          )
        ],
      ),
    );
  }
}
