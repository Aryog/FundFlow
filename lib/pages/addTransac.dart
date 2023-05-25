import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fundflow/utils/app_layout.dart';
import 'package:fundflow/utils/app_styles.dart';
import 'package:gap/gap.dart';

class AppAddScreen extends StatefulWidget {
  const AppAddScreen({super.key});

  @override
  State<AppAddScreen> createState() => _AppAddScreenState();
}

class _AppAddScreenState extends State<AppAddScreen> {
  int activeIndex = 0;
  String? selectedItem;
  final List<String> _item = ['Allowance', 'Salary', 'Cash', 'Bonus', 'Others'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: SafeArea(
          child: Stack(
        alignment: Alignment.center,
        children: [
          background_container(context),
          Positioned(
            top: 100,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppLayout.getHeight(20)),
                  color: Colors.white),
              height: AppLayout.getHeight(500),
              width: AppLayout.getWidth(340),
              child: Column(children: [
                Gap(AppLayout.getHeight(10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          activeIndex = 0;
                        });
                      },
                      child: Text(
                        "Income",
                        style: TextStyle(
                            color: activeIndex == 0
                                ? Colors.green.shade300
                                : Styles.primaryColor),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: activeIndex == 0
                            ? Colors.grey.shade300
                            : Styles.bgColor,
                        padding: EdgeInsets.symmetric(
                            horizontal: AppLayout.getHeight(50)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                AppLayout.getHeight(100))),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          activeIndex = 1;
                        });
                      },
                      child: Text(
                        "Expense",
                        style: TextStyle(
                            color: activeIndex == 1
                                ? Colors.red.shade300
                                : Styles.primaryColor),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: activeIndex == 1
                            ? Colors.grey.shade300
                            : Styles.bgColor,
                        padding: EdgeInsets.symmetric(
                            horizontal: AppLayout.getHeight(50)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                AppLayout.getHeight(100))),
                      ),
                    )
                  ],
                ),
                Divider(
                  thickness: sqrt1_2,
                ),
                Padding(
                  padding: EdgeInsets.all(AppLayout.getHeight(8)),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppLayout.getHeight(8)),
                    width: 300,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 2, color: Color(0xffc5c5c5))),
                    child: DropdownButton<String>(
                      items: _item
                          .map((e) => DropdownMenuItem(
                                child: Container(
                                  child: Container(
                                    child: Row(children: [
                                      Visibility(
                                        visible: e != 'Others',
                                        child: Container(
                                          width: 35,
                                          child: Image.asset(
                                              "assets/images/${e}.png"),
                                        ),
                                      ),
                                      Gap(AppLayout.getHeight(10)),
                                      Text(
                                        e,
                                        style: TextStyle(fontSize: 18),
                                      )
                                    ]),
                                  ),
                                ),
                                value: e,
                              ))
                          .toList(),
                      hint: Text(
                        'Category',
                        style: TextStyle(color: Colors.grey),
                      ),
                      dropdownColor: Colors.white,
                      isExpanded: true,
                      underline: Container(),
                      onChanged: ((value) {
                        setState(() {
                          selectedItem = value!;
                        });
                      }),
                    ),
                  ),
                )
              ]),
            ),
          )
        ],
      )),
    );
  }

  Column background_container(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(AppLayout.getHeight(8)),
          width: double.infinity,
          height: AppLayout.getHeight(240),
          decoration: BoxDecoration(
            color: Styles.secondaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(children: [
            Gap(AppLayout.getHeight(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                Text(
                  activeIndex == 0 ? "Income" : "Expense",
                  style: Styles.headLineStyle2.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
                Icon(
                  Icons.attach_file_outlined,
                  color: Colors.white,
                )
              ],
            )
          ]),
        )
      ],
    );
  }
}
