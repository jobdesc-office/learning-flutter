import '../helpers/function.dart';

class ConfigType {
  static Map<String, dynamic> types = Map<String, dynamic>();

  static String menuType = notNull(types['menuType']);
  static String menuTypeWeb = notNull(types['web']);
  static String menuTypeApp = notNull(types['apps']);

  static String role = notNull(types['role']);
  static String appaccess = notNull(types['appaccess']);
  static String webaccess = notNull(types['webaccess']);
  static String allaccess = notNull(types['allaccess']);
  static String accesses = notNull(types['accesses']);

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

  static String prospectCustomizeField = notNull(types['customizeField']);

  static String prospectCustomField = notNull(types['prospectCustomField']);

  static String activityCustomField = notNull(types['activityCustomField']);
  static String scheduleCustomField = notNull(types['scheduleCustomField']);

  static String prospectStatus = notNull(types['prospectStatus']);

  static String prospectCategory = notNull(types['prospectCategory']);

  static String contactType = notNull(types['contactType']);

  static String cstmtype = notNull(types['cstmtype']);

  static String cstmstatus = notNull(types['cstmstatus']);

  static String activitytype = notNull(types['activitytype']);

  static String activitycategory = notNull(types['activitycategory']);

  static String chatreftype = notNull(types['chatreftype']);

  static String attpresent = notNull(types['attendancePresent']);
  static String attool = notNull(types['attendanceOutOfLocation']);
  static String attleave = notNull(types['attendanceLeave']);
  static String attsick = notNull(types['attendanceSick']);
  static String attcuti = notNull(types['attendanceCuti']);
  static String attalpha = notNull(types['attendanceAlpha']);
}
