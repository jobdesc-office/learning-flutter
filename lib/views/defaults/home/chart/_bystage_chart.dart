import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

import '../_source.dart';

final source = Get.put(HomeSource());

class ChartByStage extends StatefulWidget {
  const ChartByStage({Key? key}) : super(key: key);

  static const shadowColor = Color(0xFF122132);
  static const dataList = [
    _BarData(Color(0xFFecb206), 18, 18),
    _BarData(Color(0xFFa8bd1a), 17, 8),
    _BarData(Color(0xFF17987b), 10, 15),
    _BarData(Color(0xFFb87d46), 2.5, 5),
    _BarData(Color(0xFF295ab5), 2, 2.5),
    _BarData(Color(0xFFea0107), 2, 2),
  ];

  @override
  State<ChartByStage> createState() => _ChartByStageState();
}

class _ChartByStageState extends State<ChartByStage> {
  BarChartGroupData generateBarGroup(
    int x,
    Color color,
    double value,
    // double shadowValue,
  ) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value,
          color: color,
          width: 6,
        ),
        // BarChartRodData(
        //   toY: shadowValue,
        //   color: ChartByStage.shadowColor,
        //   width: 6,
        // ),
      ],
      showingTooltipIndicators: touchedGroupIndex == x ? [0] : [],
    );
  }

  int touchedGroupIndex = -1;

  @override
  Widget build(BuildContext context) {
    List titledataList = [
      'Make Contact',
      'Qualify Compability',
      'Analize Needs',
      'Pitch',
      'Deliver Proposal',
      'Negotiate',
    ];
    return Card(
      color: Colors.white,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RotatedBox(
              quarterTurns: 1,
              child: AspectRatio(
                aspectRatio: 1.3,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceEvenly,
                    borderData: FlBorderData(
                      show: true,
                      border: const Border.symmetric(
                        horizontal: BorderSide(
                          color: Color(0xFFececec),
                        ),
                      ),
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      rightTitles: AxisTitles(
                        axisNameWidget: Text('Opportunities'),
                        drawBehindEverything: true,
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 30,
                          getTitlesWidget: (value, meta) {
                            return RotatedBox(
                              quarterTurns: 3,
                              child: Text(
                                value.toInt().toString(),
                                style: const TextStyle(
                                  color: Color(0xFF606060),
                                ),
                                textAlign: TextAlign.right,
                              ),
                            );
                          },
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 150,
                          getTitlesWidget: (value, meta) {
                            final index = value.toInt();
                            return SideTitleWidget(
                              axisSide: meta.axisSide,
                              child: RotatedBox(
                                quarterTurns: 3,
                                child: Text(
                                  titledataList[index],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(),
                      topTitles: AxisTitles(),
                    ),
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      getDrawingHorizontalLine: (value) => FlLine(
                        color: const Color(0xFFececec),
                        dashArray: null,
                        strokeWidth: 1,
                      ),
                    ),
                    barGroups: ChartByStage.dataList.asMap().entries.map((e) {
                      final index = e.key;
                      final data = e.value;
                      return generateBarGroup(
                        index, data.color, data.value,
                        // data.shadowValue
                      );
                    }).toList(),
                    maxY: 20,
                    barTouchData: BarTouchData(
                      enabled: true,
                      handleBuiltInTouches: false,
                      touchTooltipData: BarTouchTooltipData(
                          tooltipBgColor: Colors.transparent,
                          tooltipMargin: 0,
                          getTooltipItem: (
                            BarChartGroupData group,
                            int groupIndex,
                            BarChartRodData rod,
                            int rodIndex,
                          ) {
                            return (BarTooltipItem(
                              rod.toY.toString(),
                              TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: rod.color!,
                                  fontSize: 18,
                                  shadows: const [
                                    Shadow(
                                      color: Colors.black26,
                                      blurRadius: 12,
                                    )
                                  ]),
                            ));
                          }),
                      touchCallback: (event, response) {
                        if (event.isInterestedForInteractions &&
                            response != null &&
                            response.spot != null) {
                          setState(() {
                            touchedGroupIndex =
                                response.spot!.touchedBarGroupIndex;
                          });
                        } else {
                          setState(() {
                            touchedGroupIndex = -1;
                          });
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BarData {
  final Color color;
  final double value;
  final double shadowValue;

  const _BarData(this.color, this.value, this.shadowValue);
}

class _IconWidget extends ImplicitlyAnimatedWidget {
  final Color color;
  final bool isSelected;

  const _IconWidget({
    required this.color,
    required this.isSelected,
  }) : super(duration: const Duration(milliseconds: 300));

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
      _IconWidgetState();
}

class _IconWidgetState extends AnimatedWidgetBaseState<_IconWidget> {
  Tween<double>? _rotationTween;

  @override
  Widget build(BuildContext context) {
    final rotation = math.pi * 4 * _rotationTween!.evaluate(animation);
    final scale = 1 + _rotationTween!.evaluate(animation) * 0.5;
    return Transform(
      transform: Matrix4.rotationZ(rotation).scaled(scale, scale),
      origin: const Offset(14, 14),
      child: Icon(
        widget.isSelected ? Icons.face_retouching_natural : Icons.face,
        color: widget.color,
        size: 28,
      ),
    );
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _rotationTween = visitor(
      _rotationTween,
      widget.isSelected ? 1.0 : 0.0,
      (dynamic value) => Tween<double>(
        begin: value,
        end: widget.isSelected ? 1.0 : 0.0,
      ),
    ) as Tween<double>;
  }
}
