import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../models/session_model.dart';
import '../../../models/ventes/customfield_model.dart';
import '../../../models/ventes/prospect_model.dart';
import '../../../models/ventes/prospectactivity_model.dart';
import '../../../models/ventes/prospectassign_model.dart';
import '../../../models/ventes/prospectcustomfield_model.dart';
import '../../../utils/session_manager.dart';
import 'prospectdetail_component/_stagePipeline.dart';

class ProspectDetailsSource extends GetxController {
  var prospectid = 0.obs;
  var prospectbpid = 0.obs;
  var prospectname = ''.obs;
  var prospectvalue = '0.0'.obs;

  var custid = 0.obs;
  var custname = ''.obs;
  var custlabel = ''.obs;

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

  var showPipeline = false.obs;
  var changenote = false.obs;

  var prospectStageController = MenuTypeOptionsController().obs;

  var detailData = <ProspectActivityModel>[].obs;
  var assign = <Prospectassigns>[].obs;
  var product = [].obs;
  var contact = <Cstmcontact>[].obs;
  var files = <Prospectfiles>[].obs;
  var customField = <ProspectCustomFieldModel>[].obs;
  var rawcustomField = <CustomFieldModel>[].obs;

  var isAdd = false.obs;
  var isUpdate = false.obs;
  var cfid = 0.obs;
  var isdesc = false.obs;

  var isAddCF = false.obs;

  var pickedFile = <Uint8List>[].obs;
  var markFile = <TextEditingController>[].obs;

  List<Map<String, dynamic>> jsonRoles() {
    return List<Map<String, dynamic>>.from(markFile.map((controller) {
      int index = markFile.indexOf(controller);
      return {
        'remark': markFile[index].text,
      };
    }));
  }

  List<MultipartFile> jsonImages() {
    List<MultipartFile> img = [];
    int no = 0;
    for (var item in pickedFile) {
      no++;
      img.add(
          MultipartFile(item, filename: prospectname.value + no.toString()));
    }
    return img;
  }

  Future<Map<String, dynamic>> toJson() async {
    SessionModel session = await SessionManager.current();
    return {
      'id': prospectid.value,
      'name': prospectname.value,
      'createdby': session.userid,
      'updatedby': session.userid,
      'remark': jsonEncode(jsonRoles()),
      'files[]': jsonImages()
    };
  }

  @override
  void onClose() {
    prospectid.value = 0;
    prospectbpid.value = 0;
    prospectname.value = '';
    prospectvalue.value = '0.0';

    custid.value = 0;
    custname.value = '';

    userfullname.value = '';
    bpname.value = '';
    prospectstartdate.value = '';
    endtime.value = '';

    losttype.value = '';
    lostdesc.value = '';

    desc.value = '';
    type.value = '';
    bp.value = '';
    link.value = '';
    loc.value = '';
    remind.value = '';
    timezone.value = '';
    status.value = '';

    online.value = false;
    allday.value = false;
    private.value = false;

    detailData.value = [];
    assign.value = [];
    product.value = [];
    contact.value = <Cstmcontact>[];
    files.value = <Prospectfiles>[];
    customField.value = <ProspectCustomFieldModel>[];
    rawcustomField.value = <CustomFieldModel>[];

    isAdd.value = false;
    isUpdate.value = false;
    cfid.value = 0;

    isAddCF.value = false;

    pickedFile.value = <Uint8List>[];
    super.onClose();
  }
}
