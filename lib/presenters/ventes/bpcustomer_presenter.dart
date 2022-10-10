import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/base_text.dart';
import '../../contracts/base/details_view_contract.dart';
import '../../contracts/base/edit_view_contract.dart';
import '../../contracts/base/index_view_contract.dart';
import '../../services/ventes/bpcustomer_service.dart';
import '../../utils/custom_get_controller.dart';
import '../../views/ventes/bpcustomers/bpcustomer_details.dart';
import '../../views/ventes/bpcustomers/bpcustomer_form.dart';
import '../../widgets/confirm_dialog.dart';

class BpCustomerPresenter extends CustomGetXController {
  final _bpCustomerService = Get.find<BpCustomerService>();

  late IndexViewContract _bpCustomerViewContract;
  set bpCustomerViewContract(IndexViewContract bpCustomerViewContract) {
    _bpCustomerViewContract = bpCustomerViewContract;
  }

  late IndexViewContract _bpCustomerproViewContract;
  set bpCustomerproViewContract(IndexViewContract bpCustomerViewContract) {
    _bpCustomerproViewContract = bpCustomerViewContract;
  }

  late EditViewContract _bpCustomerFetchDataContract;
  set bpCustomerFetchDataContract(EditViewContract bpCustomerFetchDataContract) {
    _bpCustomerFetchDataContract = bpCustomerFetchDataContract;
  }

  late DetailViewContract _bpCustomerTypeViewContract;
  set bpCustomerDetailViewContract(DetailViewContract bpCustomerViewContract) {
    _bpCustomerTypeViewContract = bpCustomerViewContract;
  }

  Future datatables(BuildContext context, Map<String, String> params) async {
    Response response = await _bpCustomerService.datatables(params);
    if (response.statusCode == 200)
      _bpCustomerViewContract.onLoadDatatables(context, response);
    else
      _bpCustomerViewContract.onErrorRequest(response);
  }

  Future datatablesbp(BuildContext context, Map<String, String> params) async {
    Response response = await _bpCustomerService.datatablesbp(params);
    if (response.statusCode == 200)
      _bpCustomerViewContract.onLoadDatatables(context, response);
    else
      _bpCustomerViewContract.onErrorRequest(response);
  }

  Future datatablesbppro(BuildContext context, Map<String, String> params) async {
    Response response = await _bpCustomerService.datatablesbppro(params);
    if (response.statusCode == 200)
      _bpCustomerproViewContract.onLoadDatatables(context, response);
    else
      _bpCustomerproViewContract.onErrorRequest(response);
  }

  Future datatablesbpcus(BuildContext context, Map<String, String> params) async {
    Response response = await _bpCustomerService.datatablesbpcus(params);
    if (response.statusCode == 200)
      _bpCustomerViewContract.onLoadDatatables(context, response);
    else
      _bpCustomerViewContract.onErrorRequest(response);
  }

  void add(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => BpCustomerFormView(
        onSave: (body) => save(context, body),
      ),
    );
  }

  void save(BuildContext context, FormData body) async {
    Response response = await _bpCustomerService.storeBpCustomer(
      body,
      contentType: "multipart/form-data",
    );
    if (response.statusCode == 200)
      _bpCustomerViewContract.onCreateSuccess(response, context: context);
    else
      _bpCustomerViewContract.onErrorRequest(response);
  }

  void details(BuildContext context, int userid) async {
    setProcessing(true);
    showDialog(
      context: context,
      builder: (context) => BpCustomerDetails(),
    );

    Response response = await _bpCustomerService.show(userid);
    if (response.statusCode == 200)
      _bpCustomerTypeViewContract.onSuccessFetchData(response);
    else
      _bpCustomerViewContract.onErrorRequest(response);
  }

  void edit(BuildContext context, int bpCustomerid) async {
    setProcessing(true);
    showDialog(
      context: context,
      builder: (context) => BpCustomerFormView(
        onSave: (body) => update(context, body, bpCustomerid),
      ),
    );

    Response response = await _bpCustomerService.show(bpCustomerid);
    if (response.statusCode == 200)
      _bpCustomerFetchDataContract.onSuccessFetchData(response);
    else
      _bpCustomerViewContract.onErrorRequest(response);
  }

  void update(BuildContext context, FormData body, int bpCustomerid) async {
    setProcessing(true);
    Response response = await _bpCustomerService.updateBpCustomer(
      bpCustomerid,
      body,
      contentType: "multipart/form-data",
    );
    if (response.statusCode == 200)
      _bpCustomerViewContract.onEditSuccess(response, context: context);
    else
      _bpCustomerViewContract.onErrorRequest(response);
  }

  void setAnytime(BuildContext context, int id) async {
    Response response = await _bpCustomerService.setAnytime(id);
    print(response);
    if (response.statusCode == 200)
      _bpCustomerViewContract.onEditSuccess(response, context: context);
    else
      _bpCustomerViewContract.onErrorRequest(response);
  }

  void setOnlyWithAttendance(BuildContext context, int id) async {
    Response response = await _bpCustomerService.setOnlyWithAttendance(id);
    if (response.statusCode == 200)
      _bpCustomerViewContract.onEditSuccess(response, context: context);
    else
      _bpCustomerViewContract.onErrorRequest(response);
  }

  void delete(BuildContext context, int bpCustomerid, String name) {
    showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
        title: BaseText.confirmTitle,
        message: BaseText.deleteConfirmDatatable(field: name),
        onPressed: (_, value) async {
          if (value == ConfirmDialogOption.YES_OPTION) {
            Response response = await _bpCustomerService.destroy(bpCustomerid);
            if (response.statusCode == 200)
              _bpCustomerViewContract.onDeleteSuccess(response, context: context);
            else
              _bpCustomerViewContract.onErrorRequest(response);
          } else
            Navigator.pop(context);
        },
      ),
    );
  }
}
