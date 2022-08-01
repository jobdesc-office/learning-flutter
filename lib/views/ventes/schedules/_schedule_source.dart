import 'package:get/get.dart';

import '../../../models/ventes/schedule_model.dart';

class ScheduleHelper extends GetxController {
  var data = <ScheduleModel>[].obs;
  var tappedData = <ScheduleModel>[].obs;
  var done = false.obs;
  var isTap = false.obs;

  var focusedDay = DateTime.now().obs;
}
