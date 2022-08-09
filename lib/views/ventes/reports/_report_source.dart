import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/ventes/report_model.dart';

class ReportHelper extends GetxController {
  var data = <Activities>[].obs;
  var employees = <Dayactuser>[].obs;
  var employeesCount = 0.obs;
  var tappedData = <ReportModel>[].obs;
  var done = false.obs;
  var isTap = false.obs;

  var act = <Activities>[].obs;

  var focusedDay = DateTime.now().obs;

  Widget dayContainer(
    BuildContext context,
    DateTime day, {
    bool outsideDay = false,
    Color color = Colors.black,
    Color textBackground = Colors.transparent,
  }) {
    if (day.weekday == 7 && !outsideDay)
      color = Colors.red;
    else if (day.weekday == 7 && outsideDay)
      color = Colors.red.withOpacity(0.3);

    return Container(
      padding: EdgeInsets.all(2),
      child: Container(
        padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Color(0xfff1f1f1)),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: textBackground,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Text(
                  day.day.toString(),
                  style: TextStyle(color: color, fontSize: 14),
                  textWidthBasis: TextWidthBasis.parent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
