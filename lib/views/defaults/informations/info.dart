import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/index_view_contract.dart';
import '../../../presenters/default/information_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/datatables/custom_datatable.dart';
import '../../../widgets/snackbar.dart';
import '../../skins/template.dart';
import '_datatable_source.dart';

class InformationView extends GetView implements IndexViewContract {
  final presenter = Get.find<InformationPresenter>();
  final datatable = InformationDataTableSource();

  InformationView() {
    presenter.informationViewContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        title: 'Informations',
        breadcrumbs: [
          BreadcrumbWidget('Settings'),
          BreadcrumbWidget('Informations', active: true),
        ],
        activeRoutes: [
          RouteList.master.index,
          RouteList.settingsInformation.index
        ],
        background: true,
        child: Container(
          child: Column(
            children: [
              CustomDatabales(
                source: datatable,
                columns: datatable.columns,
                // headerActions: [
                //   ThemeButtonCreate(
                //     prefix: InformationText.title,
                //     onPressed: () => presenter.add(context),
                //   )
                // ],
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
    if (context != null) Navigator.pop(context);
    Snackbar().createSuccess(context!);
  }

  @override
  void onDeleteSuccess(Response response, {BuildContext? context}) {
    presenter.setProcessing(false);
    datatable.controller.reload();
    if (context != null) Navigator.pop(context);
    Snackbar().deleteSuccess(context!);
  }

  @override
  void onEditSuccess(Response response, {BuildContext? context}) {
    presenter.setProcessing(false);
    datatable.controller.reload();
    if (context != null) Navigator.pop(context);
    Snackbar().editSuccess(context!);
  }

  @override
  void onErrorRequest(Response response) {
    presenter.setProcessing(false);
  }

  @override
  void onLoadDatatables(BuildContext context, Response response) {
    // final btn = Get.put(ButtonController());
    presenter.setProcessing(false);
    datatable.response = BsDatatableResponse.createFromJson(response.body);
    datatable.onEditListener =
        (informationid) => presenter.edit(context, informationid);

    // if (btn.btnDeleteDisabled.value)
    //   datatable.onDeleteListener = (Informationid, name) =>
    //       presenter.delete(context, Informationid, name);
    // else
    //   datatable.onDeleteListener =
    //       (Informationid, name) => Snackbar().regionDeletePermission();
  }
}
