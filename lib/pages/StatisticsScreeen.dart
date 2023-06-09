import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:fundflow/data/listTopData.dart';
import '../widgets/chart.dart';
import 'package:fundflow/utils/app_layout.dart';
import 'package:fundflow/utils/app_styles.dart';
import 'package:gap/gap.dart';

class AppStatisticsScreen extends StatefulWidget {
  const AppStatisticsScreen({super.key});

  @override
  State<AppStatisticsScreen> createState() => _AppStatisticsScreenState();
}

class _AppStatisticsScreenState extends State<AppStatisticsScreen> {
  List day = ['Day', 'Week', 'Month', 'Year'];
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: SafeArea(
          child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                Gap(AppLayout.getHeight(20)),
                Text(
                  "Statistics",
                  style: Styles.headLineStyle1,
                ),
                Gap(AppLayout.getHeight(20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ...List.generate(4, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            activeIndex = index;
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: activeIndex == index
                                  ? Color.fromARGB(255, 47, 125, 121)
                                  : Colors.white),
                          child: Text(
                            day[index],
                            style: Styles.headLineStyle2.copyWith(
                                color: activeIndex == index
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      );
                    })
                  ],
                ),
                Gap(AppLayout.getHeight(10)),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: AppLayout.getHeight(15)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 120,
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Expense',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              FluentSystemIcons.ic_fluent_arrow_down_filled,
                              color: Colors.grey,
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 2),
                            borderRadius: BorderRadius.circular(8)),
                      )
                    ],
                  ),
                ),
                Gap(AppLayout.getHeight(20)),
                const MyChartWidget(),
                Gap(AppLayout.getHeight(10)),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Top Spending",
                        style: Styles.headLineStyle3
                            .copyWith(color: Styles.primaryColor),
                      ),
                      Icon(Icons.swap_vert, size: 25, color: Colors.grey)
                    ],
                  ),
                )
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return ListTile(
                leading: Image.asset(
                  "assets/images/${getter_top()[index].category}.png",
                  height: 35,
                ),
                title: Text(getter_top()[index].category!,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                subtitle: Text("Mostly using ${getter_top()[index].account!}",
                    style: TextStyle(fontWeight: FontWeight.w600)),
                trailing: Text('\$${getter_top()[index].amount}',
                    style: Styles.headLineStyle4.copyWith(color: Colors.red)),
              );
            }, childCount: getter_top().length),
          )
        ],
      )),
    );
  }
}
