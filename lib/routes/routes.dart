import 'package:get/get.dart';

import '../middleware/auth_middleware.dart';
import '../middleware/guest_middleware.dart';
import '../utils/guards/auth_guard.dart';
import '../utils/guards/guest_guard.dart';
import '../views/defaults/home.dart';
import '../views/masters/menus/menu.dart';
import '../views/signin/signin.dart';

import 'route_list.dart';

class AppRoute {
  static List<GetPage> get routes {
    return [
      GetPage(
        name: RouteList.sigin.index,
        page: () => GuardGuest(child: SignInView()),
        middlewares: [GuestMiddleware()],
      ),
      GetPage(
        name: RouteList.home.index,
        page: () => GuardAuth(child: HomeView()),
        transition: Transition.noTransition,
        middlewares: [AuthMiddleware()],
      ),
      GetPage(
        name: RouteList.masterMenu.index,
        page: () => GuardAuth(child: MenuView()),
        transition: Transition.noTransition,
        middlewares: [AuthMiddleware()],
      ),
    ];
  }
}
