import '../helpers/function.dart';

class ConfigType {
  static Map<String, dynamic> types = Map<String, dynamic>();

  static String menuType = notNull(types['menuType']);

  static String businessPartner = notNull(types['businessPartner']);

  static String schedule = notNull(types['schedule']);

  static String schedulePermission = notNull(types['schedulePermission']);

  static String taxType = notNull(types['taxType']);

  static String prospectStage = notNull(types['prospectStage']);

  static String prospectType = notNull(types['prospectType']);

  static String contactType = notNull(types['contactType']);
}
