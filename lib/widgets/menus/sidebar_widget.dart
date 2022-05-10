import 'package:boilerplate/styles/color_palattes.dart';
import 'package:flutter/material.dart';

import 'menu_data.dart';

class SidebarWidgets {
  static Widget logo() {
    return Row(
      children: [
        Expanded(
          child: Image.asset('assets/images/logo.png'),
        )
      ],
    );
  }

  static Widget logoCollapse() {
    return Image.asset('assets/images/logo.png');
  }

  static Widget menuParent(List<MenuData> history, {VoidCallback? onTab}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(3),
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(Icons.keyboard_arrow_left_rounded),
            ),
            Text(
              'Back to ${history.length > 1 ? history[history.length - 2].label : 'Main Menu'}',
              style: TextStyle(
                color: Colors.black,
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
                color: ColorPallates.secondary,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(history.length > 1
                  ? Icons.keyboard_arrow_left_rounded
                  : Icons.close_outlined),
            ),
            Expanded(
              child: Text(
                history.length > 1
                    ? 'Back to ${history[history.length - 2].label}'
                    : '$label',
                style: TextStyle(
                  color: ColorPallates.dark,
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
