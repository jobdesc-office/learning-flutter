import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/base_text.dart';
import '../../contracts/base/details_view_contract.dart';
import '../../contracts/base/edit_view_contract.dart';
import '../../contracts/base/index_view_contract.dart';
import '../../services/ventes/customfield_service.dart';
import '../../utils/custom_get_controller.dart';
import '../../views/ventes/customfield/customfield_details.dart';
import '../../views/ventes/customfield/customfield_form.dart';
import '../../widgets/confirm_dialog.dart';

class CustomFieldPresenter extends CustomGetXController {
  final _CustomFieldService = Get.find<CustomFieldService>();

  late IndexViewContract _CustomFieldViewContract;
  set CustomFieldViewContract(IndexViewContract CustomFieldViewContract) {
    _CustomFieldViewContract = CustomFieldViewContract;
  }

  late EditViewContract _CustomFieldFetchDataContract;
  set CustomFieldFetchDataContract(
      EditViewContract CustomFieldFetchDataContract) {
    _CustomFieldFetchDataContract = CustomFieldFetchDataContract;
  }

  late DetailViewContract _CustomFieldDataDetailsContract;
  set CustomFieldDataDetailsContract(
      DetailViewContract CustomFieldDataDetailsContract) {
    _CustomFieldDataDetailsContract = CustomFieldDataDetailsContract;
  }

  Future datatables(BuildContext context, Map<String, String> params) async {
    Response response = await _CustomFieldService.datatables(params);
    if (response.statusCode == 200)
      _CustomFieldViewContract.onLoadDatatables(context, response);
    else
      _CustomFieldViewContract.onErrorRequest(response);
  }

  Future cstm(int id) async {
    Response response = await _CustomFieldService.show(id);
    return response.body['cstmname'];
  }

  void details(BuildContext context, int userid) async {
    setProcessing(true);
    showDialog(
      context: context,
      builder: (context) => CustomFieldDetails(),
    );

    Response response = await _CustomFieldService.show(userid);
    if (response.statusCode == 200)
      _CustomFieldDataDetailsContract.onSuccessFetchData(response);
    else
      _CustomFieldViewContract.onErrorRequest(response);
  }

  void add(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => CustomFieldFormView(
        onSave: (body) => save(context, body),
      ),
    );
  }

  void save(BuildContext context, Map<String, dynamic> body) async {
    Response response = await _CustomFieldService.store(body);
    if (response.statusCode == 200)
      _CustomFieldViewContract.onCreateSuccess(response, context: context);
    else
      _CustomFieldViewContract.onErrorRequest(response);
  }

  void edit(BuildContext context, int id) async {
    setProcessing(true);
    showDialog(
      context: context,
      builder: (context) => CustomFieldFormView(
        onSave: (body) => update(context, body, id),
      ),
    );

    Response response = await _CustomFieldService.show(id);
    if (response.statusCode == 200)
      _CustomFieldFetchDataContract.onSuccessFetchData(response);
    else
      _CustomFieldViewContract.onErrorRequest(response);
  }

  void update(BuildContext context, Map<String, dynamic> body, int id) async {
    setProcessing(true);
    Response response = await _CustomFieldService.update(id, body);
    if (response.statusCode == 200)
      _CustomFieldViewContract.onEditSuccess(response, context: context);
    else
      _CustomFieldViewContract.onErrorRequest(response);
  }

  void delete(BuildContext context, int typeid, String name) {
    showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
        title: BaseText.confirmTitle,
        message: BaseText.deleteConfirmDatatable(field: name),
        onPressed: (_, value) async {
          if (value == ConfirmDialogOption.YES_OPTION) {
            Response response = await _CustomFieldService.destroy(typeid);
            if (response.statusCode == 200)
              _CustomFieldViewContract.onDeleteSuccess(response,
                  context: context);
            else
              _CustomFieldViewContract.onErrorRequest(response);
          } else {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
