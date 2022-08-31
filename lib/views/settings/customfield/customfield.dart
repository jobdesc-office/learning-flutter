import 'package:boilerplate/contracts/base/index_view_contract.dart';
import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../presenters/settings/customfield_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/datatables/custom_datatable.dart';
import '../../../widgets/map/_map_source.dart';
import '../../../widgets/snackbar.dart';
import '../../skins/template.dart';
import '_datatable_source.dart';

class CustomFieldView extends GetView implements IndexViewContract {
  final presenter = Get.find<CustomFieldPresenter>();
  final datatable = CustomFieldDataTableSource();

  CustomFieldView() {
    presenter.customFieldViewContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        title: 'Custom Fields',
        breadcrumbs: [
          BreadcrumbWidget('Settings'),
          BreadcrumbWidget('Custom Fields', active: true),
        ],
        activeRoutes: [
          RouteList.master.index,
          RouteList.settingsCustomField.index
        ],
        child: Container(
          child: Column(
            children: [
              CustomDatabales(
                source: datatable,
                columns: datatable.columns,
                headerActions: [
                  // ThemeButtonCreate(
                  //   prefix: CustomFieldText.title,
                  //   onPressed: () => presenter.add(context),
                  // )
                ],
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
    presenter.setProcessing(false);
    datatable.response = BsDatatableResponse.createFromJson(response.body);
    datatable.onDetailsListener =
        (userid) => presenter.details(context, userid);
    datatable.onEditListener =
        (countryid) => presenter.edit(context, countryid);
    datatable.onDeleteListener =
        (cstmid, name) => presenter.delete(context, cstmid, name);
  }
}
