import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../models/ventes/schedule_model.dart';

class ScheduleSource extends CalendarDataSource {
  ScheduleSource(List<ScheduleModel> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return DateTime.parse(appointments![index].schestartdate);
  }

  @override
  DateTime getEndTime(int index) {
    // return DateTime.parse(appointments![index].schestartdate);
    return DateTime.parse(appointments![index].scheenddate);
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
