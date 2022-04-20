import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/route_list.dart';
import '../../../widgets/breadcrumb.dart';
import '../../skins/tempalte.dart';

class ProspectView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        title: 'Prospect',
        breadcrumbs: [
          BreadcrumbWidget('Dashboard', route: RouteList.home.index),
          BreadcrumbWidget('Venteses'),
          BreadcrumbWidget('Prospect', active: true),
        ],
        activeRoutes: [RouteList.ventes.index, RouteList.ventesProspect.index],
        child: Container(
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
