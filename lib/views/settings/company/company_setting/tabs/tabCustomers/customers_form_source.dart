import 'dart:typed_data';

import 'package:boilerplate/models/session_model.dart';
import 'package:boilerplate/models/ventes/bpcustomer_model.dart';
import 'package:boilerplate/utils/session_manager.dart';
import 'package:boilerplate/views/settings/company/company_setting/tabs/tabCustomers/cp_customer_presenter.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CustomerFormSource {
  CPCustomerPresenter get presenter => Get.find<CPCustomerPresenter>();

  CustomerFormSource(this.typename);

  String typename;

  final _isProcessing = Rx<bool>(false);
  final _isEdit = Rx<bool>(false);
  final _isFormActive = Rx<bool>(false);

  int? bpcstmid;

  final imgname = Rx<String>('');
  final image = Rx<Uint8List>(Uint8List(1));
  final imageupdate = Rx<String>('http://10.21.1.63/learning-api/public/storage/images/default_image.jpeg');
  final isImage = Rx<bool>(false);

  final createdby = Rx<String>('');
  final createddate = Rx<String>('');
  final updatedby = Rx<String>('');
  final updateddate = Rx<String>('');
  final isactive = Rx<bool>(true);

  BsSelectBoxController selectCustomer = BsSelectBoxController();

  bool get isProcessing => _isProcessing.value;
  set isProcessing(bool value) => _isProcessing.value = value;

  bool get isEdit => _isEdit.value;
  set isEdit(bool value) => _isEdit.value = value;

  bool get isFormActive => _isFormActive.value;
  set isFormActive(bool value) => _isFormActive.value = value;

  void clear() {
    isProcessing = false;
    isEdit = false;
    isFormActive = false;

    imgname.value = '';
    image.value = Uint8List(1);
    imageupdate.value = 'http://10.21.1.63/learning-api/public/storage/images/default_image.jpeg';
    isImage.value = false;

    createdby.value = '';
    createddate.value = '';
    updatedby.value = '';
    updateddate.value = '';
    isactive.value = true;

    selectCustomer.clear();
  }

  void fromModel(BusinessPartnerCustomerModel customer) {
    isEdit = true;
    isFormActive = true;
    bpcstmid = customer.sbcid;
    imageupdate.value = customer.sbccstmpics!.first.url!;
    createdby.value = customer.createdby?.toString() ?? "";
    createddate.value = customer.createddate?.toString() ?? "";
    updatedby.value = customer.updatedby?.toString() ?? "";
    updateddate.value = customer.updateddate?.toString() ?? "";
    isactive.value = customer.isactive!;
    selectCustomer.setSelected(BsSelectBoxOption(text: Text(customer.sbccstm!.cstmname!), value: customer.sbccstmid));
  }

  Future<Map<String, dynamic>> toJson() async {
    SessionModel session = await SessionManager.current();
    int? statusid = await presenter.fetchCustomerStatus(typename);
    imgname.value = (selectCustomer.getSelected()!.getText() as Text).data!;

    return {
      'sbcbpid': GetStorage().read('mybpid'),
      'cstmid': selectCustomer.getSelectedAsString(),
      'sbccstmstatusid': statusid,
      'sbccstmpic': MultipartFile(image.value, filename: imgname.value),
      'createdby': session.userid,
      'updatedby': session.userid,
      'isactive': isactive.value,
      '_method': isEdit ? 'PUT' : null
    };
  }
}
