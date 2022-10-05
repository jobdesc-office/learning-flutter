import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/base_text.dart';
import '../../contracts/base/details_view_contract.dart';
import '../../contracts/base/edit_view_contract.dart';
import '../../contracts/base/index_view_contract.dart';
import '../../contracts/ventes/customfield_contract.dart';
import '../../services/settings/customfield_service.dart';
import '../../utils/custom_get_controller.dart';
import '../../views/settings/customfield/customfield_details.dart';
import '../../views/settings/customfield/customfield_form.dart';
import '../../views/ventes/prospect/customfield/customfield_popup.dart';
import '../../widgets/confirm_dialog.dart';

class CustomFieldPresenter extends CustomGetXController {
  final _customFieldService = Get.find<CustomFieldService>();

  late IndexViewContract _customFieldViewContract;
  set customFieldViewContract(IndexViewContract customFieldViewContract) {
    _customFieldViewContract = customFieldViewContract;
  }

  late IndexViewContract _customFielddayactViewContract;
  set customFielddayactViewContract(
      IndexViewContract customFielddayactViewContract) {
    _customFielddayactViewContract = customFielddayactViewContract;
  }

  late EditViewContract _customFieldFetchDataContract;
  set customFieldFetchDataContract(
      EditViewContract customFieldFetchDataContract) {
    _customFieldFetchDataContract = customFieldFetchDataContract;
  }

  late EditViewContract _customFielddFetchDataContract;
  set customFielddFetchDataContract(
      EditViewContract customFielddFetchDataContract) {
    _customFielddFetchDataContract = customFielddFetchDataContract;
  }

  late DetailViewContract _customFieldDataDetailsContract;
  set customFieldDataDetailsContract(
      DetailViewContract customFieldDataDetailsContract) {
    _customFieldDataDetailsContract = customFieldDataDetailsContract;
  }

  late CustomFieldContract _customFieldContract;
  set setCustomFieldContract(CustomFieldContract customFieldContract) {
    _customFieldContract = customFieldContract;
  }

  Future datatables(BuildContext context, Map<String, String> params) async {
    Response response = await _customFieldService.datatablesbp(params);
    if (response.statusCode == 200)
      _customFieldViewContract.onLoadDatatables(context, response);
    else
      _customFieldViewContract.onErrorRequest(response);
  }

  Future datatablesdayact(
      BuildContext context, Map<String, String> params) async {
    Response response = await _customFieldService.datatablesdayactbp(params);
    if (response.statusCode == 200)
      _customFielddayactViewContract.onLoadDatatables(context, response);
    else
      _customFielddayactViewContract.onErrorRequest(response);
  }

  Future cstm(int id) async {
    Response response = await _customFieldService.show(id);
    return response.body['cstmname'];
  }

  void details(BuildContext context, int userid, String data) async {
    setProcessing(true);
    showDialog(
      context: context,
      builder: (context) => CustomFieldDetails(data),
    );

    Response response = await _customFieldService.show(userid);
    if (response.statusCode == 200)
      _customFieldDataDetailsContract.onSuccessFetchData(response);
    else
      _customFieldViewContract.onErrorRequest(response);
  }

  Future allWithBp(BuildContext context, Map<String, String> params) async {
    Response response = await _customFieldService.selectWithBp(params);
    if (response.statusCode == 200)
      _customFieldContract.onLoadCustomFieldSuccess(context, response);
    else
      _customFieldContract.onErrorCustomFieldRequest(response);
  }

  Future allBp(BuildContext context) async {
    Response response = await _customFieldService.withBp();
    if (response.statusCode == 200)
      _customFieldContract.onLoadCustomFieldSuccess(context, response);
    else
      _customFieldContract.onErrorCustomFieldRequest(response);
  }

  void popup(BuildContext context) async {
    setProcessing(true);
    showDialog(
      context: context,
      builder: (context) => CustomFieldPopup(),
    );
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
    Response response = await _customFieldService.store(body);
    if (response.statusCode == 200)
      _customFieldViewContract.onCreateSuccess(response, context: context);
    else
      _customFieldViewContract.onErrorRequest(response);
  }

  void edit(BuildContext context, int id) async {
    setProcessing(true);
    showDialog(
      context: context,
      builder: (context) => CustomFieldFormView(
        onSave: (body) => update(context, body, id),
      ),
    );

    Response response = await _customFieldService.show(id);
    if (response.statusCode == 200)
      _customFieldFetchDataContract.onSuccessFetchData(response);
    else
      _customFieldViewContract.onErrorRequest(response);
  }

  void edits(BuildContext context, int id) async {
    setProcessing(true);

    Response response = await _customFieldService.show(id);
    if (response.statusCode == 200)
      _customFielddFetchDataContract.onSuccessFetchData(response);
    else
      _customFieldViewContract.onErrorRequest(response);
  }

  void update(BuildContext context, Map<String, dynamic> body, int id) async {
    setProcessing(true);
    Response response = await _customFieldService.update(id, body);
    if (response.statusCode == 200)
      _customFieldViewContract.onEditSuccess(response, context: context);
    else
      _customFieldViewContract.onErrorRequest(response);
  }

  void delete(BuildContext context, int typeid, String name) {
    showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
        title: BaseText.confirmTitle,
        message: BaseText.deleteConfirmDatatable(field: name),
        onPressed: (_, value) async {
          if (value == ConfirmDialogOption.YES_OPTION) {
            Response response = await _customFieldService.destroy(typeid);
            if (response.statusCode == 200)
              _customFieldViewContract.onDeleteSuccess(response,
                  context: context);
            else
              _customFieldViewContract.onErrorRequest(response);
          } else {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
