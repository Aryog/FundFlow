import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MyChartWidget extends StatefulWidget {
  const MyChartWidget({super.key});

  @override
  State<MyChartWidget> createState() => _MyChartWidgetState();
}

class _MyChartWidgetState extends State<MyChartWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        series: <SplineSeries<SalesData, String>>[
          SplineSeries<SalesData, String>(
              dataSource: <SalesData>[
                SalesData(100, 'mon'),
                SalesData(20, 'Tue'),
                SalesData(40, 'Wen'),
                SalesData(100, 'Sat'),
                SalesData(10, 'sun'),
              ],
              xValueMapper: (SalesData sales, _) => sales.year,
              yValueMapper: (SalesData sales, _) => sales.sales)
        ],
      ),
    );
  }
}

class SalesData {
  SalesData(this.sales, this.year);
  final String year;
  final double sales;
}
