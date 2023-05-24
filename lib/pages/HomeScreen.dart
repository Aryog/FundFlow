import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:fundflow/utils/app_layout.dart';
import 'package:fundflow/utils/app_styles.dart';
import 'package:gap/gap.dart';

class AppHomeScreen extends StatelessWidget {
  const AppHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Styles.bgColor,
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: AppLayout.getHeight(240),
                    decoration: const BoxDecoration(
                      color: Color(0xff368983),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 35,
                          left: 340,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(7),
                            child: Container(
                              height: 40,
                              width: 40,
                              color: Color.fromRGBO(250, 250, 250, 0.1),
                              child: const Icon(
                                Icons.notification_add_outlined,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 30, left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Good Morning!",
                                  style: Styles.headLineStyle1
                                      .copyWith(color: Colors.grey.shade300)),
                              const Gap(5),
                              Text(
                                "Yogesh Aryal",
                                style: Styles.headLineStyle2
                                    .copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: AppLayout.getHeight(160),
                left: AppLayout.getWidth(37),
                child: Container(
                  height: 170,
                  width: 320,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 47, 125, 121),
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: EdgeInsets.all(AppLayout.getHeight(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(AppLayout.getHeight(4)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Balance",
                              style: Styles.headLineStyle2.copyWith(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            Icon(
                              FluentSystemIcons.ic_fluent_more_filled,
                              color: Colors.white,
                            )
                          ],
                        ),
                        Gap(AppLayout.getHeight(8)),
                        Text(
                          "\$ 254.00",
                          style: Styles.headLineStyle1
                              .copyWith(color: Colors.white),
                        ),
                        Gap(AppLayout.getHeight(15)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const CircleAvatar(
                                  radius: 13,
                                  backgroundColor:
                                      Color.fromARGB(255, 85, 145, 141),
                                  child: Icon(
                                    FluentSystemIcons
                                        .ic_fluent_arrow_down_filled,
                                    color: Colors.greenAccent,
                                  ),
                                ),
                                Gap(AppLayout.getHeight(5)),
                                Text(
                                  "Income",
                                  style: Styles.headLineStyle3.copyWith(
                                      color: Color.fromARGB(255, 216, 216, 216),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 13,
                                  backgroundColor:
                                      Color.fromARGB(255, 85, 145, 141),
                                  child: Icon(
                                    FluentSystemIcons.ic_fluent_arrow_up_filled,
                                    color: Colors.red.shade200,
                                  ),
                                ),
                                Gap(AppLayout.getHeight(5)),
                                Text(
                                  "Expenses",
                                  style: Styles.headLineStyle3.copyWith(
                                      color: Color.fromARGB(255, 216, 216, 216),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                )
                              ],
                            ),
                          ],
                        ),
                        Gap(AppLayout.getHeight(5)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Gap(AppLayout.getHeight(10)),
                                Text(
                                  '\$ 1450.00',
                                  style: Styles.textStyle
                                      .copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                            Text(
                              '\$ 1250.00',
                              style: Styles.textStyle
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
