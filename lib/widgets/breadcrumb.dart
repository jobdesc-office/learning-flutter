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
    this.route,
  }) : super(key: key);

  final String label;

  final bool active;

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
                  color: this.active ? Colors.grey : Colors.blue,
                ),
              ),
            ],
          ),
          onTap: this.route != null
              ? () {
                  toNameRoute(route!);
                  _navigation.setRouteActive(route!);
                }
              : null,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
      ),
    );
  }
}
