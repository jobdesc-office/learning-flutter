import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/index_view_contract.dart';
import '../../../presenters/masters/subdistrict_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/button/button_controller.dart';
import '../../../widgets/button/theme_button_create.dart';
import '../../../widgets/datatables/custom_datatable.dart';
import '../../../widgets/snackbar.dart';
import '../../skins/template.dart';
import '_datatable_source.dart';
import '_text.dart';

class SubdistrictView extends GetView implements IndexViewContract {
  final presenter = Get.find<SubdistrictPresenter>();
  final datatable = SubdistrictDataTableSource();

  SubdistrictView() {
    presenter.subdistrictViewContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        title: 'Subdistricts',
        breadcrumbs: [
          BreadcrumbWidget('Masters'),
          BreadcrumbWidget('Subdistricts', active: true),
        ],
        background: true,
        activeRoutes: [
          RouteList.master.index,
          RouteList.masterSubdistrict.index
        ],
        child: Container(
          child: Column(
            children: [
              CustomDatabales(
                source: datatable,
                columns: datatable.columns,
                headerActions: [
                  ThemeButtonCreate(
                    prefix: SubdistrictText.title,
                    onPressed: () => presenter.add(context),
                  )
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
    presenter.setProcessing(false);
    datatable.controller.reload();
    if (context != null) Navigator.pop(context);
    Snackbar().createSuccess();
  }

  @override
  void onDeleteSuccess(Response response, {BuildContext? context}) {
    presenter.setProcessing(false);
    datatable.controller.reload();
    if (context != null) Navigator.pop(context);
    Snackbar().deleteSuccess();
  }

  @override
  void onEditSuccess(Response response, {BuildContext? context}) {
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
    final btn = Get.put(ButtonController());
    presenter.setProcessing(false);
    datatable.response = BsDatatableResponse.createFromJson(response.body);
    datatable.onEditListener =
        (subdistrictid) => presenter.edit(context, subdistrictid);

    if (btn.btnDeleteDisabled.value)
      datatable.onDeleteListener = (subdistrictid, name) =>
          presenter.delete(context, subdistrictid, name);
    else
      datatable.onDeleteListener =
          (subdistrictid, name) => Snackbar().regionDeletePermission();
  }
}
