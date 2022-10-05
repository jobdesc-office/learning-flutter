import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../presenters/navigation_presenter.dart';
import '../../widgets/breadcrumb.dart';

import 'content.dart';
import 'header.dart';
import 'sidebar.dart';

class TemplateView extends StatelessWidget {
  TemplateView({
    Key? key,
    this.child,
    this.title,
    this.breadcrumbs = const [],
    this.activeRoutes = const [],
    this.back = false,
    this.titlebg = true,
    this.background = false,
    this.widget,
  }) : super(key: key);

  final Widget? child;

  final String? title;

  final List<BreadcrumbWidget> breadcrumbs;

  final List<String> activeRoutes;

  final bool back;

  final bool titlebg;

  final bool background;

  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    final _navigation = Get.find<NavigationPresenter>();
    return Scaffold(
      body: GestureDetector(
        onTap: () {},
        child: Obx(() => Container(
              decoration: BoxDecoration(
                color: _navigation.darkTheme.value
                    ? Color(0xff454D55)
                    : Color(0xfff1f1f1),
              ),
              child: Row(
                children: [
                  SidebarSkins(activeRoute: activeRoutes),
                  Expanded(
                    child: Column(
                      children: [
                        HeaderSkins(),
                        Expanded(
                          child: ContentSkins(
                            title: this.title,
                            child: this.child,
                            breadcrumbs: this.breadcrumbs,
                            back: this.back,
                            titlebg: this.titlebg,
                            background: this.background,
                            widget: widget,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
