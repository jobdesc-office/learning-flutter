import '../models/route_data.dart';

class RouteList {
  static final RouteData sigin = RouteData(prefix: '/auth/sigin');

  static final RouteData home = RouteData(prefix: '/');

  static final RouteData profile = RouteData(prefix: '/profile');

  static final RouteData master = RouteData(prefix: '/-master');

  static final RouteData masterMenu = RouteData(prefix: '/masters/menus');
  static final RouteData masterProduct = RouteData(prefix: '/masters/product');
  static final RouteData masterUser = RouteData(prefix: '/masters/user');
  static final RouteData masterBusinessPartner =
      RouteData(prefix: '/masters/businesspartner');

  static final RouteData type = RouteData(prefix: '/-type');
  static final RouteData masterTypeParent =
      RouteData(prefix: '/masters/typeparent');
  static final RouteData masterTypeChildren =
      RouteData(prefix: '/masters/typechildren');
  static final RouteData customer = RouteData(prefix: '/-customer');
  static final RouteData masterCustomer =
      RouteData(prefix: '/masters/customer');
  static final RouteData masterCountry = RouteData(prefix: '/masters/country');
  static final RouteData masterProvince =
      RouteData(prefix: '/masters/province');
  static final RouteData masterCity = RouteData(prefix: '/masters/city');
  static final RouteData masterSubdistrict =
      RouteData(prefix: '/masters/subdistrict');
  static final RouteData masterVillage = RouteData(prefix: '/masters/village');
  static final RouteData masterContact = RouteData(prefix: '/masters/contact');

  static final RouteData ventes = RouteData(prefix: '/-ventes');

  static final RouteData ventesSchedule = RouteData(prefix: '/ventes/schedule');
  static final RouteData ventesReport = RouteData(prefix: '/ventes/report');
  static final RouteData prospect = RouteData(prefix: '/-prospect');
  static final RouteData ventesProspect = RouteData(prefix: '/ventes/prospect');
  static final RouteData ventesBpCustomer =
      RouteData(prefix: '/ventes/bpcustomer');
  static final RouteData ventesCompetitor =
      RouteData(prefix: '/ventes/competitor');

  static final RouteData settings = RouteData(prefix: '/-settings');

  static final RouteData settingsPrevileges =
      RouteData(prefix: '/settings/previleges');
  static final RouteData settingsCustomField =
      RouteData(prefix: '/settings/customfield');
  static final RouteData settingsCompany =
      RouteData(prefix: '/settings/company');
  static final RouteData settingsPermission =
      RouteData(prefix: '/settings/permission');
  static final RouteData settingsFiles = RouteData(prefix: '/settings/files');
  static final RouteData settingsUser = RouteData(prefix: '/settings/users');
}
