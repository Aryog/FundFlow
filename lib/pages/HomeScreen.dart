import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:fundflow/data/listMoneyData.dart';
import 'package:fundflow/utils/app_layout.dart';
import 'package:fundflow/utils/app_styles.dart';
import 'package:fundflow/utils/app_utilities.dart';
import 'package:gap/gap.dart';

class AppHomeScreen extends StatelessWidget {
  const AppHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Styles.bgColor,
        body: SafeArea(
            child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(height: 340, child: _head()),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppLayout.getHeight(15),
                    vertical: AppLayout.getHeight(15)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Transaction History",
                        style: Styles.headLineStyle3
                            .copyWith(color: Styles.primaryColor),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Text("See all",
                            style: Styles.headLineStyle3
                                .copyWith(fontSize: 15, color: Colors.grey)),
                      )
                    ]),
              ),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
              return ListTile(
                leading: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset(
                      "assets/images/${getter()[index].category}.png",
                      height: 35,
                    )),
                title: Text(
                  getter()[index].category!,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                subtitle: getter()[index].type == "Income"
                    ? Text(
                        "On ${getter()[index].account!} (${Utils.getWeekday((getter()[index].date)?.weekday)} ${Utils.getMonth(getter()[index].date?.month)} ${getter()[index].date?.day}, ${getter()[index].date?.year})",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      )
                    : Text(
                        "Using ${getter()[index].account!}",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                trailing: getter()[index].type == "Income"
                    ? Text(
                        '\$${getter()[index].amount}',
                        style:
                            Styles.headLineStyle4.copyWith(color: Colors.green),
                      )
                    : Text('\$${getter()[index].amount}',
                        style:
                            Styles.headLineStyle4.copyWith(color: Colors.red)),
              );
            }, childCount: getter().length))
          ],
        )));
  }

  Widget _head() {
    return Stack(
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
          top: AppLayout.getHeight(140),
          left: AppLayout.getWidth(37),
          child: Container(
            height: 170,
            width: 320,
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                      spreadRadius: 6,
                      offset: Offset(0, 5),
                      blurRadius: 12,
                      color: Color.fromRGBO(47, 125, 121, 0.3))
                ],
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
                      const Icon(
                        FluentSystemIcons.ic_fluent_more_filled,
                        color: Colors.white,
                      )
                    ],
                  ),
                  Gap(AppLayout.getHeight(8)),
                  Text(
                    "\$ 254.00",
                    style: Styles.headLineStyle1.copyWith(color: Colors.white),
                  ),
                  Gap(AppLayout.getHeight(15)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 13,
                            backgroundColor: Color.fromARGB(255, 85, 145, 141),
                            child: Icon(
                              FluentSystemIcons.ic_fluent_arrow_down_filled,
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
                            backgroundColor: Color.fromARGB(255, 85, 145, 141),
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
                            style:
                                Styles.textStyle.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                      Text(
                        '\$ 1250.00',
                        style: Styles.textStyle.copyWith(color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
