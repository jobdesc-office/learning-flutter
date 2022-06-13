import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/base_text.dart';
import '../../contracts/base/details_view_contract.dart';
import '../../contracts/base/edit_view_contract.dart';
import '../../contracts/base/index_view_contract.dart';
import '../../services/masters/type_service.dart';
import '../../utils/custom_get_controller.dart';
import '../../views/masters/typesparents/typeparents_detail.dart';
import '../../views/masters/typesparents/typesparent_form.dart';
import '../../widgets/confirm_dialog.dart';

class TypeParentPresenter extends CustomGetXController {
  final _typeParentService = Get.find<TypeService>();

  late IndexViewContract _typeParentViewContract;
  set typeParentViewContract(IndexViewContract typeParentViewContract) {
    _typeParentViewContract = typeParentViewContract;
  }

  late EditViewContract _typeParentFetchDataContract;
  set typeParentFetchDataContract(
      EditViewContract typeParentFetchDataContract) {
    _typeParentFetchDataContract = typeParentFetchDataContract;
  }

  late DetailViewContract _typeParentDataDetailsContract;
  set typeParentDataDetailsContract(
      DetailViewContract typeParentDataDetailsContract) {
    _typeParentDataDetailsContract = typeParentDataDetailsContract;
  }

  Future datatables(BuildContext context, Map<String, String> params) async {
    Response response = await _typeParentService.datatables(params);
    if (response.statusCode == 200)
      _typeParentViewContract.onLoadDatatables(context, response);
    else
      _typeParentViewContract.onErrorRequest(response);
  }

  void details(BuildContext context, int userid) async {
    setProcessing(true);
    showDialog(
      context: context,
      builder: (context) => TypeParentDetails(),
    );

    Response response = await _typeParentService.show(userid);
    if (response.statusCode == 200)
      _typeParentDataDetailsContract.onSuccessFetchData(response);
    else
      _typeParentViewContract.onErrorRequest(response);
  }

  void add(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => TypeParentFormView(
        onSave: (body) => save(context, body),
      ),
    );
  }

  void save(BuildContext context, Map<String, dynamic> body) async {
    Response response = await _typeParentService.store(body);
    if (response.statusCode == 200)
      _typeParentViewContract.onCreateSuccess(response, context: context);
    else
      _typeParentViewContract.onErrorRequest(response);
  }

  void edit(BuildContext context, int typeid) async {
    setProcessing(true);
    showDialog(
      context: context,
      builder: (context) => TypeParentFormView(
        onSave: (body) => update(context, body, typeid),
      ),
    );

    Response response = await _typeParentService.show(typeid);
    if (response.statusCode == 200)
      _typeParentFetchDataContract.onSuccessFetchData(response);
    else
      _typeParentViewContract.onErrorRequest(response);
  }

  void update(
      BuildContext context, Map<String, dynamic> body, int typeid) async {
    setProcessing(true);
    Response response = await _typeParentService.update(typeid, body);
    if (response.statusCode == 200)
      _typeParentViewContract.onEditSuccess(response, context: context);
    else
      _typeParentViewContract.onErrorRequest(response);
  }

  void delete(BuildContext context, int typeid, String name) {
    showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
        title: BaseText.confirmTitle,
        message: BaseText.deleteConfirmDatatable(field: name),
        onPressed: (_, value) async {
          if (value == ConfirmDialogOption.YES_OPTION) {
            Response response = await _typeParentService.destroy(typeid);
            if (response.statusCode == 200)
              _typeParentViewContract.onDeleteSuccess(response,
                  context: context);
            else
              _typeParentViewContract.onErrorRequest(response);
          } else {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
