import 'package:boilerplate/contracts/base/edit_view_contract.dart';
import 'package:boilerplate/contracts/base/index_view_contract.dart';
import 'package:boilerplate/services/masters/businesspartner_service.dart';
import 'package:boilerplate/utils/custom_get_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompanyPresenter extends CustomGetXController {
  final _businessPartnerService = Get.find<BusinessPartnerService>();

  late IndexViewContract _businessPartnerViewContract;
  set businessPartnerViewContract(IndexViewContract businessPartnerViewContract) {
    _businessPartnerViewContract = businessPartnerViewContract;
  }

  late EditViewContract _businessPartnerFetchDataContract;
  set businessPartnerFetchDataContract(EditViewContract businessPartnerFetchDataContract) {
    _businessPartnerFetchDataContract = businessPartnerFetchDataContract;
  }

  void edit(int id) async {
    setProcessing(true);

    Response response = await _businessPartnerService.show(id);
    if (response.statusCode == 200)
      _businessPartnerFetchDataContract.onSuccessFetchData(response);
    else
      _businessPartnerViewContract.onErrorRequest(response);
  }

  void update(BuildContext context, Map<String, dynamic> body, int id) async {
    setProcessing(true);
    Response response = await _businessPartnerService.update(id, body);
    if (response.statusCode == 200)
      _businessPartnerViewContract.onEditSuccess(response, context: context);
    else
      _businessPartnerViewContract.onErrorRequest(response);
  }
}
