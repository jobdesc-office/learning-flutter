import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/base_text.dart';
import '../../contracts/base/details_view_contract.dart';
import '../../contracts/base/edit_view_contract.dart';
import '../../contracts/base/index_view_contract.dart';
import '../../services/masters/stbptype_service.dart';
import '../../utils/custom_get_controller.dart';
import '../../widgets/confirm_dialog.dart';

class StBpTypePresenter extends CustomGetXController {
  final _StBpTypeService = Get.find<StBpTypeService>();

  late IndexViewContract _StBpTypeViewContract;
  set StBpTypeViewContract(IndexViewContract StBpTypeViewContract) {
    _StBpTypeViewContract = StBpTypeViewContract;
  }

  late EditViewContract _StBpTypeFetchDataContract;
  set StBpTypeFetchDataContract(EditViewContract StBpTypeFetchDataContract) {
    _StBpTypeFetchDataContract = StBpTypeFetchDataContract;
  }

  late DetailViewContract _StBpTypeDataDetailsContract;
  set StBpTypeDataDetailsContract(
      DetailViewContract StBpTypeDataDetailsContract) {
    _StBpTypeDataDetailsContract = StBpTypeDataDetailsContract;
  }

  Future datatables(
      BuildContext context, Map<String, String> params, int typeid) async {
    Response response = await _StBpTypeService.datatable(params, typeid);
    if (response.statusCode == 200)
      _StBpTypeViewContract.onLoadDatatables(context, response);
    else
      _StBpTypeViewContract.onErrorRequest(response);
  }

  Future cstm(int id) async {
    Response response = await _StBpTypeService.show(id);
    return response.body['cstmname'];
  }

  // void details(BuildContext context, int userid) async {
  //   setProcessing(true);
  //   showDialog(
  //     context: context,
  //     builder: (context) => StBpTypeDetails(),
  //   );

  //   Response response = await _StBpTypeService.show(userid);
  //   if (response.statusCode == 200)
  //     _StBpTypeDataDetailsContract.onSuccessFetchData(response);
  //   else
  //     _StBpTypeViewContract.onErrorRequest(response);
  // }

  // void popup(BuildContext context) async {
  //   setProcessing(true);
  //   showDialog(
  //     context: context,
  //     builder: (context) => StBpTypePopup(),
  //   );
  // }

  // void add(BuildContext context) async {
  //   showDialog(
  //     context: context,
  //     builder: (context) => StBpTypeFormView(
  //       onSave: (body) => save(context, body),
  //     ),
  //   );
  // }

  void save(BuildContext context, Map<String, dynamic> body) async {
    Response response = await _StBpTypeService.store(body);
    if (response.statusCode == 200)
      _StBpTypeViewContract.onCreateSuccess(response, context: context);
    else
      _StBpTypeViewContract.onErrorRequest(response);
  }

  // void edit(BuildContext context, int id) async {
  //   setProcessing(true);
  //   showDialog(
  //     context: context,
  //     builder: (context) => StBpTypeFormView(
  //       onSave: (body) => update(context, body, id),
  //     ),
  //   );

  //   Response response = await _StBpTypeService.show(id);
  //   if (response.statusCode == 200)
  //     _StBpTypeFetchDataContract.onSuccessFetchData(response);
  //   else
  //     _StBpTypeViewContract.onErrorRequest(response);
  // }

  void update(BuildContext context, Map<String, dynamic> body, int id) async {
    setProcessing(true);
    Response response = await _StBpTypeService.update(id, body);
    if (response.statusCode == 200)
      _StBpTypeViewContract.onEditSuccess(response, context: context);
    else
      _StBpTypeViewContract.onErrorRequest(response);
  }

  void delete(BuildContext context, int typeid, String name) {
    showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
        title: BaseText.confirmTitle,
        message: BaseText.deleteConfirmDatatable(field: name),
        onPressed: (_, value) async {
          if (value == ConfirmDialogOption.YES_OPTION) {
            Response response = await _StBpTypeService.destroy(typeid);
            if (response.statusCode == 200)
              _StBpTypeViewContract.onDeleteSuccess(response, context: context);
            else
              _StBpTypeViewContract.onErrorRequest(response);
          } else {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
