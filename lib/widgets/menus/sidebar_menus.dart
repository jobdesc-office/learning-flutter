import 'package:flutter/material.dart';

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
    return Container(
      margin: isCollapse ? EdgeInsets.only(top: 10) : EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Scrollbar(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: this
                    .menus
                    .map(
                      (data) => Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            isCollapse || data.title == null
                                ? Container()
                                : Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(right: 5),
                                          child: Icon(
                                            data.icon,
                                            size: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            data.title!.toUpperCase(),
                                            style: TextStyle(
                                              color: Color.fromARGB(255, 56, 52, 52),
                                              fontSize: 9,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 1.2,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
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
