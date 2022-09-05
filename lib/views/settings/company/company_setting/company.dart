import 'package:boilerplate/widgets/datatables/custom_datatable.dart';
import 'package:boilerplate/widgets/input/custom_input.dart';
import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../presenters/navigation_presenter.dart';
import '../../../../routes/route_list.dart';
import '../../../../styles/color_palattes.dart';
import '../../../../widgets/breadcrumb.dart';
import '../../../../widgets/button/theme_button_save.dart';
import '../../../skins/template.dart';
import '_datatable_source.dart';

part 'tabs/tabGeneral.dart';
part 'tabs/tabActivities.dart';
part 'tabs/tabCustomer.dart';
part 'tabs/tabLostReasons.dart';
part 'tabs/tabProspect.dart';

class CompanyView extends StatefulWidget {
  const CompanyView({Key? key}) : super(key: key);

  @override
  State<CompanyView> createState() => _CompanyViewState();
}

class _CompanyViewState extends State<CompanyView> with TickerProviderStateMixin {
  final _navigation = Get.find<NavigationPresenter>();
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
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
        activeRoutes: [RouteList.settings.index, RouteList.settingsCompany.index],
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: _navigation.darkTheme.value ? ColorPallates.elseDarkColor : Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: BsRow(
            children: [
              BsCol(
                sizes: ColScreen(sm: Col.col_6),
                child: Container(
                  child: TabBar(
                    controller: _tabController,
                    labelColor: Colors.green,
                    unselectedLabelColor: Colors.black,
                    tabs: [
                      Tab(text: 'General'),
                      Tab(text: 'Activities'),
                      Tab(text: 'Prospect'),
                      Tab(text: 'Customer'),
                    ],
                  ),
                ),
              ),
              BsCol(
                sizes: ColScreen(sm: Col.col_12),
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _TabGeneral(),
                      _TabActivities(),
                      _TabCustomer(),
                      _TabProspect(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
