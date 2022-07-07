import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../presenters/navigation_presenter.dart';
import '../../routes/route_list.dart';
import '../../styles/color_palattes.dart';
import '../../widgets/menus/menu_data.dart';
import '../../widgets/menus/menu_data_group.dart';
import '../../widgets/menus/sidebar_menus.dart';
import '../../widgets/menus/sidebar_widget.dart';

class SidebarSkins extends StatelessWidget {
  SidebarSkins({
    Key? key,
    this.activeRoute = const [],
  }) : super(key: key);

  final box = GetStorage();

  final List<String> activeRoute;

  final NavigationPresenter _navigation = Get.find<NavigationPresenter>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Container(
          color: _navigation.darkTheme.value
              ? ColorPallates.elseDarkColor
              : ColorPallates.sidebarLightColor,
          child: _navigation.dataListOfMenu.value.id != 0 &&
                  !_navigation.isCollapse.value
              ? listOfMenu()
              : sidebar(),
        );
      },
    );
  }

  Widget sidebar() {
    int no = 1;
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
                    title: 'Navigation',
                    children: [
                      MenuData(
                        id: no++,
                        route: RouteList.home.index,
                        label: 'Insight',
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
                      MenuData(
                          id: no++,
                          route: RouteList.masterContact.index,
                          label: 'Contacts',
                          icon: Icons.contacts),
                      MenuData(
                          id: no++,
                          route: RouteList.customer.index,
                          label: 'Customers',
                          icon: Icons.groups,
                          children: [
                            MenuData(
                              id: no++,
                              route: RouteList.ventesBpCustomer.index,
                              label: 'BpCustomers',
                              icon: FontAwesomeIcons.userPlus,
                            ),
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
                      MenuData(
                          id: no++,
                          route: RouteList.masterProduct.index,
                          label: 'Products',
                          icon: Icons.sell),
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
                              icon: FontAwesomeIcons.mapMarkerAlt,
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
                      MenuData(
                        id: no++,
                        route: RouteList.type.index,
                        label: 'Types',
                        icon: Icons.category,
                        children: [
                          MenuData(
                            id: no++,
                            route: RouteList.masterTypeChildren.index,
                            label: 'Type Datas',
                            icon: Icons.square,
                          ),
                          MenuData(
                            id: no++,
                            route: RouteList.masterTypeParent.index,
                            label: 'Type Parents',
                            icon: Icons.category,
                          ),
                        ],
                      ),
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
                        // MenuData(
                        //     id: no++,
                        //     route: RouteList.prospect.index,
                        //     label: 'Prospects',
                        //     icon: Icons.analytics,
                        //     children: [
                        MenuData(
                          id: no++,
                          route: RouteList.ventesProspect.index,
                          label: 'Prospects',
                          icon: Icons.analytics,
                        ),
                        //   MenuData(
                        //     id: no++,
                        //     route: RouteList.ventesCustomField.index,
                        //     label: 'Custom Fields',
                        //     icon: Icons.add_box,
                        //   ),
                        // ]),
                        MenuData(
                          id: no++,
                          route: RouteList.ventesSchedule.index,
                          label: 'Schedules',
                          icon: FontAwesomeIcons.calendarAlt,
                        ),
                      ])

                  // MenuDataGroup(
                  //   title: 'Settings',
                  //   icon: Icons.settings_outlined,
                  //   children: [
                  //     MenuData(
                  //       id: no++,
                  //       route: RouteList.settings.index,
                  //       label: 'Security',
                  //       children: [
                  //         MenuData(
                  //           id: no++,
                  //           route: RouteList.settingsPrevileges.index,
                  //           label: 'Previleges',
                  //         ),
                  //         MenuData(
                  //           id: no++,
                  //           route: RouteList.settingsUser.index,
                  //           label: 'Role User',
                  //         ),
                  //       ],
                  //     ),
                  //     MenuData(
                  //         id: no++,
                  //         route: '/level',
                  //         label: 'Level Menu 1',
                  //         children: [
                  //           MenuData(
                  //               id: no++,
                  //               route: '/level-1',
                  //               label: 'Level Menu 1.1',
                  //               children: [
                  //                 MenuData(
                  //                   id: no++,
                  //                   route: '/level-1-1',
                  //                   label: 'Level Menu 1.1.1',
                  //                 ),
                  //                 MenuData(
                  //                     id: no++,
                  //                     route: '/level-1-2',
                  //                     label: 'Level Menu 1.1.2',
                  //                     children: [
                  //                       MenuData(
                  //                         id: no++,
                  //                         route: '/level-1-1-1',
                  //                         label: 'Level Menu 1.1.1.1',
                  //                       ),
                  //                       MenuData(
                  //                         id: no++,
                  //                         route: '/level-1-1-1',
                  //                         label: 'Level Menu 1.1.1.2',
                  //                       ),
                  //                     ]),
                  //               ]),
                  //           MenuData(
                  //             id: no++,
                  //             route: '/level-2',
                  //             label: 'Level Menu 1.2',
                  //           ),
                  //         ]),
                  //   ],
                  // ),
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
