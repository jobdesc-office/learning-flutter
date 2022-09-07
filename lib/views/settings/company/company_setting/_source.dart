import 'package:boilerplate/models/settings/stbptype_model.dart';
import 'package:get/get.dart';

import '../../../../models/masters/type_model.dart';

class CompanySources extends GetxController {
  var activitycategorytypeid = 0.obs;
  var activitytypetypeid = 0.obs;

  var stbpactivitycategory = <StbptypeModel>[].obs;
  var stbpactivitytype = <StbptypeModel>[].obs;
  var type = TypeModel().obs;
}
