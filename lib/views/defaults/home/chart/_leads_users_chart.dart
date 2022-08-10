import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../styles/color_palattes.dart';

class LeadsUsersChart extends StatelessWidget {
  Map<double, String> bottomTitles = {
    0: "Sandra",
  };
  Map<double, String> leftTitles = {
    0: "0",
    1: "1",
    2: "2",
    3: "3",
    4: "4",
    5: "5",
  };
  Map<int, List<Map<String, dynamic>>> data = {
    0: [
      {
        "from": 0.0,
        "to": 4.0,
        "color": Colors.cyan,
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Leads Created By Users",
          textAlign: TextAlign.start,
          style: TextStyle(
            color: ColorPallates.primary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 50),
        SizedBox(
          height: 200,
          child: BarChart(
            BarChartData(
              barTouchData: _BarTouchData(),
              titlesData: titlesData,
              borderData: FlBorderData(show: false),
              barGroups: barGroups,
              gridData: FlGridData(show: false),
              alignment: BarChartAlignment.spaceAround,
              maxY: 5,
            ),
          ),
        ),
      ],
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            // getTitlesWidget: (value, meta) => state.property.getChartTitles(value, meta, bottomTitles),
          ),
        ),
        leftTitles: AxisTitles(
          axisNameWidget: Text(
            "Number of Leads",
            style: TextStyle(
              color: ColorPallates.dark,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          sideTitles: SideTitles(
            interval: 1,
            showTitles: true,
            reservedSize: 30,
            // getTitlesWidget: (value, meta) => state.property.getChartTitles(
            //   value,
            //   meta,
            //   leftTitles,
            // ),
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  List<BarChartGroupData> get barGroups => data.values
      .map((value) => _BarChartGroupData(
          data.keys.toList()[data.values.toList().indexOf(value)], value))
      .toList();
}

class _BarChartRodData extends BarChartRodData {
  _BarChartRodData({
    required double to,
    double? from,
    Color? color,
    double? width,
  }) : super(
          width: width ?? 100,
          toY: to,
          fromY: from,
          color: color,
          borderRadius: BorderRadius.zero,
        );
}

class _BarChartGroupData extends BarChartGroupData {
  _BarChartGroupData(int x, List<Map<String, dynamic>> data)
      : super(
          groupVertically: true,
          x: x,
          barRods: data
              .map<_BarChartRodData>((e) => _BarChartRodData(
                  to: e["to"],
                  from: e["from"],
                  color: e['color'],
                  width: e['width']))
              .toList(),
          showingTooltipIndicators: [data.length - 1],
        );
}

class _BarTouchData extends BarTouchData {
  _BarTouchData({String Function(String)? onFormat})
      : super(
          enabled: false,
          touchTooltipData: BarTouchTooltipData(
              tooltipBgColor: Colors.transparent,
              tooltipPadding: EdgeInsets.zero,
              tooltipMargin: 0,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                String text = rod.toY.round().toString();
                return BarTooltipItem(
                  onFormat?.call(text) ?? text,
                  const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                );
              }),
        );
}
