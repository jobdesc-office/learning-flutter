import 'package:get/get.dart';

import '../../../models/ventes/customfield_model.dart';
import '../../../models/ventes/prospectcustomfield_model.dart';
import '_stagePipeline.dart';

class prospectDetailsSource extends GetxController {
  var prospectid = 0.obs;
  var prospectbpid = 0.obs;
  var prospectname = ''.obs;
  var prospectvalue = '0.0'.obs;

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
  var assign = [].obs;
  var report = [].obs;
  var product = [].obs;
  var customField = <ProspectCustomFieldModel>[].obs;
  var rawcustomField = <CustomFieldModel>[].obs;

  var isAdd = false.obs;
  var isUpdate = false.obs;
  var cfid = 0.obs;

  var isAddCF = false.obs;
}
