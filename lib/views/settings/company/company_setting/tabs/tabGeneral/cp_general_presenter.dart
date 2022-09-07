import 'package:boilerplate/contracts/base/edit_view_contract.dart';
import 'package:boilerplate/contracts/base/index_view_contract.dart';
import 'package:boilerplate/services/masters/businesspartner_service.dart';
import 'package:boilerplate/utils/custom_get_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CPGeneralPresenter extends CustomGetXController {
  final _bpService = Get.find<BusinessPartnerService>();

  late IndexViewContract _generalIndexContract;
  set businessPartnerViewContract(IndexViewContract businessPartnerViewContract) {
    _generalIndexContract = businessPartnerViewContract;
  }

  late EditViewContract _generalEditContract;
  set businessPartnerFetchDataContract(EditViewContract businessPartnerFetchDataContract) {
    _generalEditContract = businessPartnerFetchDataContract;
  }

  void edit(int id) async {
    setProcessing(true);

    Response response = await _bpService.show(id);
    if (response.statusCode == 200)
      _generalEditContract.onSuccessFetchData(response);
    else
      _generalIndexContract.onErrorRequest(response);
  }

  void update(BuildContext context, Map<String, dynamic> body, int id) async {
    setProcessing(true);
    Response response = await _bpService.update(id, body);
    if (response.statusCode == 200)
      _generalIndexContract.onEditSuccess(response, context: context);
    else
      _generalIndexContract.onErrorRequest(response);
  }
}
