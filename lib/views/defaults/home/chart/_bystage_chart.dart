import 'package:boilerplate/helpers/function.dart';
import 'package:boilerplate/models/default/dspbystage_model.dart';
import 'package:boilerplate/views/defaults/home/home.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

import '../../../../presenters/navigation_presenter.dart';
import '../../../../styles/color_palattes.dart';
import '../_source.dart';

final source = Get.put(HomeSource());
final _navigation = Get.find<NavigationPresenter>();

class ChartByStage extends StatefulWidget {
  ChartByStage({required this.stage, Key? key}) : super(key: key);

  List<String> stage;

  static const shadowColor = Color(0xFF122132);

  @override
  State<ChartByStage> createState() => _ChartByStageState();
}

class _ChartByStageState extends State<ChartByStage> {
  BarChartGroupData generateBarGroup(
      int x, Color color, double value, List<DspbystageModel> list

      // double shadowValue,
      ) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value,
          color: color,
          width: 15,
        ),
      ],
      showingTooltipIndicators: touchedGroupIndex == x ? [0] : [],
    );
  }

  int touchedGroupIndex = -1;
  // int indexColor = 0;
  Color color = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    int indexColor = 0;
    List<_BarData> dataList =
        source.bystage.groupBy((p0) => p0.prospectstage).values.map((e) {
      switch (indexColor) {
        case 0:
          color = ColorPallates.mobileprimary;
          break;
        case 1:
          color = ColorPallates.mobilesecondary;
          break;
        case 2:
          color = ColorPallates.green;
          break;
        case 3:
          color = ColorPallates.red;
          break;
        case 4:
          color = ColorPallates.indigo;
          break;
        case 5:
          color = ColorPallates.purple;
          break;
        case 6:
          color = ColorPallates.yellow;
          break;
        case 7:
          color = ColorPallates.cyan;
          break;
        case 8:
          color = ColorPallates.pink;
          break;
        case 9:
          color = ColorPallates.cancel;
          break;
        default:
          color = ColorPallates.mobileprimary;
          indexColor = 0;
      }
      indexColor++;
      return _BarData(color, parseDouble(e.length), e);
    }).toList();

    return Obx(() => Card(
          color: _navigation.darkTheme.value
              ? ColorPallates.elseDarkColor
              : Colors.white,
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
                    aspectRatio: 1.35,
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.center,
                        groupsSpace: 29.9,
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
                            axisNameWidget: Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Text('Opportunities'),
                            ),
                            drawBehindEverything: true,
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 30,
                              getTitlesWidget: (value, meta) {
                                return RotatedBox(
                                  quarterTurns: 3,
                                  child: Text(
                                    value.toInt().toString(),
                                    style: TextStyle(
                                      color: _navigation.darkTheme.value
                                          ? Colors.white
                                          : Colors.black,
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
                              reservedSize: 200,
                              getTitlesWidget: (value, meta) {
                                final index = value.toInt();
                                return SideTitleWidget(
                                  axisSide: meta.axisSide,
                                  child: RotatedBox(
                                    quarterTurns: 3,
                                    child: Text(
                                      widget.stage[index],
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
                        barGroups: dataList.asMap().entries.map((e) {
                          final index = e.key;
                          final data = e.value;
                          return generateBarGroup(
                              index, data.color, data.value, data.list
                              // data.shadowValue
                              );
                        }).toList(),
                        maxY: 100,
                        barTouchData: BarTouchData(
                          enabled: true,
                          handleBuiltInTouches: false,
                          touchTooltipData: BarTouchTooltipData(
                              rotateAngle: -90,
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

                            if (response != null &&
                                response.spot != null &&
                                event is FlTapUpEvent) {
                              final x = response.spot!.touchedBarGroup.x;
                              setState(() {
                                showDialog(
                                  context: context,
                                  builder: (context) =>
                                      StageDetails(widget.stage[x]),
                                );
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
        ));
  }
}

class _BarData {
  final Color color;
  final double value;
  final List<DspbystageModel> list;
  // final double shadowValue;

  const _BarData(this.color, this.value, this.list
      // , this.shadowValue
      );
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
