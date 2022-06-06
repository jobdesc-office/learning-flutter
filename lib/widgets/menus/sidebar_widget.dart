import 'package:boilerplate/styles/color_palattes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../presenters/navigation_presenter.dart';
import 'menu_data.dart';

final _navigation = Get.find<NavigationPresenter>();

class SidebarWidgets {
  static Widget logo() {
    return Row(
      children: [
        Expanded(
            child:
                Image.asset('assets/images/logo.png', width: 250, height: 75))
      ],
    );
  }

  static Widget logoCollapse() {
    return Image.asset('assets/images/logo.png');
  }

  static Widget menuParent(List<MenuData> history, {VoidCallback? onTab}) {
    return Material(
      color: _navigation.darkTheme.value
          ? ColorPallates.elseDarkColor
          : ColorPallates.sidebarLightColor,
      child: InkWell(
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(3),
              margin: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.keyboard_arrow_left_rounded,
                color: _navigation.darkTheme.value
                    ? ColorPallates.sidebarDarkTextColor
                    : ColorPallates.sidebarLightTextColor,
              ),
            ),
            Text(
              'Back to ${history.length > 1 ? history[history.length - 2].label : 'Main Menu'}',
              style: TextStyle(
                color: _navigation.darkTheme.value
                    ? ColorPallates.sidebarDarkTextColor
                    : ColorPallates.sidebarLightTextColor,
                fontSize: 16,
              ),
            ),
          ],
        ),
        onTap: onTab,
        borderRadius: BorderRadius.circular(50),
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
    );
  }

  static Widget menuParentCollapse(
    String label,
    List<MenuData> history, {
    VoidCallback? onTab,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(3),
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                history.length > 1
                    ? Icons.keyboard_arrow_left_rounded
                    : Icons.close_outlined,
                color: _navigation.darkTheme.value
                    ? ColorPallates.sidebarDarkTextColor
                    : ColorPallates.sidebarLightTextColor,
              ),
            ),
            Expanded(
              child: Text(
                history.length > 1
                    ? 'Back to ${history[history.length - 2].label}'
                    : '$label',
                style: TextStyle(
                  color: _navigation.darkTheme.value
                      ? ColorPallates.sidebarDarkTextColor
                      : ColorPallates.sidebarLightTextColor,
                  fontSize: 16,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        onTap: onTab,
        borderRadius: BorderRadius.circular(50),
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
    );
  }
}
