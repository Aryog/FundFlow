import 'package:flutter/material.dart';
import 'package:fundflow/pages/HomeScreen.dart';
import 'package:fundflow/pages/RegisterScreen.dart';
import 'package:fundflow/pages/StatisticsScreeen.dart';
import 'package:fundflow/pages/addTransac.dart';
import 'package:fundflow/pages/profileScreen.dart';
import 'package:fundflow/utils/app_layout.dart';
import 'package:gap/gap.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int activeIndex = 0;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List Screen = [
      AppHomeScreen(),
      AppStatisticsScreen(),
      AppRegsiterScreen(),
      AppProfileScreen(),
    ];
    return Scaffold(
      body: Screen[activeIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AppAddScreen(
                    isFromHome: true,
                  )));
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xff368983),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          elevation: 10,
          height: AppLayout.getHeight(50),
          shape: CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    activeIndex = 0;
                  });
                },
                child: Icon(
                  Icons.home,
                  size: 30,
                  color: activeIndex == 0
                      ? Color(0xff368983)
                      : Colors.grey.shade500,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    activeIndex = 1;
                  });
                },
                child: Icon(
                  Icons.bar_chart_outlined,
                  size: 30,
                  color: activeIndex == 1
                      ? Color(0xff368983)
                      : Colors.grey.shade500,
                ),
              ),
              Gap(AppLayout.getHeight(10)),
              GestureDetector(
                onTap: () {
                  setState(() {
                    activeIndex = 2;
                  });
                },
                child: Icon(
                  Icons.account_balance_wallet_outlined,
                  size: 30,
                  color: activeIndex == 2
                      ? Color(0xff368983)
                      : Colors.grey.shade500,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    activeIndex = 3;
                  });
                },
                child: Icon(
                  Icons.person_outlined,
                  size: 30,
                  color: activeIndex == 3
                      ? Color(0xff368983)
                      : Colors.grey.shade500,
                ),
              ),
            ],
          )),
    );
  }
}
