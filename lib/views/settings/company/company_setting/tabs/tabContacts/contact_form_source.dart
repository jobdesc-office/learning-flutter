import 'package:boilerplate/models/masters/contact_model.dart';
import 'package:boilerplate/models/session_model.dart';
import 'package:boilerplate/utils/session_manager.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactFormSource {
  int? contactid;

  Rx<bool> isProcessing = Rx(false);
  Rx<bool> isFormActive = Rx(false);
  Rx<bool> isEdit = Rx(false);

  Rx<String> createdby = Rx('');
  Rx<String> createddate = Rx('');
  Rx<String> updatedby = Rx('');
  Rx<String> updateddate = Rx('');
  Rx<bool> isactive = Rx(true);

  TextEditingController inputName = TextEditingController();
  TextEditingController inputValue = TextEditingController();

  BsSelectBoxController selectCustomer = BsSelectBoxController();
  BsSelectBoxController selectType = BsSelectBoxController();

  void clear() {
    isProcessing.value = false;
    isFormActive.value = false;
    isEdit.value = false;

    createdby.value = '';
    createddate.value = '';
    updatedby.value = '';
    updateddate.value = '';
    isactive.value = true;

    inputName.clear();
    inputValue.clear();

    selectCustomer.clear();
    selectType.clear();
  }

  void fromModel(ContactModel contact) {
    isEdit.value = true;
    isFormActive.value = true;
    createdby.value = contact.contactcreatedby?.userfullname?.toString() ?? "";
    createddate.value = contact.createddate?.toString() ?? "";
    updatedby.value = contact.contactupdatedby?.userfullname?.toString() ?? "";
    updateddate.value = contact.updateddate?.toString() ?? "";
    isactive.value = contact.isactive!;
    inputName.text = contact.contactname ?? "";
    inputValue.text = contact.contactvalueid ?? "";
    selectCustomer.setSelected(BsSelectBoxOption(
        value: contact.contactbpcustomerid,
        text: Text(contact.contactcustomer!.sbccstmname!)));
    selectType.setSelected(BsSelectBoxOption(
        value: contact.contacttypeid,
        text: Text(contact.contacttype!.sbttypename!)));
    contactid = contact.contactpersonid;
  }

  Future<Map<String, dynamic>> toJson() async {
    SessionModel session = await SessionManager.current();
    return {
      'contactname': inputName.text,
      'contactbpcustomerid': selectCustomer.getSelectedAsString(),
      'contacttypeid': selectType.getSelectedAsString(),
      'contactvalueid': inputValue.text,
      'createdby': session.userid,
      'updatedby': session.userid,
      'isactive': isactive.value,
    };
  }
}
