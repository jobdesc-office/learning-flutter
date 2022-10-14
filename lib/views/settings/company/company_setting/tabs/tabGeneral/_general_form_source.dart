import 'package:boilerplate/models/session_model.dart';
import 'package:boilerplate/utils/session_manager.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GeneralSource {
  bool isProcessing = false;

  var show = false.obs;

  var createdby = ''.obs;
  var createddate = ''.obs;
  var updatedby = ''.obs;
  var updateddate = ''.obs;
  var isactive = true.obs;

  TextEditingController inputName = TextEditingController();
  TextEditingController inputPIC = TextEditingController();
  TextEditingController inputPhone = TextEditingController();
  TextEditingController inputEmail = TextEditingController();

  BsSelectBoxController choosedType = BsSelectBoxController();

  Future<Map<String, dynamic>> toJson() async {
    SessionModel session = await SessionManager.current();
    return {
      'bptypeid': choosedType.getSelectedAsString(),
      'bpname': inputName.text,
      'bppicname': inputPIC.text,
      'bpemail': inputEmail.text,
      'bpphone': inputPhone.text,
      'createdby': session.userid,
      'updatedby': session.userid,
      'isactive': isactive.value,
    };
  }
}
