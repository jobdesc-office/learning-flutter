import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metooltip/metooltip.dart';

import '../../../presenters/navigation_presenter.dart';
import '../../helpers/function.dart';

import 'menu_data.dart';
import 'menu_styles.dart';

class MenuItems extends StatelessWidget {
  MenuItems({
    Key? key,
    required this.data,
    this.styles,
    this.activeRoute = const [],
  }) : super(key: key);

  final MenuData data;

  final MenuStyles? styles;

  final List<String> activeRoute;

  final NavigationPresenter _navigation = Get.find<NavigationPresenter>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          margin: EdgeInsets.only(bottom: 5),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              child: Obx(
                () => Container(
                  padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                  decoration: (_navigation.menuData.value.id == data.id &&
                              _navigation.isHover.value) ||
                          (_navigation.activeRoute.value == data.route)
                      ? _styles.decoration.active
                      : _decoration,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          data.label,
                          style: (_navigation.menuData.value.id == data.id &&
                                      _navigation.isHover.value) ||
                                  (_navigation.dataListOfMenu.value.id ==
                                      data.id) ||
                                  (_navigation.activeRoute.value == data.route)
                              ? _styles.textStyle.active
                              : _textStyle,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      data.children.length == 0
                          ? Container()
                          : Container(
                              child: Icon(
                                Icons.keyboard_arrow_right,
                                color: ((_navigation.menuData.value.id ==
                                                    data.id &&
                                                _navigation.isHover.value) ||
                                            (_navigation.activeRoute.value ==
                                                data.route)
                                        ? _styles.textStyle.active
                                        : _textStyle)
                                    .color,
                                size: 16,
                              ),
                            ),
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(
                          data.icon,
                          size: 24,
                          color: (_navigation.menuData.value.id == data.id &&
                                      _navigation.isHover.value) ||
                                  (_navigation.activeRoute.value == data.route)
                              ? _styles.textStyle.active.color
                              : _textStyle.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              onTap: () {
                if (data.children.length > 0)
                  _navigation.listOfMenu(data);
                else
                  toNameRoute(data.route);

                // _navigation.setRouteActive(data.route);
              },
              onHover: (value) => _navigation.hoverMenu(data, value),
              hoverColor: _styles.decoration.active.color,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        );
      },
    );
  }

  MenuStyles get _styles =>
      this.styles == null ? MenuStyles.dark() : this.styles!;

  Decoration get _decoration => data.active || activeRoute.contains(data.route)
      ? _styles.decoration.active
      : _styles.decoration.nonactive;

  TextStyle get _textStyle => data.active || activeRoute.contains(data.route)
      ? _styles.textStyle.active
      : _styles.textStyle.nonactive;
}

class MenuItemCollapse extends StatelessWidget {
  MenuItemCollapse({
    Key? key,
    required this.data,
    this.styles,
    this.activeRoute = const [],
  }) : super(key: key);

  final MenuData data;

  final MenuStyles? styles;

  final List<String> activeRoute;

  final NavigationPresenter _navigation = Get.find<NavigationPresenter>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          margin: EdgeInsets.only(bottom: 10),
          child: data.children.length > 0
              ? menuWidget(context)
              : MeTooltip(
                  child: menuWidget(context),
                  message: data.label,
                  preferOri: PreferOrientation.right,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.normal,
                    letterSpacing: 0.5,
                    decoration: TextDecoration.none,
                  ),
                ),
        );
      },
    );
  }

  Widget menuWidget(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Obx(
        () => InkWell(
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
            decoration: (_navigation.isHover.value &&
                        _navigation.menuData.value.id == data.id) ||
                    (_navigation.activeRoute.value == data.route) ||
                    (activeRoute.contains(data.route))
                ? _styles.decoration.active
                : _decoration,
            child: Column(
              children: [
                Container(
                  child: Icon(
                    data.icon,
                    size: 24,
                    color: (_navigation.isHover.value &&
                                _navigation.menuData.value.id == data.id) ||
                            (_navigation.activeRoute.value == data.route) ||
                            (activeRoute.contains(data.route))
                        ? _styles.textStyle.active.color
                        : _textStyle.color,
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            if (data.children.length == 0) {
              toNameRoute(data.route);
              _navigation.setRouteActive(data.route);
            }
          },
          onHover: (value) {
            _navigation.hoverMenu(data, value);
            _navigation.closeOverlayMenu();

            if (data.children.length > 0) {
              _navigation.listOfMenuCollapse(context, data);
            }
          },
          hoverColor: _styles.decoration.active.color,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }

  MenuStyles get _styles =>
      this.styles == null ? MenuStyles.dark() : this.styles!;

  Decoration get _decoration => data.active || activeRoute.contains(data.route)
      ? _styles.decoration.active
      : _styles.decoration.nonactive;

  TextStyle get _textStyle => data.active || activeRoute.contains(data.route)
      ? _styles.textStyle.active
      : _styles.textStyle.nonactive;
}
