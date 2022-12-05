import 'package:boilerplate/models/masters/security_group_model.dart';
import 'package:boilerplate/services/masters/security_group_service.dart';
import 'package:boilerplate/views/masters/securitygroup/security_group_detail.dart';
import 'package:boilerplate/views/masters/securitygroup/security_group_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/base_text.dart';
import '../../contracts/base/details_view_contract.dart';
import '../../contracts/base/edit_view_contract.dart';
import '../../contracts/base/index_view_contract.dart';
import '../../services/masters/type_service.dart';
import '../../utils/custom_get_controller.dart';
import '../../widgets/confirm_dialog.dart';

class SecurityGroupPresenter extends CustomGetXController {
  final _securityGroupService = Get.find<SecurityGroupService>();

  late IndexViewContract _securityGroupViewContract;
  set securityGroupViewContract(IndexViewContract securityGroupViewContract) {
    _securityGroupViewContract = securityGroupViewContract;
  }

  late EditViewContract _securityGroupFetchDataContract;
  set securityGroupFetchDataContract(EditViewContract securityGroupFetchDataContract) {
    _securityGroupFetchDataContract = securityGroupFetchDataContract;
  }

  late DetailViewContract _securityGroupDataDetailsContract;
  set securityGroupDataDetailsContract(DetailViewContract securityGroupDataDetailsContract) {
    _securityGroupDataDetailsContract = securityGroupDataDetailsContract;
  }

  Future datatables(BuildContext context, Map<String, String> params) async {
    Response response = await _securityGroupService.datatable(params);
    if (response.statusCode == 200)
      _securityGroupViewContract.onLoadDatatables(context, response);
    else
      _securityGroupViewContract.onErrorRequest(response);
  }

  void details(BuildContext context, int userid, [List<SecurityGroupModel>? parents]) async {
    setProcessing(true);
    showDialog(
      context: context,
      builder: (context) => SecurityGroupDetails(parents: parents),
    );

    Response response = await _securityGroupService.show(userid);
    if (response.statusCode == 200)
      _securityGroupDataDetailsContract.onSuccessFetchData(response);
    else
      _securityGroupViewContract.onErrorRequest(response);
  }

  void add(BuildContext context, [SecurityGroupModel? parent]) async {
    showDialog(
      context: context,
      builder: (context) => SecurityGroupFormView(
        parent: parent,
        onSave: (body) => save(context, body),
      ),
    );
  }

  void save(BuildContext context, Map<String, dynamic> body) async {
    Response response = await _securityGroupService.store(body);
    if (response.statusCode == 200)
      _securityGroupViewContract.onCreateSuccess(response, context: context);
    else
      _securityGroupViewContract.onErrorRequest(response);
  }

  void edit(BuildContext context, int typeid, [SecurityGroupModel? parent]) async {
    setProcessing(true);
    showDialog(
      context: context,
      builder: (context) => SecurityGroupFormView(
        onSave: (body) => update(context, body, typeid),
        parent: parent,
      ),
    );

    Response response = await _securityGroupService.show(typeid);
    if (response.statusCode == 200)
      _securityGroupFetchDataContract.onSuccessFetchData(response);
    else
      _securityGroupViewContract.onErrorRequest(response);
  }

  void update(BuildContext context, Map<String, dynamic> body, int typeid) async {
    setProcessing(true);
    Response response = await _securityGroupService.update(typeid, body);
    if (response.statusCode == 200)
      _securityGroupViewContract.onEditSuccess(response, context: context);
    else
      _securityGroupViewContract.onErrorRequest(response);
  }

  void delete(BuildContext context, int typeid, String name) {
    showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
        title: BaseText.confirmTitle,
        message: BaseText.deleteConfirmDatatable(field: name),
        onPressed: (_, value) async {
          if (value == ConfirmDialogOption.YES_OPTION) {
            Response response = await _securityGroupService.destroy(typeid);
            if (response.statusCode == 200)
              _securityGroupViewContract.onDeleteSuccess(response, context: context);
            else
              _securityGroupViewContract.onErrorRequest(response);
          } else {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
