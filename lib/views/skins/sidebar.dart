import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
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
          color: ColorPallates.dark,
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
          duration: Duration(milliseconds: 0),
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
        AnimatedContainer(
          width: _navigation.isCollapse.value ? 70 : 250,
          padding: _navigation.isCollapse.value
              ? EdgeInsets.all(5)
              : EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _navigation.darkTheme.value
                ? ColorPallates.elseDarkColor
                : ColorPallates.elseLightColor,
            border: Border.all(color: Colors.transparent, width: 0),
          ),
          duration: Duration(milliseconds: 0),
          child: _navigation.isCollapse.value
              ? CircleAvatar(
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: _navigation.darkTheme.value
                        ? ColorPallates.elseDarkColor
                        : ColorPallates.white,
                  ),
                  backgroundColor: ColorPallates.primary,
                )
              : BsRow(
                  children: [
                    BsCol(
                      sizes: ColScreen(sm: Col.col_4),
                      child: CircleAvatar(
                        child: Icon(
                          Icons.person,
                          size: 50,
                          color: _navigation.darkTheme.value
                              ? ColorPallates.elseDarkColor
                              : ColorPallates.white,
                        ),
                        backgroundColor: ColorPallates.primary,
                      ),
                    ),
                    BsCol(
                      sizes: ColScreen(sm: Col.col_8),
                      child: Column(
                        children: [
                          Text(
                            box.read('username'),
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(box.read('role'))
                        ],
                      ),
                    )
                  ],
                ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: AnimatedContainer(
              duration: Duration(milliseconds: 0),
              width: _navigation.isCollapse.value ? 70 : 250,
              decoration: BoxDecoration(
                color: _navigation.darkTheme.value
                    ? ColorPallates.elseDarkColor
                    : ColorPallates.elseLightColor,
              ),
              child: SidebarMenus(
                isCollapse: _navigation.isCollapse.value,
                activeRoute: activeRoute,
                menus: [
                  MenuDataGroup(
                    title: 'Navigasi Menu',
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
                    title: 'Master Data',
                    icon: Icons.storage_outlined,
                    children: [
                      MenuData(
                        id: no++,
                        route: RouteList.masterMenu.index,
                        label: 'Menus',
                      ),
                      MenuData(
                        id: no++,
                        route: RouteList.masterUser.index,
                        label: 'Users',
                      ),
                      MenuData(
                        id: no++,
                        route: RouteList.masterCustomer.index,
                        label: 'Customers',
                      ),
                      MenuData(
                        id: no++,
                        route: RouteList.masterBusinessPartner.index,
                        label: 'Business Partners',
                      ),
                      MenuData(
                          id: no++,
                          label: 'Region',
                          route: RouteList.settings.index,
                          children: [
                            MenuData(
                              id: no++,
                              route: RouteList.masterCountry.index,
                              label: 'Countries',
                            ),
                            MenuData(
                              id: no++,
                              route: RouteList.masterProvince.index,
                              label: 'Provinces',
                            ),
                            MenuData(
                              id: no++,
                              route: RouteList.masterCity.index,
                              label: 'Cities',
                            ),
                            MenuData(
                              id: no++,
                              route: RouteList.masterSubdistrict.index,
                              label: 'Subdistricts',
                            ),
                          ]),
                      MenuData(
                        id: no++,
                        route: RouteList.settings.index,
                        label: 'Types',
                        children: [
                          MenuData(
                            id: no++,
                            route: RouteList.masterTypeParent.index,
                            label: 'Type Parents',
                          ),
                          MenuData(
                            id: no++,
                            route: RouteList.masterTypeChildren.index,
                            label: 'Type Datas',
                          ),
                        ],
                      ),
                    ],
                  ),
                  MenuDataGroup(
                      title: 'Ventes Data',
                      icon: Icons.analytics,
                      children: [
                        MenuData(
                          id: no++,
                          route: RouteList.ventesSchedule.index,
                          label: 'Schedules',
                        ),
                        MenuData(
                          id: no++,
                          route: RouteList.ventesProspect.index,
                          label: 'Prospects',
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
                : ColorPallates.elseLightColor,
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
                  : ColorPallates.elseLightColor,
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
