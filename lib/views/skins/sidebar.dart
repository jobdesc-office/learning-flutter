import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../presenters/auth_presenter.dart';
import '../../presenters/navigation_presenter.dart';
import '../../widgets/menus/sidebar_menus.dart';
import '../../widgets/menus/sidebar_widget.dart';
import '../../routes/route_list.dart';
import '../../styles/color_palattes.dart';
import '../../widgets/menus/menu_data.dart';
import '../../widgets/menus/menu_data_group.dart';

class SidebarSkins extends StatelessWidget {
  SidebarSkins({
    Key? key,
    this.activeRoute = const [],
  }) : super(key: key);

  final box = GetStorage();

  final List<String> activeRoute;

  final _navigation = Get.find<NavigationPresenter>();
  final authPresenter = Get.find<AuthPresenter>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        color: _navigation.darkTheme.value
            ? ColorPallates.elseDarkColor
            : ColorPallates.sidebarLightColor,
        child: _navigation.dataListOfMenu.value.id != 0 &&
                !_navigation.isCollapse.value
            ? listOfMenu()
            : sidebar(),
      ),
    );
  }

  Widget sidebar() {
    int no = 1;
    var permis = authPresenter.rolepermis.value;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 250),
          width: _navigation.isCollapse.value ? 70 : 250,
          // height: _navigation.isCollapse.value ? 50 : 100,
          padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.transparent, width: 0),
          ),
          child: _navigation.isCollapse.value
              ? SidebarWidgets.logoCollapse()
              : SidebarWidgets.logo(),
        ),
        if (permis != [])
          Expanded(
            child: SingleChildScrollView(
              child: AnimatedContainer(
                duration: Duration(milliseconds: 250),
                width: _navigation.isCollapse.value ? 70 : 250,
                decoration: BoxDecoration(
                  color: _navigation.darkTheme.value
                      ? ColorPallates.elseDarkColor
                      : ColorPallates.sidebarLightColor,
                ),
                child: SidebarMenus(
                  isCollapse: _navigation.isCollapse.value,
                  activeRoute: activeRoute,
                  menus: [
                    MenuDataGroup(
                      title: 'Insight',
                      children: [
                        MenuData(
                          id: no++,
                          route: RouteList.home.index,
                          label: 'Dashboard',
                          icon: Icons.dashboard,
                        ),
                      ],
                    ),
                    MenuDataGroup(
                      title: 'Master Datas',
                      icon: Icons.storage_outlined,
                      children: [
                        MenuData(
                            id: no++,
                            route: RouteList.masterBusinessPartner.index,
                            label: 'Business Partners',
                            icon: Icons.handshake),
                        if (permis
                            .where((element) =>
                                element.menu?.menunm == 'Customers')
                            .first
                            .hasaccess!)
                          MenuData(
                              id: no++,
                              route: RouteList.customer.index,
                              label: 'Customers',
                              icon: Icons.groups,
                              children: [
                                if (permis
                                    .where((element) =>
                                        element.menu?.menunm == 'BpCustomer')
                                    .first
                                    .hasaccess!)
                                  MenuData(
                                    id: no++,
                                    route: RouteList.ventesBpCustomer.index,
                                    label: 'BpCustomers',
                                    icon: FontAwesomeIcons.userPlus,
                                  ),
                                if (permis
                                    .where((element) =>
                                        element.menu?.menunm == 'Contacts')
                                    .first
                                    .hasaccess!)
                                  MenuData(
                                      id: no++,
                                      route: RouteList.masterContact.index,
                                      label: 'Contacts',
                                      icon: Icons.contacts),
                                MenuData(
                                  id: no++,
                                  route: RouteList.masterCustomer.index,
                                  label: 'Customers',
                                  icon: Icons.groups,
                                )
                              ]),
                        MenuData(
                          id: no++,
                          route: RouteList.masterMenu.index,
                          label: 'Menus',
                          icon: Icons.dehaze,
                        ),
                        // MenuData(
                        //     id: no++,
                        //     route: RouteList.masterProduct.index,
                        //     label: 'Products',
                        //     icon: Icons.sell),
                        if (permis
                            .where((element) => element.menu?.menunm == 'Users')
                            .first
                            .hasaccess!)
                          MenuData(
                              id: no++,
                              route: RouteList.masterUser.index,
                              label: 'Users',
                              icon: Icons.group),
                      ],
                    ),
                    MenuDataGroup(
                        title: 'Ventes Datas',
                        icon: Icons.analytics,
                        children: [
                          MenuData(
                            id: no++,
                            route: RouteList.ventesCompetitor.index,
                            label: 'Competitors',
                            icon: Icons.sentiment_dissatisfied,
                          ),
                          MenuData(
                            id: no++,
                            route: RouteList.ventesProspect.index,
                            label: 'Prospects',
                            icon: Icons.analytics,
                          ),
                          MenuData(
                            id: no++,
                            route: RouteList.ventesSchedule.index,
                            label: 'Schedules',
                            icon: FontAwesomeIcons.calendarDays,
                          ),
                          MenuData(
                            id: no++,
                            route: RouteList.ventesReport.index,
                            label: 'Reports',
                            icon: FontAwesomeIcons.addressBook,
                          ),
                        ]),
                    MenuDataGroup(
                      title: 'Settings',
                      icon: Icons.settings_outlined,
                      children: [
                        MenuData(
                            id: no++,
                            route: RouteList.settings.index,
                            label: 'Company',
                            icon: Icons.domain,
                            children: [
                              MenuData(
                                  id: no++,
                                  route: RouteList.settingsCompany.index,
                                  label: 'Company',
                                  icon: Icons.domain),
                              MenuData(
                                  id: no++,
                                  route: RouteList.settingsDataField.index,
                                  label: 'Data Field',
                                  icon: Icons.add_box),
                            ]),
                        MenuData(
                          id: no++,
                          route: RouteList.settingsCustomField.index,
                          label: 'Custom Fields',
                          icon: Icons.add_box,
                        ),
                        MenuData(
                            id: no++,
                            route: RouteList.settingsFiles.index,
                            label: 'Files',
                            icon: Icons.file_open),
                        MenuData(
                            id: no++,
                            route: RouteList.settingsPermission.index,
                            label: 'Permission',
                            icon: Icons.key),
                        MenuData(
                            id: no++,
                            label: 'Regions',
                            route: RouteList.settings.index,
                            icon: FontAwesomeIcons.earthAmericas,
                            children: [
                              MenuData(
                                id: no++,
                                route: RouteList.masterCity.index,
                                label: 'Cities',
                                icon: FontAwesomeIcons.city,
                              ),
                              MenuData(
                                id: no++,
                                route: RouteList.masterCountry.index,
                                label: 'Countries',
                                icon: FontAwesomeIcons.globe,
                              ),
                              MenuData(
                                id: no++,
                                route: RouteList.masterProvince.index,
                                label: 'Provinces',
                                icon: FontAwesomeIcons.locationDot,
                              ),
                              MenuData(
                                id: no++,
                                route: RouteList.masterSubdistrict.index,
                                label: 'Subdistricts',
                                icon: FontAwesomeIcons.city,
                              ),
                              MenuData(
                                id: no++,
                                route: RouteList.masterVillage.index,
                                label: 'Villages',
                                icon: FontAwesomeIcons.city,
                              ),
                            ]),
                        if (permis
                            .where((element) => element.menu?.menunm == 'Types')
                            .first
                            .hasaccess!)
                          MenuData(
                            id: no++,
                            route: RouteList.type.index,
                            label: 'Types',
                            icon: Icons.category,
                            children: [
                              if (permis
                                  .where((element) =>
                                      element.menu?.menunm == 'Type Datas')
                                  .first
                                  .hasaccess!)
                                MenuData(
                                  id: no++,
                                  route: RouteList.masterTypeChildren.index,
                                  label: 'Type Datas',
                                  icon: Icons.square,
                                ),
                              if (permis
                                  .where((element) =>
                                      element.menu?.menunm == 'Type Parents')
                                  .first
                                  .hasaccess!)
                                MenuData(
                                  id: no++,
                                  route: RouteList.masterTypeParent.index,
                                  label: 'Type Parents',
                                  icon: Icons.category,
                                ),
                            ],
                          ),
                        // MenuData(
                        //   id: no++,
                        //   route: RouteList.settings.index,
                        //   label: 'Security',
                        //   children: [
                        //     MenuData(
                        //       id: no++,
                        //       route: RouteList.settingsPrevileges.index,
                        //       label: 'Previleges',
                        //     ),
                        //     MenuData(
                        //       id: no++,
                        //       route: RouteList.settingsUser.index,
                        //       label: 'Role User',
                        //     ),
                        //   ],
                        // ),
                        // MenuData(
                        //     id: no++,
                        //     route: '/level',
                        //     label: 'Level Menu 1',
                        //     children: [
                        //       MenuData(
                        //           id: no++,
                        //           route: '/level-1',
                        //           label: 'Level Menu 1.1',
                        //           children: [
                        //             MenuData(
                        //               id: no++,
                        //               route: '/level-1-1',
                        //               label: 'Level Menu 1.1.1',
                        //             ),
                        //             MenuData(
                        //                 id: no++,
                        //                 route: '/level-1-2',
                        //                 label: 'Level Menu 1.1.2',
                        //                 children: [
                        //                   MenuData(
                        //                     id: no++,
                        //                     route: '/level-1-1-1',
                        //                     label: 'Level Menu 1.1.1.1',
                        //                   ),
                        //                   MenuData(
                        //                     id: no++,
                        //                     route: '/level-1-1-1',
                        //                     label: 'Level Menu 1.1.1.2',
                        //                   ),
                        //                 ]),
                        //           ]),
                        //       MenuData(
                        //         id: no++,
                        //         route: '/level-2',
                        //         label: 'Level Menu 1.2',
                        //       ),
                        //     ]),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
      ],
    );
  }

  Widget listOfMenu() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 250),
          width: _navigation.isCollapse.value ? 70 : 250,
          padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
          decoration: BoxDecoration(
            color: _navigation.darkTheme.value
                ? ColorPallates.elseDarkColor
                : ColorPallates.sidebarLightColor,
          ),
          child: _navigation.isCollapse.value
              ? SidebarWidgets.logoCollapse()
              : SidebarWidgets.menuParent(
                  _navigation.historyMenu,
                  onTab: () => _navigation.backToMenu(),
                ),
        ),
        Expanded(
          child: AnimatedContainer(
            duration: Duration(milliseconds: 250),
            width: _navigation.isCollapse.value ? 70 : 250,
            decoration: BoxDecoration(
              color: _navigation.darkTheme.value
                  ? ColorPallates.elseDarkColor
                  : ColorPallates.sidebarLightColor,
            ),
            child: SidebarMenus(
              isCollapse: false,
              activeRoute: activeRoute,
              menus: [
                MenuDataGroup(
                  title: _navigation.dataListOfMenu.value.label,
                  children: _navigation.dataListOfMenu.value.children,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
