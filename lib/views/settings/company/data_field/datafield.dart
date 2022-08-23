import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../presenters/navigation_presenter.dart';
import '../../../../routes/route_list.dart';
import '../../../../styles/color_palattes.dart';
import '../../../../widgets/breadcrumb.dart';
import '../../../skins/template.dart';

part 'tabs/tabProspect.dart';
part 'tabs/tabPerson.dart';
part 'tabs/tabOrganization.dart';
part 'tabs/tabProduct.dart';

class DataFieldView extends StatefulWidget {
  const DataFieldView({Key? key}) : super(key: key);

  @override
  State<DataFieldView> createState() => _DataFieldViewState();
}

class _DataFieldViewState extends State<DataFieldView>
    with TickerProviderStateMixin {
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
        title: 'DataField Setting',
        breadcrumbs: [
          BreadcrumbWidget('Settings'),
          BreadcrumbWidget('DataField Setting', active: true),
        ],
        activeRoutes: [
          RouteList.settings.index,
          RouteList.settingsDataField.index
        ],
        child: Container(
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
                sizes: ColScreen(sm: Col.col_6),
                child: Container(
                  child: TabBar(
                    controller: _tabController,
                    labelColor: Colors.green,
                    unselectedLabelColor: Colors.black,
                    tabs: [
                      Tab(text: 'Prospect'),
                      Tab(text: 'Person'),
                      Tab(text: 'Organization'),
                      Tab(text: 'Product'),
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
                      _TabProspect(),
                      _TabPerson(),
                      _TabOrganization(),
                      _TabProduct()
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
