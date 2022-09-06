import 'package:boilerplate/views/settings/company/company_setting/company_presenter.dart';
import 'package:get/get.dart';

import '../presenters/default/home_presenter.dart';
import '../presenters/default/profile_presenter.dart';
import '../presenters/masters/businesspartner_presenter.dart';
import '../presenters/masters/city_presenter.dart';
import '../presenters/masters/contact_presenter.dart';
import '../presenters/masters/country_presenter.dart';
import '../presenters/masters/customer_presenter.dart';
import '../presenters/masters/feature_presenter.dart';
import '../presenters/masters/menu_presenter.dart';
import '../presenters/masters/product_presenter.dart';
import '../presenters/masters/province_presenter.dart';
import '../presenters/masters/subdistrict_presenter.dart';
import '../presenters/masters/village_presenter.dart';
import '../presenters/settings/file_presenter.dart';
import '../presenters/settings/permission_presenter.dart';
import '../presenters/ventes/bpcustomer_presenter.dart';
import '../presenters/ventes/competitor_presenter.dart';
import '../presenters/settings/customfield_presenter.dart';
import '../presenters/ventes/prospect_presenter.dart';
import '../presenters/ventes/prospectassign_presenter.dart';
import '../presenters/ventes/prospectactivity_presenter.dart';
import '../presenters/ventes/prospectcontact_presenter.dart';
import '../presenters/ventes/prospectcustomfield_presenter.dart';
import '../presenters/ventes/prospectfile_presenter.dart';
import '../presenters/ventes/prospectproduct_presenter.dart';
import '../presenters/ventes/report_presenter.dart';
import '../presenters/ventes/schedule_presenter.dart';
import '../presenters/masters/typechildren_presenter.dart';
import '../presenters/masters/typeparent_presenter.dart';
import '../presenters/masters/user_presenter.dart';
import '../services/default/home_service.dart';
import '../services/default/profile_service.dart';
import '../services/masters/businesspartner_service.dart';
import '../services/masters/city_service.dart';
import '../services/masters/contact_service.dart';
import '../services/masters/country_service.dart';
import '../services/masters/customer_service.dart';
import '../services/masters/product_service.dart';
import '../services/masters/province_service.dart';
import '../services/masters/subdistrict_service.dart';
import '../services/masters/village_service.dart';
import '../services/security/feature_service.dart';
import '../services/security/permission_service.dart';
import '../services/settings/file_service.dart';
import '../services/ventes/bpcustomer_service.dart';
import '../services/ventes/competitor_service.dart';
import '../services/settings/customfield_service.dart';
import '../services/ventes/prospect_service.dart';
import '../services/ventes/prospectassign_service.dart';
import '../services/ventes/prospectactivity_service.dart';
import '../services/ventes/prospectcustomfield_service.dart';
import '../services/ventes/prospectproduct_service.dart';
import '../services/ventes/report_service.dart';
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
import '../views/masters/contact/contact.dart';
import '../views/masters/countries/country.dart';
import '../views/masters/customers/customer.dart';
import '../views/masters/menus/menu.dart';
import '../views/masters/product/product.dart';
import '../views/masters/provinces/province.dart';
import '../views/masters/subdistricts/subdistrict.dart';
import '../views/masters/villages/village.dart';
import '../views/settings/company/company_setting/company.dart';
import '../views/settings/company/data_field/datafield.dart';
import '../views/settings/customfield/customfield.dart';
import '../views/settings/files/file.dart';
import '../views/settings/permission/role/permission_role.dart';
import '../views/ventes/bpcustomers/bpcustomer.dart';
import '../views/ventes/competitor/competitor.dart';
import '../views/ventes/prospect/prospect.dart';
import '../views/ventes/reports/report.dart';
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
          Get.lazyPut(() => ScheduleService());
          Get.lazyPut(() => SchedulePresenter());
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
          Get.lazyPut(() => FeatureService());
          Get.lazyPut(() => FeaturePresenter());
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
        name: RouteList.masterCustomer.index,
        page: () => CustomerView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ProvinceService());
          Get.lazyPut(() => CityService());
          Get.lazyPut(() => SubdistrictService());
          Get.lazyPut(() => VillageService());
          Get.lazyPut(() => CustomerService());
          Get.lazyPut(() => CustomerPresenter());
        }),
      ),
      CustomGetPage(
        name: RouteList.masterContact.index,
        page: () => ContactView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => CustomerService());
          Get.lazyPut(() => TypeService());
          Get.lazyPut(() => ContactService());
          Get.lazyPut(() => ContactPresenter());
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
        name: RouteList.masterProduct.index,
        page: () => ProductView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => UserService());
          Get.lazyPut(() => ProductService());
          Get.lazyPut(() => ProductPresenter());
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
      CustomGetPage(
        name: RouteList.masterVillage.index,
        page: () => VillageView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => SubdistrictService());
          Get.lazyPut(() => SubdistrictPresenter());
          Get.lazyPut(() => VillageService());
          Get.lazyPut(() => VillagePresenter());
        }),
      ),

      /** Venteses **/

      CustomGetPage(
        name: RouteList.ventesSchedule.index,
        page: () => ScheduleView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ProspectService());
          Get.lazyPut(() => ScheduleService());
          Get.lazyPut(() => SchedulePresenter());
          Get.lazyPut(() => TypeChildrenService());
          Get.lazyPut(() => UserService());
        }),
      ),
      CustomGetPage(
        name: RouteList.ventesReport.index,
        page: () => ReportView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ReportService());
          Get.lazyPut(() => ReportPresenter());
        }),
      ),
      CustomGetPage(
        name: RouteList.ventesProspect.index,
        page: () => AuthGuard(child: ProspectView()),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => VillageService());
          Get.lazyPut(() => SubdistrictService());
          Get.lazyPut(() => CityService());
          Get.lazyPut(() => ProvinceService());
          Get.lazyPut(() => UserService());
          Get.lazyPut(() => CustomerService());
          Get.lazyPut(() => ProductService());
          Get.lazyPut(() => ProspectService());
          Get.lazyPut(() => ProspectActivityService());
          Get.lazyPut(() => ProspectActivityPresenter());
          Get.lazyPut(() => FileService());
          Get.lazyPut(() => ProspectFilePresenter());
          Get.lazyPut(() => ProspectAssignService());
          Get.lazyPut(() => ProspectAssignPresenter());
          Get.lazyPut(() => CustomerPresenter());
          Get.lazyPut(() => ContactService());
          Get.lazyPut(() => ProspectContactPresenter());
          Get.lazyPut(() => CustomFieldService());
          Get.lazyPut(() => CustomFieldPresenter());
          Get.lazyPut(() => ProspectProductService());
          Get.lazyPut(() => ProspectProductPresenter());
          Get.lazyPut(() => ProspectCustomFieldService());
          Get.lazyPut(() => ProspectCustomFieldPresenter());
        }),
      ),
      CustomGetPage(
        name: RouteList.ventesBpCustomer.index,
        page: () => BpCustomerView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ProvinceService());
          Get.lazyPut(() => CityService());
          Get.lazyPut(() => SubdistrictService());
          Get.lazyPut(() => VillageService());
          Get.lazyPut(() => UserService());
          Get.lazyPut(() => CustomerService());
          Get.lazyPut(() => BpCustomerService());
          Get.lazyPut(() => BpCustomerPresenter());
          Get.lazyPut(() => CustomerService());
          Get.lazyPut(() => CustomerPresenter());
        }),
      ),
      CustomGetPage(
        name: RouteList.ventesCompetitor.index,
        page: () => CompetitorView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => CompetitorService());
          Get.lazyPut(() => CompetitorPresenter());
        }),
      ),

      /** Settings **/
      CustomGetPage(
        name: RouteList.settingsCustomField.index,
        page: () => CustomFieldView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ProspectService());
          Get.lazyPut(() => ProspectPresenter());
          Get.lazyPut(() => CustomFieldService());
          Get.lazyPut(() => CustomFieldPresenter());
        }),
      ),
      CustomGetPage(
        name: RouteList.settingsFiles.index,
        page: () => FileView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => FileService());
          Get.lazyPut(() => FilePresenter());
        }),
      ),
      CustomGetPage(
        name: RouteList.settingsPermission.index,
        page: () => PermissionRoleView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => PermissionService());
          Get.lazyPut(() => PermissionPresenter());
        }),
      ),
      CustomGetPage(
        name: RouteList.settingsCompany.index,
        page: () => CompanyView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => CompanyPresenter());
          Get.lazyPut(() => BusinessPartnerService());
        }),
      ),
      CustomGetPage(
        name: RouteList.settingsDataField.index,
        page: () => DataFieldView(),
        // binding: BindingsBuilder(() {
        //   Get.lazyPut(() => FileService());
        //   Get.lazyPut(() => FilePresenter());
        // }),
      ),
    ];
  }
}
