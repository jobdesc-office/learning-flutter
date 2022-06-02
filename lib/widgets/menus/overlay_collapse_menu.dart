import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../presenters/navigation_presenter.dart';
import '../../styles/color_palattes.dart';

import 'menu_data_group.dart';
import 'sidebar_menus.dart';
import 'sidebar_widget.dart';

class OverlayCollapseMenu extends StatelessWidget {
  final NavigationPresenter _navigation = Get.find<NavigationPresenter>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 70),
      child: Material(
        color: Colors.transparent,
        child: Obx(() {
          return Container(
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  bottom: 0,
                  child: Container(
                    width: 250,
                    decoration: BoxDecoration(
                      color: _navigation.darkTheme.value
                          ? ColorPallates.elseDarkColor
                          : ColorPallates.primary,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnimatedContainer(
                          duration: Duration(milliseconds: 250),
                          padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
                          decoration: BoxDecoration(
                            color: _navigation.darkTheme.value
                                ? ColorPallates.elseDarkColor
                                : ColorPallates.primary,
                          ),
                          child: SidebarWidgets.menuParentCollapse(
                            _navigation.dataListOfMenu.value.label,
                            _navigation.historyMenu,
                            onTab: () => _navigation.backToMenu(),
                          ),
                        ),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 250),
                          decoration: BoxDecoration(
                            color: _navigation.darkTheme.value
                                ? ColorPallates.elseDarkColor
                                : ColorPallates.primary,
                          ),
                          child: SidebarMenus(
                            menus: [
                              MenuDataGroupDrill(
                                title: _navigation.dataListOfMenu.value.label,
                                children:
                                    _navigation.dataListOfMenu.value.children,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
