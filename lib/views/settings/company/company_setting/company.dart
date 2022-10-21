import 'dart:convert';

import 'package:boilerplate/constants/base_text.dart';
import 'package:boilerplate/contracts/base/edit_view_contract.dart';
import 'package:boilerplate/contracts/base/index_view_contract.dart';
import 'package:boilerplate/helpers/function.dart';
import 'package:boilerplate/models/masters/businesspartner_model.dart';
import 'package:boilerplate/models/masters/contact_model.dart';
import 'package:boilerplate/utils/select_api.dart';
import 'package:boilerplate/utils/validators.dart';
import 'package:boilerplate/views/masters/contact/_text.dart';
import 'package:boilerplate/views/settings/company/company_setting/tabs/tabActivities_source/_datatable_source.dart';
import 'package:boilerplate/views/settings/company/company_setting/tabs/tabContacts/contact_data_table_source.dart';
import 'package:boilerplate/views/settings/company/company_setting/tabs/tabContacts/contact_form_source.dart';
import 'package:boilerplate/views/settings/company/company_setting/tabs/tabContacts/cp_contact_presenter.dart';
import 'package:boilerplate/views/settings/company/company_setting/tabs/tabGeneral/_general_form_source.dart';
import 'package:boilerplate/views/settings/company/company_setting/tabs/tabGeneral/cp_general_presenter.dart';
import 'package:boilerplate/widgets/button/theme_button_cancel.dart';
import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:bs_flutter_modal/bs_flutter_modal.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../constants/config_types.dart';
import '../../../../contracts/master/customerAddress_contract.dart';
import '../../../../contracts/master/userReset_contract.dart';
import '../../../../middleware/verifyToken.dart';
import '../../../../models/masters/competitor_model.dart';
import '../../../../models/masters/customer_model.dart';
import '../../../../models/masters/maps_model.dart';
import '../../../../models/masters/product_model.dart';
import '../../../../models/masters/type_model.dart';
import '../../../../models/masters/user_model.dart';
import '../../../../models/session_model.dart';
import '../../../../models/settings/stbptype_model.dart';
import '../../../../models/ventes/customfield_model.dart';
import '../../../../presenters/auth_presenter.dart';
import '../../../../presenters/masters/customer_presenter.dart';
import '../../../../presenters/masters/product_presenter.dart';
import '../../../../presenters/masters/typechildren_presenter.dart';
import '../../../../presenters/masters/user_presenter.dart';
import '../../../../presenters/navigation_presenter.dart';
import '../../../../presenters/settings/customfield_presenter.dart';
import '../../../../presenters/settings/stbptype/stbptypeactivitycategory_presenter.dart';
import '../../../../presenters/settings/stbptype/stbptypecontacttype_presenter.dart';
import '../../../../presenters/settings/stbptype/stbptypecustomertype_presenter.dart';
import '../../../../presenters/settings/stbptype/stbptypeprospectcategory_presenter.dart';
import '../../../../presenters/settings/stbptype/stbptypeprospectcustomerlabel_presenter.dart';
import '../../../../presenters/settings/stbptype/stbptypeprospectlostreason_presenter.dart';
import '../../../../presenters/settings/stbptype/stbptypeprospectstage_presenter.dart';
import '../../../../presenters/settings/stbptype/stbptypeprospectstatus_presenter.dart';
import '../../../../presenters/settings/stbptype/stbptypeprospecttype_presenter.dart';
import '../../../../presenters/settings/stbptype/stbptypescheduletype_presenter.dart';
import '../../../../presenters/ventes/bpcustomer_presenter.dart';
import '../../../../presenters/ventes/competitor_presenter.dart';
import '../../../../presenters/ventes/prospect_presenter.dart';
import '../../../../routes/route_list.dart';
import '../../../../services/masters/type_service.dart';
import '../../../../styles/color_palattes.dart';
import '../../../../utils/session_manager.dart';
import '../../../../widgets/breadcrumb.dart';
import '../../../../widgets/button/button_role_user.dart';
import '../../../../widgets/button/theme_button_create.dart';
import '../../../../widgets/button/theme_button_save.dart';
import '../../../../widgets/datatables/custom_datatable.dart';
import '../../../../widgets/form_group.dart';
import '../../../../widgets/form_group_edit.dart';
import '../../../../widgets/input/custom_input.dart';
import '../../../../widgets/input/custom_input_number.dart';
import '../../../../widgets/map/_map_source.dart';
import '../../../../widgets/selectbox/custom_selectbox.dart';
import '../../../../widgets/snackbar.dart';
import '../../../masters/customers/_datatable_source.dart';
import '../../../masters/product/_datatable_source.dart';
import '../../../masters/product/_form_source.dart';
import '../../../masters/users/_datatable_source.dart';
import '../../../masters/users/_form_source.dart';
import '../../../skins/template.dart';
import '../../../ventes/competitor/_datatable_source.dart';
import '../../../ventes/competitor/_form_source.dart';
import '../../customfield/_datatable_source.dart';
import '../../customfield/_form_source.dart';
import '../../customfield/_text.dart';
import '_source.dart';
import 'tabs/tabCustomers/_datatable_source.dart';
import 'tabs/tabCustomers/_form_source.dart';
import 'tabs/tabCustomizeField_source/customfield_presenter.dart';

part 'tabs/tabActivities.dart';
part 'tabs/tabCustomer.dart';
part 'tabs/tabCustomers/tabCustomers.dart';
part 'tabs/tabContacts/tabContacts.dart';
part 'tabs/tabContacts/_contact_form.dart';
part 'tabs/tabGeneral/tabGeneral.dart';
part 'tabs/tabProspect.dart';
part 'tabs/tabSchedule.dart';
part 'tabs/tabUsers.dart';
part 'tabs/tabProduct.dart';
part 'tabs/tabCustomizeField.dart';

part 'tabs/tabCustomers/customers_form_source.dart';
part 'tabs/tabCustomers/tabCustomerspr.dart';

part 'tabs/tabActivities_source/_tabCategory.dart';
// part 'tabs/tabActivities_source/_tabType.dart';
part 'tabs/tabActivities_source/_tabCustomerActivity.dart';

part 'tabs/tabCustomers_source/_tabContactType.dart';
part 'tabs/tabCustomers_source/_tabCustomerType.dart';

part 'tabs/tabProspect_source/_tabCategory.dart';
part 'tabs/tabProspect_source/_tabCustomerLabel.dart';
part 'tabs/tabProspect_source/_tabLostReason.dart';
part 'tabs/tabProspect_source/_tabType.dart';
part 'tabs/tabProspect_source/_tabStage.dart';
part 'tabs/tabProspect_source/_tabStatus.dart';
part 'tabs/tabProspect_source/_tabCompetitor.dart';

part 'tabs/tabCustomizeField_source/_tabDailyActivity.dart';
part 'tabs/tabCustomizeField_source/_tabProspect.dart';
part 'tabs/tabCustomizeField_source/customfield_source.dart';

part 'tabs/tabSchedules_source/_tabType.dart';

part 'tabs/sources/_form_source.dart';
part 'tabs/sources/default_notypes.dart';
part 'tabs/sources/show_color.dart';

part 'tabs/tabCustomizeField_source/form.dart';

final _navigation = Get.find<NavigationPresenter>();
final authPresenter = Get.find<AuthPresenter>();
final _sources = Get.find<CompanySources>();
final box = GetStorage();
final source = _CompanyTabFormSource().obs;
final sources = CompetitorSource().obs;
// ignore: invalid_use_of_protected_member
var permis = authPresenter.rolepermis.value;

class CompanyView extends StatefulWidget {
  @override
  State<CompanyView> createState() => _CompanyViewState();
}

class _CompanyViewState extends State<CompanyView>
    with TickerProviderStateMixin {
  final _navigation = Get.find<NavigationPresenter>();
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
    if (authPresenter.rolepermis.isEmpty) checkJwtToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        title: 'Company Setting',
        breadcrumbs: [
          BreadcrumbWidget('Settings'),
          BreadcrumbWidget('Company Setting', active: true),
        ],
        activeRoutes: [
          RouteList.settings.index,
          RouteList.settingsCompany.index
        ],
        child: Obx(() => Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: _navigation.darkTheme.value
                    ? ColorPallates.elseDarkColor
                    : Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: BsRow(
                children: [
                  BsCol(
                    sizes: ColScreen(sm: Col.col_8),
                    child: Container(
                      child: TabBar(
                        onTap: (x) {
                          final sources = Get.put(CustomizeFieldSource());
                          source.value.isformactcat.value = false;
                          source.value.isupdate.value = false;
                          sources.isForm.value = false;
                          sources.isEdit.value = false;
                        },
                        controller: _tabController,
                        labelColor: Colors.green,
                        unselectedLabelColor: _navigation.darkTheme.value
                            ? Colors.white
                            : Colors.black,
                        tabs: [
                          Tab(text: 'General'),
                          Tab(text: 'Activities'),
                          Tab(text: 'Customer'),
                          Tab(text: 'Prospect'),
                          // Tab(text: 'Schedule'),
                          Tab(text: 'Users'),
                          Tab(text: 'Product'),
                          Tab(text: 'Customize Field'),
                        ],
                      ),
                    ),
                  ),
                  BsCol(
                    sizes: ColScreen(sm: Col.col_12),
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          _TabGeneral(),
                          _TabActivities(),
                          _TabCustomer(),
                          _TabProspect(),
                          // _TabSchedules(),
                          _TabUsers(),
                          _TabProduct(),
                          _TabCustomizeField(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
