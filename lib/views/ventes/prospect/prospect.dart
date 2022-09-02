import 'package:boilerplate/contracts/base/index_view_contract.dart';
import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../presenters/ventes/prospect_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/button/theme_button_create.dart';
import '../../../widgets/datatables/custom_datatable.dart';
import '../../../widgets/snackbar.dart';
import '../../skins/template.dart';
import '_datatable_source.dart';
import '_text.dart';

class ProspectView extends GetView implements IndexViewContract {
  final presenter = Get.put(ProspectPresenter());
  final datatable = ProspectDataTableSource();

  ProspectView() {
    presenter.prospectViewContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        title: 'Prospects',
        breadcrumbs: [
          BreadcrumbWidget('Venteses'),
          BreadcrumbWidget('Prospect', active: true),
        ],
        activeRoutes: [RouteList.ventes.index, RouteList.ventesProspect.index],
        background: true,
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
                serverSide: (params) => presenter.datatables(context, params),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onCreateSuccess(Response response, {BuildContext? context}) {
    presenter.setProcessing(false);
    datatable.controller.reload();
    Navigator.pop(context!);
    Snackbar().createSuccess();
  }

  @override
  void onDeleteSuccess(Response response, {BuildContext? context}) {
    presenter.setProcessing(false);
    datatable.controller.reload();
    Navigator.pop(context!);
    Snackbar().deleteSuccess();
  }

  @override
  void onEditSuccess(Response response, {BuildContext? context}) {
    presenter.setProcessing(false);
    datatable.controller.reload();
    Navigator.pop(context!);
    Snackbar().editSuccess();
  }

  @override
  void onErrorRequest(Response response) {
    presenter.setProcessing(false);
  }

  @override
  void onLoadDatatables(BuildContext context, Response response) {
    presenter.setProcessing(false);
    datatable.response = BsDatatableResponse.createFromJson(response.body);
    datatable.onDetailsListener =
        (userid) => presenter.details(context, userid);
    datatable.onEditListener = (menuid) => presenter.edit(context, menuid);
    datatable.onDeleteListener =
        (menuid, name) => presenter.delete(context, menuid, name);
  }
}
