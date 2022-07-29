import 'package:get/get.dart';

import '../../../models/ventes/schedule_model.dart';

class ScheduleSource extends GetxController {
  var data = <ScheduleModel>[].obs;
  var done = false.obs;

  var focusedDay = DateTime.now().obs;
}
