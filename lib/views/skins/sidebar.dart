import 'package:boilerplate/helpers/function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../presenters/auth_presenter.dart';
import '../../presenters/navigation_presenter.dart';
import '../../widgets/menus/sidebar_menus.dart';
import '../../widgets/menus/sidebar_widget.dart';
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
        color: _navigation.darkTheme.value ? ColorPallates.elseDarkColor : ColorPallates.sidebarLightColor,
        child: _navigation.dataListOfMenu.value.id != 0 && !_navigation.isCollapse.value ? listOfMenu() : sidebar(),
      ),
    );
  }

  Widget sidebar() {
    // ignore: invalid_use_of_protected_member
    var permis = authPresenter.rolepermis.value.where((element) => element.menutypeid == 8);
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
          child: _navigation.isCollapse.value ? SidebarWidgets.logoCollapse() : SidebarWidgets.logo(),
        ),
        if (permis.isNotEmpty)
          Expanded(
            child: SingleChildScrollView(
              child: AnimatedContainer(
                duration: Duration(milliseconds: 250),
                width: _navigation.isCollapse.value ? 70 : 250,
                decoration: BoxDecoration(
                  color: _navigation.darkTheme.value ? ColorPallates.elseDarkColor : ColorPallates.sidebarLightColor,
                ),
                child: SidebarMenus(
                  isCollapse: _navigation.isCollapse.value,
                  activeRoute: activeRoute,
                  menus: permis
                      .where((element) => element.features?.where((element) => element.featslug == 'viewable').first.permissions?.hasaccess ?? false)
                      .map((e) => MenuDataGroup(
                            title: e.menunm,
                            icon: e.menuicon != '' ? parseIcon(e.menuicon) : null,
                            children: e.children!
                                .where((element) => element.features?.where((element) => element.featslug == 'viewable').first.permissions?.hasaccess ?? false)
                                .map((e) => MenuData(
                                    icon: parseIcon(e.menuicon),
                                    id: e.menuid ?? 0,
                                    label: e.menunm ?? '',
                                    route: e.menuroute ?? '',
                                    children: e.children!.where((element) => element.features?.where((element) => element.featslug == 'viewable').first.permissions?.hasaccess ?? false).map((e) {
                                      if (e.children != []) {
                                        return MenuData(icon: parseIcon(e.menuicon), id: e.menuid ?? 0, label: e.menunm ?? '', route: e.menuroute ?? '');
                                      } else {
                                        return MenuData(
                                            icon: parseIcon(e.menuicon),
                                            id: e.menuid ?? 0,
                                            label: e.menunm ?? '',
                                            route: e.menuroute ?? '',
                                            children: e.children!
                                                .where((element) => element.features?.where((element) => element.featslug == 'viewable').first.permissions?.hasaccess ?? false)
                                                .map((e) => MenuData(icon: parseIcon(e.menuicon), id: e.menuid ?? 0, label: e.menunm ?? '', route: e.menuroute ?? ''))
                                                .toList());
                                      }
                                    }).toList()))
                                .toList(),
                          ))
                      .toList(),
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
            color: _navigation.darkTheme.value ? ColorPallates.elseDarkColor : ColorPallates.sidebarLightColor,
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
              color: _navigation.darkTheme.value ? ColorPallates.elseDarkColor : ColorPallates.sidebarLightColor,
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
