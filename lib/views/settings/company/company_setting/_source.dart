import 'package:boilerplate/models/settings/stbptype_model.dart';
import 'package:get/get.dart';

import '../../../../models/masters/type_model.dart';

class CompanySources extends GetxController {
  var typeid = 0.obs;
  var stbp = <StbptypeModel>[].obs;
  var type = TypeModel().obs;
}
