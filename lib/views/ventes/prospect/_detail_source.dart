import 'dart:typed_data';

import 'package:get/get.dart';

import '../../../models/ventes/customfield_model.dart';
import '../../../models/ventes/prospect_model.dart';
import '../../../models/ventes/prospectcustomfield_model.dart';
import 'prospectdetail_component/_stagePipeline.dart';

class ProspectDetailsSource extends GetxController {
  var prospectid = 0.obs;
  var prospectbpid = 0.obs;
  var prospectname = ''.obs;
  var prospectvalue = '0.0'.obs;

  var custid = 0.obs;
  var custname = ''.obs;

  var userfullname = ''.obs;
  var bpname = ''.obs;
  var prospectstartdate = ''.obs;
  var endtime = ''.obs;

  var losttype = ''.obs;
  var lostdesc = ''.obs;

  var desc = ''.obs;
  var type = ''.obs;
  var bp = ''.obs;
  var link = ''.obs;
  var loc = ''.obs;
  var remind = ''.obs;
  var timezone = ''.obs;
  var status = ''.obs;

  var online = false.obs;
  var allday = false.obs;
  var private = false.obs;

  MenuTypeOptionsController prospectStageController =
      MenuTypeOptionsController();

  var detailData = [].obs;
  var assign = [].obs;
  var report = [].obs;
  var product = [].obs;
  var contact = <Cstmcontact>[].obs;
  var files = <Prospectfiles>[].obs;
  var customField = <ProspectCustomFieldModel>[].obs;
  var rawcustomField = <CustomFieldModel>[].obs;

  var isAdd = false.obs;
  var isUpdate = false.obs;
  var cfid = 0.obs;

  var isAddCF = false.obs;

  var pickedFile = <Uint8List>[].obs;
}
