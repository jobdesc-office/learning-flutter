import 'package:get/get.dart';

import '../presenters/masters/businesspartner_presenter.dart';
import '../presenters/masters/menu_presenter.dart';
import '../presenters/masters/schedule_presenter.dart';
import '../presenters/masters/typechildren_presenter.dart';
import '../presenters/masters/typeparent_presenter.dart';
import '../presenters/masters/user_presenter.dart';
import '../services/masters/businessPartner_service.dart';
import '../services/masters/schedule_service.dart';
import '../services/masters/type_service.dart';
import '../services/masters/typechildren_service.dart';
import '../services/masters/user_service.dart';
import '../services/security/menu_service.dart';
import '../utils/custom_get_page.dart';
import '../utils/guards/auth_guard.dart';
import '../utils/guards/guest_guard.dart';
import '../views/defaults/home.dart';
import '../views/masters/businesspartners/businesspartner.dart';
import '../views/masters/menus/menu.dart';
import '../views/masters/schedules/schedule.dart';
import '../views/masters/typeschildren/types_children.dart';
import '../views/masters/typesparents/types_parents.dart';
import '../views/masters/users/user.dart';
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
      CustomGetPage(
        name: RouteList.masterUser.index,
        page: () => UserView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => UserService());
          Get.lazyPut(() => UserPresenter());
        }),
      ),
      CustomGetPage(
        name: RouteList.masterBusinessPartner.index,
        page: () => BusinessPartnerView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => BusinessPartnerService());
          Get.lazyPut(() => BusinessPartnerPresenter());
        }),
      ),
      CustomGetPage(
        name: RouteList.masterSchedule.index,
        page: () => ScheduleView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ScheduleService());
          Get.lazyPut(() => SchedulePresenter());
        }),
      ),
      CustomGetPage(
        name: RouteList.masterTypeParent.index,
        page: () => TypesParentView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => TypeService());
          Get.lazyPut(() => TypeParentPresenter());
        }),
      ),
      CustomGetPage(
        name: RouteList.masterTypeChildren.index,
        page: () => TypesChildrenView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => TypeChildrenService());
          Get.lazyPut(() => TypesChildrenPresenter());
        }),
      ),
    ];
  }
}
