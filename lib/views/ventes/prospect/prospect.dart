import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../presenters/ventes/prospect_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/button/theme_button_create.dart';
import '../../../widgets/datatables/custom_datatable.dart';
import '../../skins/tempalte.dart';
import '_datatable_source.dart';
import '_text.dart';

class ProspectView extends GetView {
  final presenter = Get.put(ProspectPresenter());
  final datatable = ProspectDataTableSource();
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
            children: [
              CustomDatabales(
                headerActions: [
                  ThemeButtonCreate(
                      prefix: ProspectText.title,
                      onPressed: () => presenter.add(context)),
                ],
                source: datatable,
                columns: datatable.columns,
              )
            ],
          ),
        ),
      ),
    );
  }
}
