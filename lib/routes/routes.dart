import 'package:get/get.dart';

import '../presenters/masters/menu_presenter.dart';
import '../services/security/menu_service.dart';
import '../utils/custom_get_page.dart';
import '../utils/guards/auth_guard.dart';
import '../utils/guards/guest_guard.dart';
import '../views/defaults/home.dart';
import '../views/masters/menus/menu.dart';
import '../views/signin/signin.dart';

import 'route_list.dart';

class AppRoute {
  static List<GetPage> get routes {
    return [
      CustomGetPage(
        name: RouteList.sigin.index,
        page: () => GuestGuard(child: SignInView()),
      ),
      CustomGetPage(
        name: RouteList.home.index,
        page: () => AuthGuard(child: HomeView()),
      ),
      CustomGetPage(
        name: RouteList.masterMenu.index,
        page: () => MenuView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => MenuService());
          Get.lazyPut(() => MenuPresenter());
        }),
      ),
    ];
  }
}
