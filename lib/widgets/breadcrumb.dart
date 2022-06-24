import 'package:boilerplate/styles/color_palattes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helpers/function.dart';
import '../presenters/navigation_presenter.dart';

class Breadcrumbs {}

class BreadcrumbWidget extends StatelessWidget {
  BreadcrumbWidget(
    this.label, {
    Key? key,
    this.active = false,
    this.back = false,
    this.route,
  }) : super(key: key);

  final String label;

  final bool active;

  final bool back;

  final String? route;

  final NavigationPresenter _navigation = Get.find<NavigationPresenter>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          child: Row(
            children: [
              Text(
                this.label,
                style: TextStyle(
                  fontSize: 12,
                  color: this.active ? ColorPallates.tertiary : Colors.grey,
                ),
              ),
            ],
          ),
          onTap: this.route != null
              ? () {
                  toNameRoute(route!);
                  _navigation.setRouteActive(route!);
                }
              : () => this.back ? Navigator.pop(context) : null,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
      ),
    );
  }
}
