import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../models/ventes/schedule_model.dart';

class ScheduleSource extends CalendarDataSource<ScheduleModel> {
  ScheduleSource(List<ScheduleModel> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return DateTime.parse(appointments![index].schestartdate);
  }

  @override
  DateTime getEndTime(int index) {
    // String? date = appointments![index].scheenddate;
    // if (date != null && date == '') {
    //   return DateTime.parse(date.toString());
    // } else {
    //   print(DateTime.parse(appointments![index].schestartdate));
    return DateTime.parse(appointments![index].schestartdate);
    // }
  }

  @override
  String getSubject(int index) {
    return appointments![index].schenm;
  }

  @override
  Color getColor(int index) {
    return appointments![index].bg;
  }
}
