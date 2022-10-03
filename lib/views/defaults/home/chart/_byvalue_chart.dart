import 'package:boilerplate/helpers/function.dart';
import 'package:boilerplate/styles/color_palattes.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/default/dspbycust_model.dart';
import '../../../../presenters/navigation_presenter.dart';
import '../_source.dart';

final source = Get.put(HomeSource());
final _navigation = Get.find<NavigationPresenter>();

class ChartByValue extends StatefulWidget {
  const ChartByValue({Key? key}) : super(key: key);

  @override
  _ChartByValueState createState() => _ChartByValueState();
}

class _ChartByValueState extends State<ChartByValue> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Stack(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.81,
            child: Obx(() => Container(
                  padding: EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                      color: _navigation.darkTheme.value
                          ? ColorPallates.elseDarkColor
                          : Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right: 18.0, left: 12.0, top: 24, bottom: 12),
                    child: Obx(() => LineChart(
                          showAvg
                              ? avgData(dspbyvalues())
                              : mainData(dspbyvalues()),
                        )),
                  ),
                )),
          ),
          SizedBox(
            width: 60,
            height: 34,
            child: TextButton(
              onPressed: () {
                setState(() {
                  showAvg = !showAvg;
                });
              },
              child: Obx(() => Text(
                    'avg',
                    style: TextStyle(
                        fontSize: 12,
                        color: _navigation.darkTheme.value
                            ? showAvg
                                ? Colors.grey.withOpacity(0.5)
                                : Colors.grey
                            : showAvg
                                ? Colors.black.withOpacity(0.5)
                                : Colors.black),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff68737d),
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = const Text('JAN', style: style);
        break;
      case 2:
        text = const Text('FEB', style: style);
        break;
      case 3:
        text = const Text('MAR', style: style);
        break;
      case 4:
        text = const Text('APR', style: style);
        break;
      case 5:
        text = const Text('MAY', style: style);
        break;
      case 6:
        text = const Text('JUN', style: style);
        break;
      case 7:
        text = const Text('JUL', style: style);
        break;
      case 8:
        text = const Text('AUG', style: style);
        break;
      case 9:
        text = const Text('SEP', style: style);
        break;
      case 10:
        text = const Text('OCT', style: style);
        break;
      case 11:
        text = const Text('NOV', style: style);
        break;
      case 12:
        text = const Text('DEC', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8.0,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff67727d),
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 200:
        text = '2 M';
        break;
      case 400:
        text = '4 M';
        break;
      case 600:
        text = '6 M';
        break;
      case 800:
        text = '8 M';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData(List<FlSpot> data) {
    data.add(FlSpot(0, 0));
    data.sort(mySortComparison2);
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 12,
      minY: 0,
      maxY: 1000,
      lineBarsData: [
        LineChartBarData(
          spots: data,
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ],
    );
  }

  LineChartData avgData(List<FlSpot> data) {
    data.add(FlSpot(0, 0));
    data.sort(mySortComparison2);
    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
            interval: 1,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 12,
      minY: 0,
      maxY: 1000,
      lineBarsData: [
        LineChartBarData(
          spots: data,
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ],
    );
  }

  int mySortComparison(DspbycustModel a, DspbycustModel b) {
    final propertyA = a.prospectmm ?? 0;
    final propertyB = b.prospectmm ?? 0;
    if (propertyA < propertyB) {
      return -1;
    } else if (propertyA > propertyB) {
      return 1;
    } else {
      return 0;
    }
  }

  int mySortComparison2(FlSpot a, FlSpot b) {
    final propertyA = a.x;
    final propertyB = b.x;
    if (propertyA < propertyB) {
      return -1;
    } else if (propertyA > propertyB) {
      return 1;
    } else {
      return 0;
    }
  }

  List<FlSpot> dspbyvalues() {
    return (source.bycustall..sort(mySortComparison))
        .where((p0) => p0.prospectyy == DateTime.now().year)
        .groupBy((p0) => p0.prospectmm)
        .values
        .map((e) {
      int total = 0;
      for (var element in e) {
        int x;
        switch (element.prospectvalue.toString().length) {
          case 7:
            x = 3;
            break;
          case 10:
            x = 2;
            break;
          case 13:
            x = 1;
            break;
          default:
            x = 0;
        }
        total += parseInt(
            parseDouble(element.prospectvalue.toString().substring(1, 3)));
      }
      return FlSpot(parseDouble(e.first.prospectmm), parseDouble(total));
    }).toList();
  }
}
