import 'package:boilerplate/helpers/function.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/default/dspbycustlabel_model.dart';
import '../../../../presenters/navigation_presenter.dart';
import '../../../../styles/color_palattes.dart';
import '../_source.dart';
import '../home.dart';

final source = Get.put(HomeSource());
int indexColor = 0;
Color color = Colors.transparent;
final _navigation = Get.find<NavigationPresenter>();

class ChartByCustLabel extends StatefulWidget {
  const ChartByCustLabel({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ChartByCustLabelState();
}

class ChartByCustLabelState extends State {
  int touchedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.9,
      child: Obx(() => Card(
            color: _navigation.darkTheme.value
                ? ColorPallates.elseDarkColor
                : Colors.white,
            child: AspectRatio(
              aspectRatio: 1,
              child: Obx(() {
                return PieChart(
                  PieChartData(
                      pieTouchData: PieTouchData(touchCallback:
                          (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            touchedIndex = 0;
                            return;
                          }
                          if (pieTouchResponse.touchedSection != null &&
                              event is FlTapUpEvent) {
                            final x = pieTouchResponse
                                .touchedSection!.touchedSectionIndex;

                            if (x != -1)
                              showDialog(
                                context: context,
                                builder: (context) =>
                                    // ignore: invalid_use_of_protected_member
                                    CustLabelDetails(source.labelname.value[x]),
                              );
                          }
                          touchedIndex = pieTouchResponse
                              .touchedSection!.touchedSectionIndex;
                        });
                      }),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 0,
                      sections: showingSections(source.bycustlabel
                          .groupBy((p0) => p0.prospectcustlabel)
                          .values
                          .map((e) => e)
                          .toList())),
                );
              }),
            ),
          )),
    );
  }

  List<PieChartSectionData> showingSections(
      List<List<DspbycustlabelModel>> model) {
    return List.generate(model.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 18.0 : 12.0;
      final radius = isTouched ? 220.0 : 200.0;
      final widgetSize = isTouched ? 85.0 : 70.0;

      switch (i) {
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
      return PieChartSectionData(
        color: color,
        value: parseDouble(model.elementAt(i).length),
        title: '${model.elementAt(i).length} Customers',
        radius: radius,
        titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: const Color(0xffffffff)),
        badgeWidget: _Badge(
          '${model.elementAt(i).first.prospectcustlabel}',
          size: widgetSize,
          borderColor: color,
        ),
        badgePositionPercentageOffset: .98,
      );
    });
  }
}

class _Badge extends StatelessWidget {
  final String svgAsset;
  final double size;
  final Color borderColor;

  const _Badge(
    this.svgAsset, {
    Key? key,
    required this.size,
    required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => AnimatedContainer(
          duration: PieChart.defaultDuration,
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: _navigation.darkTheme.value
                ? ColorPallates.elseDarkColor
                : Colors.white,
            // shape: BoxShape.circle,
            border: Border.all(
              color: borderColor,
              width: 2,
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withOpacity(.5),
                offset: const Offset(3, 3),
                blurRadius: 3,
              ),
            ],
          ),
          padding: EdgeInsets.all(size * .15),
          child: Center(
            child: Text(svgAsset),
          ),
        ));
  }
}
