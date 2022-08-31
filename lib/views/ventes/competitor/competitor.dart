import 'package:boilerplate/contracts/base/index_view_contract.dart';
import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../presenters/ventes/competitor_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/button/theme_button_create.dart';
import '../../../widgets/datatables/custom_datatable.dart';
import '../../../widgets/map/_map_source.dart';
import '../../../widgets/snackbar.dart';
import '../../skins/template.dart';
import '_datatable_source.dart';
import '_text.dart';

class CompetitorView extends GetView implements IndexViewContract {
  final presenter = Get.find<CompetitorPresenter>();
  final datatable = CompetitorDataTableSource();
  final map = Get.put(MapSource());

  CompetitorView() {
    presenter.competitorViewContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        title: 'Competitors',
        breadcrumbs: [
          BreadcrumbWidget('Venteses'),
          BreadcrumbWidget('Competitors', active: true),
        ],
        activeRoutes: [
          RouteList.ventes.index,
          RouteList.ventesCompetitor.index
        ],
        child: Container(
          child: Column(
            children: [
              CustomDatabales(
                source: datatable,
                columns: datatable.columns,
                headerActions: [
                  ThemeButtonCreate(
                    prefix: CompetitorText.title,
                    onPressed: () => presenter.add(context),
                  )
                ],
                serverSide: (params) => presenter.datatablesbp(context, params),
                // searchHintText: 'Search by Competitor name, Competitor phone ...',
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onCreateSuccess(Response response, {BuildContext? context}) {
    final map = Get.find<MapSource>();
    map.reset();
    presenter.setProcessing(false);
    datatable.controller.reload();
    if (context != null) Navigator.pop(context);
    Snackbar().createSuccess();
  }

  @override
  void onDeleteSuccess(Response response, {BuildContext? context}) {
    final map = Get.find<MapSource>();
    map.reset();
    presenter.setProcessing(false);
    datatable.controller.reload();
    if (context != null) Navigator.pop(context);
    Snackbar().deleteSuccess();
  }

  @override
  void onEditSuccess(Response response, {BuildContext? context}) {
    final map = Get.find<MapSource>();
    map.reset();
    presenter.setProcessing(false);
    datatable.controller.reload();
    if (context != null) Navigator.pop(context);
    Snackbar().editSuccess();
  }

  @override
  void onErrorRequest(Response response) {
    presenter.setProcessing(false);
  }

  @override
  void onLoadDatatables(BuildContext context, Response response) {
    final map = Get.find<MapSource>();
    presenter.setProcessing(false);
    map.reset();
    datatable.response = BsDatatableResponse.createFromJson(response.body);
    datatable.onDetailsListener =
        (userid) => presenter.details(context, userid);
    datatable.onEditListener =
        (countryid) => presenter.edit(context, countryid);
    datatable.onDeleteListener =
        (cstmid, cstmname) => presenter.delete(context, cstmid, cstmname);
  }
}
