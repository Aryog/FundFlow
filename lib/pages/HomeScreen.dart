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
                top: 160,
                left: 37,
                child: Container(
                  height: 170,
                  width: 320,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 47, 125, 121),
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    children: [
                      Row(
                        children: [Text("Total Balance")],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
