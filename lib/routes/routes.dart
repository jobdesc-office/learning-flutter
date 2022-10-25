import 'package:boilerplate/views/settings/company/company_setting/tabs/tabContacts/cp_contact_presenter.dart';
import 'package:boilerplate/views/settings/company/company_setting/tabs/tabCustomers/cp_customer_presenter.dart';
import 'package:boilerplate/views/settings/company/company_setting/tabs/tabGeneral/cp_general_presenter.dart';
import 'package:get/get.dart';

import '../presenters/default/home_presenter.dart';
import '../presenters/default/information_presenter.dart';
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
import '../presenters/masters/role_presenter.dart';
import '../presenters/masters/subdistrict_presenter.dart';
import '../presenters/masters/village_presenter.dart';
import '../presenters/settings/file_presenter.dart';
import '../presenters/settings/permission_presenter.dart';
import '../presenters/settings/stbptype/stbptypeactivitycategory_presenter.dart';
import '../presenters/settings/stbptype/stbptypeactivitytype_presenter.dart';
import '../presenters/settings/stbptype/stbptypecontacttype_presenter.dart';
import '../presenters/settings/stbptype/stbptypecustomertype_presenter.dart';
import '../presenters/settings/stbptype/stbptypeprospectcategory_presenter.dart';
import '../presenters/settings/stbptype/stbptypeprospectcustomerlabel_presenter.dart';
import '../presenters/settings/stbptype/stbptypeprospectlostreason_presenter.dart';
import '../presenters/settings/stbptype/stbptypeprospectstage_presenter.dart';
import '../presenters/settings/stbptype/stbptypeprospectstatus_presenter.dart';
import '../presenters/settings/stbptype/stbptypeprospecttype_presenter.dart';
import '../presenters/settings/stbptype/stbptypescheduletype_presenter.dart';
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
import '../services/default/info_service.dart';
import '../services/default/profile_service.dart';
import '../services/masters/businesspartner_service.dart';
import '../services/masters/city_service.dart';
import '../services/masters/contact_service.dart';
import '../services/masters/country_service.dart';
import '../services/masters/customer_service.dart';
import '../services/masters/product_service.dart';
import '../services/masters/province_service.dart';
import '../services/masters/stbptype_service.dart';
import '../services/masters/subdistrict_service.dart';
import '../services/masters/village_service.dart';
import '../services/security/feature_service.dart';
import '../services/security/permission_service.dart';
import '../services/settings/file_service.dart';
import '../services/ventes/attendance_service.dart';
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
import '../views/defaults/informations/info.dart';
import '../views/defaults/profile/profile.dart';
import '../views/masters/businesspartners/businesspartner.dart';
import '../views/masters/cities/city.dart';
import '../views/masters/contact/contact.dart';
import '../views/masters/countries/country.dart';
import '../views/masters/customers/customer.dart';
import '../views/masters/menus/menu.dart';
import '../views/masters/provinces/province.dart';
import '../views/masters/role/role.dart';
import '../views/masters/subdistricts/subdistrict.dart';
import '../views/masters/villages/village.dart';
import '../views/settings/company/company_setting/_source.dart';
import '../views/settings/company/company_setting/company.dart';
import '../views/settings/company/company_setting/tabs/tabCustomizeField_source/customfield_presenter.dart';
import '../views/settings/files/file.dart';
import '../views/settings/permission/role/permission_role.dart';
import '../views/ventes/bpcustomers/bpcustomer.dart';
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
        page: () => AuthGuard(
          child: HomeView(),
          route: '/',
          parent: 'Insight',
        ),
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
        page: () => AuthGuard(
          child: UserView(),
          parent: 'Master Datas',
          route: '/masters/user',
        ),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => UserService());
          Get.lazyPut(() => UserPresenter());
        }),
      ),
      CustomGetPage(
        name: RouteList.masterCustomer.index,
        page: () => AuthGuard(
          child: CustomerView(),
          parent: 'Master Datas',
          parent2: 'Customers',
          route: '/masters/customer',
        ),
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
        page: () => AuthGuard(
          child: ContactView(),
          parent: 'Master Datas',
          parent2: 'Customers',
          route: '/masters/contact',
        ),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => CustomerService());
          Get.lazyPut(() => TypeService());
          Get.lazyPut(() => ContactService());
          Get.lazyPut(() => ContactPresenter());
        }),
      ),
      CustomGetPage(
        name: RouteList.masterBusinessPartner.index,
        page: () => AuthGuard(
          child: BusinessPartnerView(),
          parent: 'Master Datas',
          route: '/masters/businesspartner',
        ),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => BusinessPartnerService());
          Get.lazyPut(() => BusinessPartnerPresenter());
        }),
      ),
      CustomGetPage(
        name: RouteList.masterRole.index,
        page: () => AuthGuard(
          child: RoleView(),
          parent: 'Master Datas',
          route: '/masters/role',
        ),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => TypeChildrenService());
          Get.lazyPut(() => TypeService());
          Get.lazyPut(() => RolePresenter());
        }),
      ),
      // CustomGetPage(
      //   name: RouteList.masterProduct.index,
      //   page: () => ProductView(),
      //   binding: BindingsBuilder(() {
      //     Get.lazyPut(() => UserService());
      //     Get.lazyPut(() => ProductService());
      //     Get.lazyPut(() => ProductPresenter());
      //   }),
      // ),
      CustomGetPage(
        name: RouteList.masterTypeParent.index,
        page: () => AuthGuard(
          child: TypesParentView(),
          parent: 'Settings',
          parent2: 'Types',
          route: '/masters/typeparent',
        ),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => TypeService());
          Get.lazyPut(() => TypeParentPresenter());
        }),
      ),
      CustomGetPage(
        name: RouteList.masterTypeChildren.index,
        page: () => AuthGuard(
          child: TypesChildrenView(),
          parent: 'Settings',
          parent2: 'Types',
          route: '/masters/typechildren',
        ),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => TypeChildrenService());
          Get.lazyPut(() => TypesChildrenPresenter());
        }),
      ),
      CustomGetPage(
        name: RouteList.masterCountry.index,
        page: () => AuthGuard(
          child: CountryView(),
          parent: 'Settings',
          parent2: 'Regions',
          route: '/masters/country',
        ),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => CountryService());
          Get.lazyPut(() => CountryPresenter());
        }),
      ),
      CustomGetPage(
        name: RouteList.masterProvince.index,
        page: () => AuthGuard(
          child: ProvinceView(),
          parent: 'Settings',
          parent2: 'Regions',
          route: '/masters/province',
        ),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => CountryService());
          Get.lazyPut(() => ProvinceService());
          Get.lazyPut(() => ProvincePresenter());
        }),
      ),
      CustomGetPage(
        name: RouteList.masterCity.index,
        page: () => AuthGuard(
          child: CityView(),
          parent: 'Settings',
          parent2: 'Regions',
          route: '/masters/city',
        ),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ProvinceService());
          Get.lazyPut(() => CityService());
          Get.lazyPut(() => CityPresenter());
        }),
      ),
      CustomGetPage(
        name: RouteList.masterSubdistrict.index,
        page: () => AuthGuard(
          child: SubdistrictView(),
          parent: 'Settings',
          parent2: 'Regions',
          route: '/masters/subdistrict',
        ),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ProvinceService());
          Get.lazyPut(() => CityService());
          Get.lazyPut(() => SubdistrictService());
          Get.lazyPut(() => SubdistrictPresenter());
        }),
      ),
      CustomGetPage(
        name: RouteList.masterVillage.index,
        page: () => AuthGuard(
          child: VillageView(),
          parent: 'Settings',
          parent2: 'Regions',
          route: '/masters/village',
        ),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => SubdistrictService());
          Get.lazyPut(() => SubdistrictPresenter());
          Get.lazyPut(() => VillageService());
          Get.lazyPut(() => VillagePresenter());
        }),
      ),

      /** Ventes **/

      CustomGetPage(
        name: RouteList.ventesSchedule.index,
        page: () => AuthGuard(
          child: ScheduleView(),
          parent: 'Ventes Datas',
          route: '/ventes/schedule',
        ),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ProspectService());
          Get.lazyPut(() => ScheduleService());
          Get.lazyPut(() => SchedulePresenter());
          Get.lazyPut(() => TypeChildrenService());
          Get.lazyPut(() => UserService());
          Get.lazyPut(() => ReportService());
        }),
      ),
      CustomGetPage(
        name: RouteList.ventesReport.index,
        page: () => AuthGuard(
          child: ReportView(),
          parent: 'Ventes Datas',
          route: '/ventes/report',
        ),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ReportService());
          Get.lazyPut(() => AttendanceService());
          Get.lazyPut(() => ReportPresenter());
          Get.lazyPut(() => ProspectService());
        }),
      ),
      CustomGetPage(
        name: RouteList.ventesProspect.index,
        page: () => AuthGuard(
          child: ProspectView(),
          parent: 'Ventes Datas',
          route: '/ventes/prospect',
        ),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => VillageService());
          Get.lazyPut(() => SubdistrictService());
          Get.lazyPut(() => CityService());
          Get.lazyPut(() => ProvinceService());
          Get.lazyPut(() => UserService());
          Get.lazyPut(() => CustomerService());
          Get.lazyPut(() => ProductService());
          Get.lazyPut(() => ProductPresenter());
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
        page: () => AuthGuard(
          child: BpCustomerView(),
          parent: 'Masters Datas',
          route: '/ventes/bpcustomer',
        ),
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
      // CustomGetPage(
      //   name: RouteList.ventesCompetitor.index,
      //   page: () => AuthGuard(child: CompetitorView(), route: '',),
      //   binding: BindingsBuilder(() {
      //     Get.lazyPut(() => CompetitorService());
      //     Get.lazyPut(() => CompetitorPresenter());
      //   }),
      // ),

      /** Settings **/
      // CustomGetPage(
      //   name: RouteList.settingsCustomField.index,
      //   page: () => CustomFieldView(),
      //   binding: BindingsBuilder(() {
      //     Get.lazyPut(() => ProspectService());
      //     Get.lazyPut(() => ProspectPresenter());
      //     Get.lazyPut(() => CustomFieldService());
      //     Get.lazyPut(() => CustomFieldPresenter());
      //   }),
      // ),
      CustomGetPage(
        name: RouteList.settingsFiles.index,
        page: () => AuthGuard(
          child: FileView(),
          parent: 'Settings',
          route: '/settings/files',
        ),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => FileService());
          Get.lazyPut(() => FilePresenter());
        }),
      ),
      CustomGetPage(
        name: RouteList.settingsPermission.index,
        page: () =>
            // AuthGuard(
            //   child:
            PermissionRoleView(),
        //   parent: 'Settings',
        //   route: '/settings/permission',
        // ),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => PermissionService());
          Get.lazyPut(() => PermissionPresenter());
        }),
      ),
      CustomGetPage(
        name: RouteList.settingsInformation.index,
        page: () => AuthGuard(
          child: InformationView(),
          parent: 'Settings',
          route: '/settings/information',
        ),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => InfoService());
          Get.lazyPut(() => InformationPresenter());
        }),
      ),
      CustomGetPage(
        name: RouteList.settingsCompany.index,
        page: () => AuthGuard(
          child: CompanyView(),
          parent: 'Settings',
          // parent2: 'Company',
          route: '/settings/company',
        ),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => CompanySources());
          Get.lazyPut(() => CPGeneralPresenter());
          Get.lazyPut(() => CPCustomerPresenter());
          Get.lazyPut(() => CPContactPresenter());
          Get.lazyPut(() => BusinessPartnerService());
          Get.lazyPut(() => BpCustomerService());
          Get.lazyPut(() => CustomerService());
          Get.lazyPut(() => StBpTypeService());
          Get.lazyPut(() => StBpTypeActivityCategoryPresenter());
          Get.lazyPut(() => StBpTypeActivityTypePresenter());
          Get.lazyPut(() => StBpTypeProspectCategoryPresenter());
          Get.lazyPut(() => StBpTypeProspectCustomerLabelPresenter());
          Get.lazyPut(() => StBpTypeProspectLostReasonPresenter());
          Get.lazyPut(() => StBpTypeProspectTypePresenter());
          Get.lazyPut(() => StBpTypeProspectStagePresenter());
          Get.lazyPut(() => StBpTypeProspectStatusPresenter());
          Get.lazyPut(() => StBpTypeScheduleTypePresenter());
          Get.lazyPut(() => StBpTypeCustomerTypePresenter());
          Get.lazyPut(() => StBpTypeContactTypePresenter());
          Get.lazyPut(() => TypeService());
          Get.lazyPut(() => ContactService());
          Get.lazyPut(() => CompetitorPresenter());
          Get.lazyPut(() => CompetitorService());
          Get.lazyPut(() => UserPresenter());
          Get.lazyPut(() => UserService());
          Get.lazyPut(() => BpCustomerPresenter());
          Get.lazyPut(() => BpCustomerService());
          Get.lazyPut(() => CustomerPresenter());
          Get.lazyPut(() => CustomerService());
          Get.lazyPut(() => VillageService());
          Get.lazyPut(() => SubdistrictService());
          Get.lazyPut(() => CityService());
          Get.lazyPut(() => ProvinceService());
          Get.lazyPut(() => ProspectPresenter());
          Get.lazyPut(() => ProspectService());
          Get.lazyPut(() => ProductPresenter());
          Get.lazyPut(() => ProductService());
          Get.lazyPut(() => ProspectPresenter());
          Get.lazyPut(() => ProspectService());
          Get.lazyPut(() => TypesChildrenPresenter());
          Get.lazyPut(() => TypeChildrenService());
          Get.lazyPut(() => CustomFieldsPresenter());
          Get.lazyPut(() => CustomFieldPresenter());
          Get.lazyPut(() => CustomFieldService());
          Get.lazyPut(() => ReportPresenter());
          Get.lazyPut(() => ReportService());
        }),
      ),
    ];
  }
}
