import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../contracts/base/index_view_contract.dart';
import '../../services/masters/type_service.dart';
import '../../services/security/permission_service.dart';
import '../../utils/custom_get_controller.dart';
import '../../views/settings/permission/menu/permission_menu.dart';

class PermissionPresenter extends CustomGetXController {
  final _permissionService = Get.find<PermissionService>();
  final _typeService = Get.put(TypeService());

  late IndexViewContract _permissionViewContract;
  set permissionViewContract(IndexViewContract permissionViewContract) {
    _permissionViewContract = permissionViewContract;
  }

  late IndexViewContract _permissionViewMenuContract;
  set permissionViewMenuContract(IndexViewContract permissionViewMenuContract) {
    _permissionViewMenuContract = permissionViewMenuContract;
  }

  void menu(BuildContext context, int roleid, String rolename) async {
    showDialog(
      context: context,
      builder: (context) => PermissionMenuView(
        roleid: roleid,
        rolename: rolename,
      ),
    );
  }

  Future datatables(BuildContext context) async {
    Response response = await _typeService.getAllRoles();
    if (response.statusCode == 200)
      _permissionViewContract.onLoadDatatables(context, response);
    else
      _permissionViewContract.onErrorRequest(response);
  }

  Future datatablesMenu(BuildContext context, int roleid) async {
    Response response = await _permissionService.menu(roleid);
    if (response.statusCode == 200)
      _permissionViewMenuContract.onLoadDatatables(context, response);
    else
      _permissionViewMenuContract.onErrorRequest(response);
  }

  void update(BuildContext context, Map<String, dynamic> body, int id) async {
    setProcessing(true);
    Response response = await _permissionService.update(id, body);
    if (response.statusCode == 200)
      _permissionViewMenuContract.onEditSuccess(response, context: context);
    else
      _permissionViewMenuContract.onErrorRequest(response);
  }

  void updateTabs(BuildContext context, Map<String, dynamic> body) async {
    setProcessing(true);
    Response response = await _permissionService.updateTab(body);
    if (response.statusCode == 200)
      _permissionViewMenuContract.onEditSuccess(response, context: context);
    else
      _permissionViewMenuContract.onErrorRequest(response);
  }
}
