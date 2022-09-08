import 'package:boilerplate/models/settings/stbptype_model.dart';
import 'package:get/get.dart';

import '../../../../models/masters/type_model.dart';

class CompanySources extends GetxController {
  var activitycategorytypeid = 0.obs;
  var activitytypetypeid = 0.obs;
  var scheduletypetypeid = 0.obs;

  var prospectcategorytypeid = 0.obs;
  var prospectCustomerLabeltypeid = 0.obs;
  var prospectLostReasontypeid = 0.obs;
  var prospectTypetypeid = 0.obs;
  var prospectStagetypeid = 0.obs;
  var prospectStatustypeid = 0.obs;

  var stbpactivitycategory = <StbptypeModel>[].obs;
  var stbpactivitytype = <StbptypeModel>[].obs;

  var stbpprospectcategory = <StbptypeModel>[].obs;
  var stbpprospectcustomerlabel = <StbptypeModel>[].obs;
  var stbpprospectlostreason = <StbptypeModel>[].obs;
  var stbpprospecttype = <StbptypeModel>[].obs;
  var stbpprospectstage = <StbptypeModel>[].obs;
  var stbpprospectstatus = <StbptypeModel>[].obs;

  var stbpscheduletype = <StbptypeModel>[].obs;

  var type = TypeModel().obs;
}
