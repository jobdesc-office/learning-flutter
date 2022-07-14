import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/base_text.dart';
import '../../contracts/base/edit_view_contract.dart';
import '../../contracts/base/index_view_contract.dart';
import '../../services/masters/province_service.dart';
import '../../utils/custom_get_controller.dart';
import '../../views/masters/provinces/province_form.dart';
import '../../widgets/confirm_dialog.dart';

class ProvincePresenter extends CustomGetXController {
  final _provinceService = Get.find<ProvinceService>();

  late IndexViewContract _provinceViewContract;
  set provinceViewContract(IndexViewContract provinceViewContract) {
    _provinceViewContract = provinceViewContract;
  }

  late EditViewContract _provinceFetchDataContract;
  set provinceFetchDataContract(EditViewContract provinceFetchDataContract) {
    _provinceFetchDataContract = provinceFetchDataContract;
  }

  Future datatables(BuildContext context, Map<String, String> params) async {
    Response response = await _provinceService.datatables(params);
    if (response.statusCode == 200)
      _provinceViewContract.onLoadDatatables(context, response);
    else
      _provinceViewContract.onErrorRequest(response);
  }

  // void details(BuildContext context, int userid) async {
  //   setProcessing(true);
  //   showDialog(
  //     context: context,
  //     builder: (context) => ProvinceDetails(),
  //   );

  //   Response response = await _ProvinceService.show(userid);
  //   if (response.statusCode == 200)
  //     _ProvinceDataDetailsContract.onSuccessFetchData(response);
  //   else
  //     _ProvinceViewContract.onErrorRequest(response);
  // }

  void add(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => ProvinceFormView(
        onSave: (body) => save(context, body),
      ),
    );
  }

  void save(BuildContext context, Map<String, dynamic> body) async {
    Response response = await _provinceService.store(body);
    if (response.statusCode == 200)
      _provinceViewContract.onCreateSuccess(response, context: context);
    else
      _provinceViewContract.onErrorRequest(response);
  }

  void edit(BuildContext context, int id) async {
    setProcessing(true);
    showDialog(
      context: context,
      builder: (context) => ProvinceFormView(
        onSave: (body) => update(context, body, id),
      ),
    );

    Response response = await _provinceService.show(id);
    if (response.statusCode == 200)
      _provinceFetchDataContract.onSuccessFetchData(response);
    else
      _provinceViewContract.onErrorRequest(response);
  }

  void update(BuildContext context, Map<String, dynamic> body, int id) async {
    setProcessing(true);
    Response response = await _provinceService.update(id, body);
    if (response.statusCode == 200)
      _provinceViewContract.onEditSuccess(response, context: context);
    else
      _provinceViewContract.onErrorRequest(response);
  }

  void delete(BuildContext context, int typeid, String name) {
    showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
        title: BaseText.confirmTitle,
        message: BaseText.deleteConfirmDatatable(field: name),
        onPressed: (_, value) async {
          if (value == ConfirmDialogOption.YES_OPTION) {
            Response response = await _provinceService.destroy(typeid);
            if (response.statusCode == 200)
              _provinceViewContract.onDeleteSuccess(response, context: context);
            else
              _provinceViewContract.onErrorRequest(response);
          } else {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
