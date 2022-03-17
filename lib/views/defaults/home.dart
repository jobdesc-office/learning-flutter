import 'package:flutter/material.dart';

import '../../routes/route_list.dart';
import '../../widgets/breadcrumb.dart';
import '../skins/tempalte.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        title: 'Dashboard',
        breadcrumbs: [
          BreadcrumbWidget('Dashboard', active: true),
        ],
        activeRoutes: [RouteList.home.index],
        child: Container(
          child: Text('Dashboard'),
        ),
      ),
    );
  }
}
