import 'package:boilerplate/contracts/base/index_view_contract.dart';
import 'package:boilerplate/services/ventes/bpcustomer_service.dart';
import 'package:boilerplate/utils/custom_get_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CPCustomerPresenter extends CustomGetXController {
  final _bpCustomerService = Get.find<BpCustomerService>();

  late IndexViewContract _customerContract;
  set customerContract(IndexViewContract customerContract) {
    _customerContract = customerContract;
  }

  Future datatables(BuildContext context, Map<String, String> params) async {
    Response response = await _bpCustomerService.datatablesbp(params);
    if (response.statusCode == 200)
      _customerContract.onLoadDatatables(context, response);
    else
      _customerContract.onErrorRequest(response);
  }
}
