import 'package:boilerplate/models/masters/type_model.dart';
import 'package:get/get.dart';

class PermissionSource extends GetxController {
  var roleid = 0.obs;
  var rolename = ''.obs;

  var menuid = 0.obs;
  var menuname = ''.obs;

  var role = <TypeModel>[].obs;
}
