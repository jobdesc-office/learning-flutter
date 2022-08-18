import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/base_text.dart';
import '../../contracts/base/details_view_contract.dart';
import '../../contracts/base/edit_view_contract.dart';
import '../../contracts/base/index_view_contract.dart';
import '../../models/masters/type_model.dart';
import '../../services/masters/type_service.dart';
import '../../services/security/permission_service.dart';
import '../../utils/custom_get_controller.dart';
import '../../views/settings/permission/menu/permission_menu.dart';
import '../../widgets/confirm_dialog.dart';

class PermissionPresenter extends CustomGetXController {
  final _PermissionService = Get.find<PermissionService>();
  final _typeService = Get.put(TypeService());

  late IndexViewContract _PermissionViewContract;
  set PermissionViewContract(IndexViewContract PermissionViewContract) {
    _PermissionViewContract = PermissionViewContract;
  }

  late IndexViewContract _PermissionViewMenuContract;
  set PermissionViewMenuContract(IndexViewContract PermissionViewMenuContract) {
    _PermissionViewMenuContract = PermissionViewMenuContract;
  }

  late IndexViewContract _PermissionViewFeaturesContract;
  set PermissionViewFeaturesContract(
      IndexViewContract PermissionViewFeaturesContract) {
    _PermissionViewFeaturesContract = PermissionViewFeaturesContract;
  }

  late EditViewContract _PermissionFetchDataContract;
  set PermissionFetchDataContract(
      EditViewContract PermissionFetchDataContract) {
    _PermissionFetchDataContract = PermissionFetchDataContract;
  }

  void menu(BuildContext context, int roleid) async {
    showDialog(
      context: context,
      builder: (context) => PermissionMenuView(
        roleid: roleid,
      ),
    );
  }

  Future datatables(BuildContext context) async {
    Response response = await _typeService.getAllRoles();
    if (response.statusCode == 200)
      _PermissionViewContract.onLoadDatatables(context, response);
    else
      _PermissionViewContract.onErrorRequest(response);
  }

  Future datatablesMenu(BuildContext context, int roleid) async {
    Response response = await _PermissionService.menu(roleid);
    if (response.statusCode == 200)
      _PermissionViewMenuContract.onLoadDatatables(context, response);
    else
      _PermissionViewMenuContract.onErrorRequest(response);
  }

  Future permission(BuildContext context, int roleid, int menuid) async {
    Response response = await _PermissionService.permission(roleid, menuid);
    if (response.statusCode == 200)
      _PermissionViewFeaturesContract.onLoadDatatables(context, response);
    else
      _PermissionViewFeaturesContract.onErrorRequest(response);
  }

  void update(BuildContext context, Map<String, dynamic> body, int id) async {
    setProcessing(true);
    Response response = await _PermissionService.update(id, body);
    if (response.statusCode == 200)
      _PermissionViewMenuContract.onEditSuccess(response, context: context);
    else
      _PermissionViewMenuContract.onErrorRequest(response);
  }
}
