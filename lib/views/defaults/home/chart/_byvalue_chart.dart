import 'package:boilerplate/helpers/function.dart';
import 'package:boilerplate/styles/color_palattes.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../models/default/dspbycust_model.dart';
import '../_source.dart';
import '../home.dart';

final source = Get.put(HomeSource());

// ignore: must_be_immutable
class ChartByValue extends StatefulWidget {
  ChartByValue({Key? key, required this.color});

  List<DspbycustModel> alldata = [];
  List<List<DspbycustModel>> alldatas = [];

  final Color color;

  @override
  _ChartByValueState createState() => _ChartByValueState();
}

class _ChartByValueState extends State<ChartByValue> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  bool showAvg = false;

  final currencyFormatter = NumberFormat('#,##0.00', 'ID');
  int touchedIndex = 0;

  @override
  Widget build(BuildContext context) {
    widget.alldata.clear();
    widget.alldatas.clear();
    return Container(
      padding: EdgeInsets.all(5),
      child: AspectRatio(
        aspectRatio: 1.79,
        child: Container(
          padding: EdgeInsets.only(right: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
              color: widget.color),
          child: Padding(
            padding: const EdgeInsets.only(
                right: 18.0, left: 12.0, top: 24, bottom: 12),
            child: LineChart(
              mainData(dspbyvalues(), widget.color),
            ),
          ),
        ),
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
      case 100:
        text = '10 T';
        break;
      case 200:
        text = '20 T';
        break;
      case 300:
        text = '30 T';
        break;
      case 400:
        text = '40 T';
        break;
      case 500:
        text = '50 T';
        break;
      case 600:
        text = '60 T';
        break;
      case 700:
        text = '70 T';
        break;
      case 800:
        text = '80 T';
        break;
      case 900:
        text = '90 T';
        break;
      case 1000:
        text = '100 T';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData(List<FlSpot> data, Color theme) {
    data.add(FlSpot(0, 0));
    data.sort(mySortComparison2);
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          Color color;
          switch (value.toInt()) {
            case 100:
              color = Colors.grey;
              break;
            case 200:
              color = Colors.grey;
              break;
            case 300:
              color = Colors.grey;
              break;
            case 400:
              color = Colors.grey;
              break;
            case 500:
              color = Colors.grey;
              break;
            case 600:
              color = Colors.grey;
              break;
            case 700:
              color = Colors.grey;
              break;
            case 800:
              color = Colors.grey;
              break;
            case 900:
              color = Colors.grey;
              break;
            case 1000:
              color = Colors.grey;
              break;
            default:
              return FlLine(
                color: theme,
                strokeWidth: 1,
              );
          }

          return FlLine(
            color: color,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: theme,
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
        show: false,
        // border: Border.all(color: const Color(0xff37434d), width: 1)
      ),
      minX: 0,
      maxX: 12,
      minY: 0,
      maxY: 1000,
      lineTouchData: LineTouchData(
          touchCallback: (FlTouchEvent event, touchResponse) {
            if (event is FlTapUpEvent) {
              if (touchResponse?.lineBarSpots?.first.spotIndex != -1) {
                int index = touchResponse?.lineBarSpots?.first.spotIndex ?? 0;
                index--;
                if (index != -1)
                  showDialog(
                    context: context,
                    builder: (context) => ValueDetails(
                      model: widget.alldatas[index],
                    ),
                  );
              }
            }
          },
          getTouchedSpotIndicator:
              (LineChartBarData barData, List<int> spotIndexes) {
            return spotIndexes.map((index) {
              return TouchedSpotIndicatorData(
                FlLine(
                  color: Colors.pink,
                ),
                FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) =>
                      FlDotCirclePainter(
                    radius: 8,
                    strokeWidth: 2,
                    strokeColor: Colors.black,
                  ),
                ),
              );
            }).toList();
          },
          touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: ColorPallates.primary,
            tooltipRoundedRadius: 8,
            getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
              return lineBarsSpot.map((lineBarSpot) {
                if (lineBarSpot.spotIndex != 0) {
                  return LineTooltipItem(
                    'Rp ' +
                        currencyFormatter
                            .format(double.parse(widget
                                .alldata[lineBarSpot.spotIndex - 1]
                                .prospectvalue
                                .toString()))
                            .replaceAll(',00', '')
                            .replaceAll('.', ','),
                    const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  );
                } else {
                  return null;
                }
              }).toList();
            },
          )),
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
    int index = -1;
    return (source.bycustall..sort(mySortComparison))
        .where((p0) => p0.prospectyy == DateTime.now().year)
        .groupBy((p0) => p0.prospectmm)
        .values
        .map((e) {
      int total = 0;
      int totalvalid = 0;
      for (var element in e) {
        if (element.prospectvalue.toString().length > 9) {
          index = 2;
        } else {
          index = 1;
        }
        totalvalid += parseInt(element.prospectvalue);
        total += parseInt(element.prospectvalue.toString().substring(0, index));
      }
      widget.alldatas.add(e);
      widget.alldata.add(DspbycustModel(
          prospectvalue: totalvalid, prospectmm: e.first.prospectmm));
      return FlSpot(parseDouble(e.first.prospectmm), parseDouble(total));
    }).toList();
  }
}
