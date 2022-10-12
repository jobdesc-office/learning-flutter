import 'package:boilerplate/helpers/function.dart';
import 'package:boilerplate/models/default/dspbycust_model.dart';
import 'package:get/get.dart';

import '../../../models/default/dspbycustlabel_model.dart';
import '../../../models/default/dspbystage_model.dart';
import '../../../models/default/dspbystatus_model.dart';

class HomeSource extends GetxController {
  Map<String, List<DspbystageModel>> get groupedStageStats =>
      // ignore: invalid_use_of_protected_member
      bystage.value.groupBy<String>((e) => e.prospectstage!);

  var orderasc = false.obs;

  var dataSchedule = [].obs;
  var dataScheduleGuest = [].obs;
  var x = 0.obs;

  var prospecttotal = ''.obs;
  var prospectlosttotal = ''.obs;
  var prospectwontotal = ''.obs;

  var bystatuswon = <DspbystatusModel>[].obs;
  var bystatuslost = <DspbystatusModel>[].obs;
  var bycustall = <DspbycustModel>[].obs;
  var bycust = <DspbycustModel>[].obs;
  var bystage = <DspbystageModel>[].obs;
  var bycustlabel = <DspbycustlabelModel>[].obs;

  var labelname = <String>[].obs;
  var stagename = <String>[].obs;

  var years = <int>[].obs;
  var year = ''.obs;
}
