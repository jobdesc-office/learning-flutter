import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/base_text.dart';
import '../../contracts/base/details_view_contract.dart';
import '../../contracts/base/edit_view_contract.dart';
import '../../contracts/base/index_view_contract.dart';
import '../../contracts/master/typechildren_contract.dart';
import '../../services/masters/typechildren_service.dart';
import '../../utils/custom_get_controller.dart';
import '../../views/masters/typeschildren/parentFilter.dart';
import '../../views/masters/typeschildren/parents.dart';
import '../../views/masters/typeschildren/typechildren_detail.dart';
import '../../views/masters/typeschildren/typechildren_form.dart';
import '../../widgets/confirm_dialog.dart';

class TypesChildrenPresenter extends CustomGetXController {
  final _typeChildrenService = Get.find<TypeChildrenService>();

  late IndexViewContract _typeChildrenViewContract;
  set typeChildrenViewContract(IndexViewContract typeChildrenViewContract) {
    _typeChildrenViewContract = typeChildrenViewContract;
  }

  late EditViewContract _typeChildrenFetchDataContract;
  set typeChildrenFetchDataContract(
      EditViewContract typeChildrenFetchDataContract) {
    _typeChildrenFetchDataContract = typeChildrenFetchDataContract;
  }

  late typeChildrenContract _typeChildrenParentDataContract;
  set typeChildrenParentDataContract(
      typeChildrenContract typeChildrenParentDataContract) {
    _typeChildrenParentDataContract = typeChildrenParentDataContract;
  }

  late DetailViewContract _typeChildrenDataDetailsContract;
  set typeChildrenDataDetailsContract(
      DetailViewContract typeChildrenDataDetailsContract) {
    _typeChildrenDataDetailsContract = typeChildrenDataDetailsContract;
  }

  late ParentViewContract _typeChildrenTypeViewContract;
  set typeChildrenTypeViewContract(
      ParentViewContract typeChildrenTypeViewContract) {
    _typeChildrenTypeViewContract = typeChildrenTypeViewContract;
  }

  Future datatablesNonFilter(
      BuildContext context, Map<String, String> params) async {
    Response response = await _typeChildrenService.datatablesNonFilter(params);
    if (response.statusCode == 200) {
      _loadType(params);
      _typeChildrenViewContract.onLoadDatatables(context, response);
    } else
      _typeChildrenViewContract.onErrorRequest(response);
  }

  Future datatables(
      BuildContext context, Map<String, String> params, int id) async {
    Response response =
        await _typeChildrenService.datatablesTypesChild(params, id);
    if (response.statusCode == 200) {
      _loadType(params);
      _typeChildrenViewContract.onLoadDatatables(context, response);
    } else
      _typeChildrenViewContract.onErrorRequest(response);
  }

  Future _loadType(Map<String, String> params) async {
    Response response = await _typeChildrenService.parent(params);
    if (response.statusCode == 200)
      _typeChildrenTypeViewContract.onLoadSuccess(response);
    else
      _typeChildrenViewContract.onErrorRequest(response);
  }

  Future _loadParent(int id) async {
    Response response = await _typeChildrenService.showParent(id);
    if (response.statusCode == 200)
      _typeChildrenParentDataContract.onLoadParentSuccess(response);
    else
      _typeChildrenViewContract.onErrorRequest(response);
  }

  void details(BuildContext context, int userid) async {
    setProcessing(true);
    showDialog(
      context: context,
      builder: (context) => TypeChildrenDetails(),
    );

    Response response = await _typeChildrenService.show(userid);
    _loadParent(response.body['typemasterid']);
    if (response.statusCode == 200)
      _typeChildrenDataDetailsContract.onSuccessFetchData(response);
    else
      _typeChildrenViewContract.onErrorRequest(response);
  }

  void filter(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => TypeChildrenFilter(),
    );
  }

  void add(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => TypeChildrenFormView(
        onSave: (body) => save(context, body),
      ),
    );
  }

  void save(BuildContext context, Map<String, dynamic> body) async {
    Response response = await _typeChildrenService.store(body);
    if (response.statusCode == 200)
      _typeChildrenViewContract.onCreateSuccess(response, context: context);
    else
      _typeChildrenViewContract.onErrorRequest(response);
  }

  void edit(BuildContext context, int typeid) async {
    setProcessing(true);
    showDialog(
      context: context,
      builder: (context) => TypeChildrenFormView(
        onSave: (body) => update(context, body, typeid),
      ),
    );

    Response response = await _typeChildrenService.show(typeid);
    _loadParent(response.body['typemasterid']);
    if (response.statusCode == 200)
      _typeChildrenFetchDataContract.onSuccessFetchData(response);
    else
      _typeChildrenViewContract.onErrorRequest(response);
  }

  void update(
      BuildContext context, Map<String, dynamic> body, int typeid) async {
    setProcessing(true);
    Response response = await _typeChildrenService.update(typeid, body);
    if (response.statusCode == 200)
      _typeChildrenViewContract.onEditSuccess(response, context: context);
    else
      _typeChildrenViewContract.onErrorRequest(response);
  }

  void delete(BuildContext context, int typeid, String name) {
    showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
        title: BaseText.confirmTitle,
        message: BaseText.deleteConfirmDatatable(field: name),
        onPressed: (_, value) async {
          if (value == ConfirmDialogOption.YES_OPTION) {
            Response response = await _typeChildrenService.destroy(typeid);
            if (response.statusCode == 200)
              _typeChildrenViewContract.onDeleteSuccess(response,
                  context: context);
            else
              _typeChildrenViewContract.onErrorRequest(response);
          } else {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
