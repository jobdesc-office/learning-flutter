import 'package:get/get.dart';

import '../presenters/default/home_presenter.dart';
import '../presenters/default/profile_presenter.dart';
import '../presenters/masters/businesspartner_presenter.dart';
import '../presenters/masters/city_presenter.dart';
import '../presenters/masters/country_presenter.dart';
import '../presenters/masters/menu_presenter.dart';
import '../presenters/masters/province_presenter.dart';
import '../presenters/masters/subdistrict_presenter.dart';
import '../presenters/ventes/schedule_presenter.dart';
import '../presenters/masters/typechildren_presenter.dart';
import '../presenters/masters/typeparent_presenter.dart';
import '../presenters/masters/user_presenter.dart';
import '../services/default/home_service.dart';
import '../services/default/profile_service.dart';
import '../services/masters/businessPartner_service.dart';
import '../services/masters/city_service.dart';
import '../services/masters/country_service.dart';
import '../services/masters/province_service.dart';
import '../services/masters/subdistrict_service.dart';
import '../services/ventes/schedule_service.dart';
import '../services/masters/type_service.dart';
import '../services/masters/typechildren_service.dart';
import '../services/masters/user_service.dart';
import '../services/security/menu_service.dart';
import '../utils/custom_get_page.dart';
import '../utils/guards/auth_guard.dart';
import '../utils/guards/guest_guard.dart';
import '../views/defaults/home/home.dart';
import '../views/defaults/profile/profile.dart';
import '../views/masters/businesspartners/businesspartner.dart';
import '../views/masters/cities/city.dart';
import '../views/masters/countries/country.dart';
import '../views/masters/menus/menu.dart';
import '../views/masters/provinces/province.dart';
import '../views/masters/subdistricts/subdistrict.dart';
import '../views/ventes/prospect/prospect.dart';
import '../views/ventes/schedules/schedule.dart';
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
        binding: BindingsBuilder(() {
          Get.lazyPut(() => HomeService());
          Get.lazyPut(() => HomePresenter());
        }),
      ),
      CustomGetPage(
        name: RouteList.profile.index,
        page: () => ProfileView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ProfileService());
          Get.lazyPut(() => ProfilePresenter());
          Get.lazyPut(() => UserService());
          Get.lazyPut(() => UserPresenter());
        }),
      ),

      /** Masters **/

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
      CustomGetPage(
        name: RouteList.masterCountry.index,
        page: () => CountryView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => CountryService());
          Get.lazyPut(() => CountryPresenter());
        }),
      ),
      CustomGetPage(
        name: RouteList.masterProvince.index,
        page: () => ProvinceView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => CountryService());
          Get.lazyPut(() => ProvinceService());
          Get.lazyPut(() => ProvincePresenter());
        }),
      ),
      CustomGetPage(
        name: RouteList.masterCity.index,
        page: () => CityView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ProvinceService());
          Get.lazyPut(() => CityService());
          Get.lazyPut(() => CityPresenter());
        }),
      ),
      CustomGetPage(
        name: RouteList.masterSubdistrict.index,
        page: () => SubdistrictView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ProvinceService());
          Get.lazyPut(() => CityService());
          Get.lazyPut(() => SubdistrictService());
          Get.lazyPut(() => SubdistrictPresenter());
        }),
      ),

      /** Venteses **/

      CustomGetPage(
        name: RouteList.ventesSchedule.index,
        page: () => ScheduleView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ScheduleService());
          Get.lazyPut(() => SchedulePresenter());
          Get.lazyPut(() => TypeChildrenService());
          Get.lazyPut(() => UserService());
        }),
      ),
      CustomGetPage(
        name: RouteList.ventesProspect.index,
        page: () => ProspectView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => TypeService());
          Get.lazyPut(() => MenuService());
          Get.lazyPut(() => MenuPresenter());
        }),
      ),
    ];
  }
}
