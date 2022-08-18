import 'package:boilerplate/models/masters/type_model.dart';
import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../contracts/base/index_view_contract.dart';
import '../../../../presenters/settings/permission_presenter.dart';
import '../../../../routes/route_list.dart';
import '../../../../widgets/breadcrumb.dart';
import '../../../../widgets/button/button_controller.dart';
import '../../../../widgets/button/theme_button_create.dart';
import '../../../../widgets/datatables/custom_datatable.dart';
import '../../../../widgets/snackbar.dart';
import '../../../../widgets/snackbar.dart';
import '../../../skins/template.dart';
import '_datatable_source.dart';
import '../_permission_source.dart';
import '../_text.dart';

final source = Get.put(PermissionSource());

class PermissionRoleView extends GetView implements IndexViewContract {
  final presenter = Get.find<PermissionPresenter>();
  final datatable = PermissionRoleDataTableSource();

  PermissionRoleView() {
    Get.delete<PermissionSource>();
    presenter.PermissionViewContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        title: 'Permissions',
        breadcrumbs: [
          BreadcrumbWidget('Settings'),
          BreadcrumbWidget('Permissions', active: true),
        ],
        activeRoutes: [
          RouteList.master.index,
          RouteList.settingsPermission.index
        ],
        child: Container(
          child: Column(
            children: [
              CustomDatabales(
                source: datatable,
                columns: datatable.columns,
                serverSide: (params) => presenter.datatables(context),
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
    presenter.setProcessing(false);
    List<TypeModel> role = [];
    for (var item in response.body) {
      role.add(TypeModel.fromJson(item));
    }
    source.role.value = role;
    datatable.addAll(role);
    datatable.onDeleteListener = (roleid, rolename) {
      source.rolename.value = rolename;
      presenter.menu(context, roleid);
    };
  }
}
