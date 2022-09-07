import 'package:boilerplate/constants/config_types.dart';
import 'package:boilerplate/contracts/base/edit_view_contract.dart';
import 'package:boilerplate/contracts/base/index_view_contract.dart';
import 'package:boilerplate/services/masters/type_service.dart';
import 'package:boilerplate/services/ventes/bpcustomer_service.dart';
import 'package:boilerplate/utils/custom_get_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CPCustomerPresenter extends CustomGetXController {
  final _bpCustomerService = Get.find<BpCustomerService>();
  final _typeService = Get.find<TypeService>();

  late IndexViewContract _customerContract;
  set customerContract(IndexViewContract customerContract) {
    _customerContract = customerContract;
  }

  late EditViewContract _customerEditContract;
  set customerEditContract(EditViewContract customerEditContract) {
    _customerEditContract = customerEditContract;
  }

  Future datatables(BuildContext context, Map<String, String> params) async {
    Response response = await _bpCustomerService.datatablesbp(params);
    if (response.statusCode == 200)
      _customerContract.onLoadDatatables(context, response);
    else
      _customerContract.onErrorRequest(response);
  }

  Future show(int id) async {
    setProcessing(true);
    Response response = await _bpCustomerService.show(id);
    if (response.statusCode == 200)
      _customerEditContract.onSuccessFetchData(response);
    else
      _customerContract.onErrorRequest(response);
  }

  void save(BuildContext context, FormData body) async {
    Response response = await _bpCustomerService.storeBpCustomer(
      body,
      contentType: "multipart/form-data",
    );
    if (response.statusCode == 200)
      _customerContract.onCreateSuccess(response, context: context);
    else
      _customerContract.onErrorRequest(response);
  }

  void update(BuildContext context, FormData body, int bpCustomerid) async {
    setProcessing(true);
    Response response = await _bpCustomerService.updateBpCustomer(
      bpCustomerid,
      body,
      contentType: "multipart/form-data",
    );
    if (response.statusCode == 200)
      _customerContract.onEditSuccess(response, context: context);
    else
      _customerContract.onErrorRequest(response);
  }

  Future<int?> fetchCustomerStatus() async {
    Response response = await _typeService.byCode(ConfigType.cstmstatus);
    if (response.isOk) return response.body.firstWhere((e) => e['typename'] == "Customer")['typeid'];
    return null;
  }
}
