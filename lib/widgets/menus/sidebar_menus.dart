import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../presenters/navigation_presenter.dart';
import '../../styles/color_palattes.dart';
import 'menu_data_group.dart';
import 'menu_item.dart';

class SidebarMenus extends StatelessWidget {
  SidebarMenus({
    this.isCollapse = false,
    this.activeRoute = const [],
    this.menus = const [],
  });

  final List<String> activeRoute;

  final List<MenuDataGroup> menus;

  final bool isCollapse;

  @override
  Widget build(BuildContext context) {
    final _navigation = Get.find<NavigationPresenter>();
    return Container(
      margin: isCollapse ? EdgeInsets.only(top: 10) : EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Scrollbar(
            child: SingleChildScrollView(
              child: isCollapse
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: this
                          .menus
                          .map(
                            (data) => Container(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                              child: Column(
                                children: data.children
                                    .map(
                                      (child) => isCollapse
                                          ? MenuItemCollapse(
                                              data: child,
                                              activeRoute: activeRoute,
                                            )
                                          : MenuItem(
                                              data: child,
                                              activeRoute: activeRoute,
                                            ),
                                    )
                                    .toList(),
                              ),
                            ),
                          )
                          .toList(),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: this
                          .menus
                          .map(
                            (data) => Container(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                              child: ExpansionTile(
                                collapsedIconColor: _navigation.darkTheme.value
                                    ? ColorPallates.sidebarDarkTextColor
                                    : ColorPallates.sidebarLightTextColor,
                                initiallyExpanded: true,
                                leading: Container(
                                  margin: EdgeInsets.only(right: 5),
                                  child: Icon(
                                    data.icon,
                                    size: 24,
                                    color: Colors.grey,
                                  ),
                                ),
                                title: Text(
                                  data.title!.toUpperCase(),
                                  style: TextStyle(
                                    color: _navigation.darkTheme.value
                                        ? ColorPallates.sidebarDarkTextColor
                                        : ColorPallates.sidebarLightTextColor,
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                children: [
                                  Column(
                                    children: data.children
                                        .map(
                                          (child) => isCollapse
                                              ? MenuItemCollapse(
                                                  data: child,
                                                  activeRoute: activeRoute,
                                                )
                                              : MenuItem(
                                                  data: child,
                                                  activeRoute: activeRoute,
                                                ),
                                        )
                                        .toList(),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
            ),
          )
        ],
      ),
    );
  }
}
