import '../models/route_data.dart';

class RouteList {
  static final RouteData sigin = RouteData(prefix: '/auth/sigin');

  static final RouteData home = RouteData(prefix: '/');

  static final RouteData master = RouteData(prefix: '/-master');

  static final RouteData masterMenu = RouteData(prefix: '/masters/menus');
  static final RouteData masterProduct = RouteData(prefix: '/masters/product');

  static final RouteData settings = RouteData(prefix: '/-settings');

  static final RouteData settingsPrevileges =
      RouteData(prefix: '/settings/previleges');
  static final RouteData settingsUser = RouteData(prefix: '/settings/users');
}
