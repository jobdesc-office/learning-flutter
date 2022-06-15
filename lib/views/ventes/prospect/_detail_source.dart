import 'package:get/get.dart';

import '_stagePipeline.dart';

class prospectDetailsSource extends GetxController {
  var prospectid = 0.obs;
  var prospectname = ''.obs;
  var prospectvalue = ''.obs;

  var userfullname = ''.obs;
  var bpname = ''.obs;
  var prospectstartdate = ''.obs;
  var endtime = ''.obs;

  var desc = ''.obs;
  var type = ''.obs;
  var bp = ''.obs;
  var link = ''.obs;
  var loc = ''.obs;
  var remind = ''.obs;
  var timezone = ''.obs;

  var online = false.obs;
  var allday = false.obs;
  var private = false.obs;

  MenuTypeOptionsController prospectStageController =
      MenuTypeOptionsController();

  var detailData = [].obs;
}
