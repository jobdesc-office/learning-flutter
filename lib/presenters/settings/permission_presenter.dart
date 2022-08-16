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
import '../../widgets/confirm_dialog.dart';

class PermissionPresenter extends CustomGetXController {
  final _PermissionService = Get.find<PermissionService>();
  final _typeService = Get.put(TypeService());

  late IndexViewContract _PermissionViewContract;
  set PermissionViewContract(IndexViewContract PermissionViewContract) {
    _PermissionViewContract = PermissionViewContract;
  }

  late EditViewContract _PermissionFetchDataContract;
  set PermissionFetchDataContract(
      EditViewContract PermissionFetchDataContract) {
    _PermissionFetchDataContract = PermissionFetchDataContract;
  }

  Future datatables(BuildContext context) async {
    Response response = await _typeService.getAllRoles();
    if (response.statusCode == 200)
      _PermissionViewContract.onLoadDatatables(context, response);
    else
      _PermissionViewContract.onErrorRequest(response);
  }
}
