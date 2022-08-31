import 'package:boilerplate/models/masters/type_model.dart';
import 'package:get/get.dart';

import '../../../models/security/permission_model.dart';

class PermissionSource extends GetxController {
  var rolename = ''.obs;

  var menuname = ''.obs;

  var role = <TypeModel>[].obs;
  var permission = <PermissionModel>[].obs;

  @override
  void onClose() {
    rolename.value = '';
    menuname.value = '';
    role.value = [];
    super.onClose();
  }
}
