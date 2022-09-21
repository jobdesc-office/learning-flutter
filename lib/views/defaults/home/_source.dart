import 'package:boilerplate/models/default/dspbycust_model.dart';
import 'package:get/get.dart';

import '../../../models/default/dspbystage_model.dart';

class HomeSource extends GetxController {
  var orderasc = false.obs;

  var dataSchedule = [].obs;
  var dataScheduleGuest = [].obs;
  var x = 0.obs;

  var prospecttotal = ''.obs;
  var prospectlosttotal = ''.obs;
  var prospectwontotal = ''.obs;

  var bycust = <DspbycustModel>[].obs;
  var bystage = <DspbystageModel>[].obs;
  var years = <int>[].obs;
  var year = '${DateTime.now().year}'.obs;
}
