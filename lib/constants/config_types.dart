import '../helpers/function.dart';

class ConfigType {
  static Map<String, dynamic> types = Map<String, dynamic>();

  static String menuType = notNull(types['menuType']);

  static String role = notNull(types['role']);

  static String businessPartner = notNull(types['businessPartner']);

  static String schedule = notNull(types['schedule']);

  static String schedulePermission = notNull(types['schedulePermission']);

  static String scheRefType = notNull(types['scheRefType']);

  static String competitorreftype = notNull(types['competitorreftype']);

  static String taxType = notNull(types['taxType']);

  static String prospectStage = notNull(types['prospectStage']);

  static String prospectType = notNull(types['prospectType']);

  static String prospectCustLabel = notNull(types['prospectCustLabel']);

  static String prospectLostReason = notNull(types['prospectLostReason']);

  static String prospectCustomizeField =
      notNull(types['prospectCustomizeField']);

  static String prospectStatus = notNull(types['prospectStatus']);

  static String prospectCategory = notNull(types['prospectCategory']);

  static String contactType = notNull(types['contactType']);

  static String cstmtype = notNull(types['cstmtype']);

  static String cstmstatus = notNull(types['cstmstatus']);

  static String activitytype = notNull(types['activitytype']);

  static String activitycategory = notNull(types['activitycategory']);
}
