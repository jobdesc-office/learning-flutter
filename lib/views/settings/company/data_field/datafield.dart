import 'package:boilerplate/widgets/datatables/custom_datatable.dart';
import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../presenters/navigation_presenter.dart';
import '../../../../routes/route_list.dart';
import '../../../../styles/color_palattes.dart';
import '../../../../widgets/breadcrumb.dart';
import '../../../../widgets/button/button_controller.dart';
import '../../../../widgets/button/button_info_customfield.dart';
import '../../../skins/template.dart';
import '_datatable_source.dart';

part 'dropdown.dart';
part 'tabs/tabProspect.dart';
part 'tabs/tabPerson.dart';
part 'tabs/tabOrganization.dart';
part 'tabs/tabProduct.dart';

final _navigation = Get.find<NavigationPresenter>();
final datatable = CompanyDataFieldDataTableSource();

class DataFieldView extends StatefulWidget {
  const DataFieldView({Key? key}) : super(key: key);

  @override
  State<DataFieldView> createState() => _DataFieldViewState();
}

class _DataFieldViewState extends State<DataFieldView>
    with TickerProviderStateMixin {
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
        // title: 'DataField Setting',
        // breadcrumbs: [
        //   BreadcrumbWidget('Settings'),
        //   BreadcrumbWidget('DataField Setting', active: true),
        // ],
        activeRoutes: [
          RouteList.settings.index,
          RouteList.settingsDataField.index
        ],
        child: Obx(() => Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: _navigation.darkTheme.value
                    ? ColorPallates.elseDarkColor
                    : Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Data Field',
                          style: TextStyle(
                            fontSize: 22,
                          )),
                      _CustomFieldDropDown()
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                          'Improve Your Quality of Your Data by Choosing Where Certain Fields Appear and by Highlighting some as Important.'),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                          'This Includes Custom Fields That Help You Tailor Data to Your Business Needs'),
                      Row(
                        children: [
                          Text(
                            '  Learn More About Custom Fields',
                            style: TextStyle(color: Colors.blue),
                          ),
                          Icon(Icons.arrow_circle_right, color: Colors.blue)
                        ],
                      )
                    ],
                  ),
                  BsRow(
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
                ],
              ),
            )),
      ),
    );
  }
}
