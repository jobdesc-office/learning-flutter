import 'package:boilerplate/contracts/base/index_view_contract.dart';
import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../middleware/verifyToken.dart';
import '../../../presenters/auth_presenter.dart';
import '../../../presenters/ventes/prospect_detail_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/button/theme_button_create.dart';
import '../../../widgets/datatables/custom_datatable.dart';
import '../../../widgets/snackbar.dart';
import '../../skins/template.dart';
import '_datatable_source.dart';
import '_text.dart';

final authPresenter = Get.find<AuthPresenter>();

class ProspectView extends GetView implements IndexViewContract {
  final presenter = Get.put(ProspectDetailPresenter());
  final presenterdt = Get.find<ProspectDetailPresenter>();
  final datatable = ProspectDataTableSource();

  ProspectView() {
    if (authPresenter.rolepermis.isEmpty) checkJwtToken();
    presenter.prospectViewContract = this;
  }

  @override
  Widget build(BuildContext context) {
    // ignore: invalid_use_of_protected_member
    var permis = authPresenter.rolepermis.value;
    return Scaffold(
      body: TemplateView(
        title: 'Prospects',
        breadcrumbs: [
          BreadcrumbWidget('Ventes'),
          BreadcrumbWidget('Prospect', active: true),
        ],
        activeRoutes: [RouteList.ventes.index, RouteList.ventesProspect.index],
        background: true,
        child: Container(
          child: Column(
            children: [
              CustomDatabales(
                headerActions: [
                  if (permis
                      .where((element) => element.menunm == 'Ventes Datas')
                      .first
                      .children!
                      .where((element) => element.menunm == 'Prospect')
                      .first
                      .features!
                      .where((element) => element.featslug == 'create')
                      .first
                      .permissions!
                      .hasaccess!)
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
    Snackbar().createSuccess(context);
  }

  @override
  void onDeleteSuccess(Response response, {BuildContext? context}) {
    presenter.setProcessing(false);
    datatable.controller.reload();
    Navigator.pop(context!);
    Snackbar().deleteSuccess(context);
  }

  @override
  void onEditSuccess(Response response, {BuildContext? context}) {
    presenter.setProcessing(false);
    datatable.controller.reload();
    Navigator.pop(context!);
    Snackbar().editSuccess(context);
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
        (userid) => presenterdt.details(context, userid);
    datatable.onEditListener = (menuid) => presenter.edit(context, menuid);
    datatable.onDeleteListener =
        (menuid, name) => presenter.delete(context, menuid, name);
  }
}
