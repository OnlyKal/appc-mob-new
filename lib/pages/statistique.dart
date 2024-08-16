import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../func/export.dart';

class Frequentation extends StatefulWidget {
  const Frequentation({super.key});

  @override
  State<Frequentation> createState() => _FrequentationState();
}

class _FrequentationState extends State<Frequentation> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: backPage(context),
          backgroundColor: Colors.white,
          title: Text(
            "Evaluation de fréquentation",
            style: TextStyle(color: mainColor, fontWeight: FontWeight.w600),
          ),
        ),
        body: Center(
            child: Container(
                child: SfCircularChart(
                    legend: Legend(isVisible: true),
                    // Enables the tooltip for all the series in chart
                    tooltipBehavior: _tooltipBehavior,
                    series: <CircularSeries>[
              // Initialize line series
              PieSeries<ChartData, String>(
                  // Enables the tooltip for individual series
                  enableTooltip: true,
                  dataSource: [
                    // Bind data source
                    ChartData('Janvier', 35),
                    ChartData('Février', 28),
                    ChartData('Mars', 34),
                    ChartData('Avril', 32),
                    ChartData('Mai', 40),
                    ChartData('Juin', 40),
                    ChartData('Juillet', 40),
                    ChartData('Août', 40),
                    ChartData('Septembre', 40),
                    ChartData('Octobre', 40),
                    ChartData('Novembre', 40),
                    ChartData('Décembre', 40),
                  ],
                  dataLabelMapper: (datum, index) {
                    return "${datum.x} (${datum.y})";
                  },
                  name: "Statistiques de fréquentation APPC Services",
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y)
            ]))));
  }
  // late TooltipBehavior _tooltipBehavior;

  // @override
  // void initState() {
  //   _tooltipBehavior = TooltipBehavior(enable: true);
  //   super.initState();
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       appBar: AppBar(
  //         title: Text('afadff'),
  //       ),
  //       body: Center(
  //           child: Container(
  //               child: SfCartesianChart(
  //                   // Enables the tooltip for all the series in chart
  //                   tooltipBehavior: _tooltipBehavior,
  //                   // Initialize category axis
  //                   primaryXAxis: CategoryAxis(),
  //                   series: <CartesianSeries>[
  //             // Initialize line series
  //             LineSeries<ChartData, String>(
  //                 enableTooltip: true,
  //                 dataSource: [
  //                   // Bind data source
  //                   ChartData('Ja', 10),
  //                   ChartData('Fe', 10),
  //                   ChartData('Ma', 40),
  //                   ChartData('Av', 10),
  //                   ChartData('Ma', 40),
  //                   ChartData('Ju', 80),
  //                   ChartData('Ju', 40),
  //                   ChartData('Aa', 40),
  //                   ChartData('Se', 10),
  //                   ChartData('Oc', 40),
  //                   ChartData('No', 0),
  //                   ChartData('De', 10),
  //                 ],
  //                 xValueMapper: (ChartData data, _) => data.x,
  //                 yValueMapper: (ChartData data, _) => data.y)
  //           ]))));
  // }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double? y;
}
