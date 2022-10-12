import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/index_view_contract.dart';
import '../../../middleware/verifyToken.dart';
import '../../../presenters/auth_presenter.dart';
import '../../../presenters/masters/role_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/button/button_controller.dart';
import '../../../widgets/button/theme_button_create.dart';
import '../../../widgets/datatables/custom_datatable.dart';
import '../../../widgets/snackbar.dart';
import '../../skins/template.dart';
import '_datatable_source.dart';
import '_text.dart';

class RoleView extends GetView implements IndexViewContract {
  final authPresenter = Get.find<AuthPresenter>();
  final presenter = Get.find<RolePresenter>();
  final datatable = RoleDataTableSource();

  RoleView() {
    presenter.typeChildrenViewContract = this;
    if (authPresenter.rolepermis.isEmpty) checkJwtToken();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: invalid_use_of_protected_member
    var permis = authPresenter.rolepermis.value;
    return Scaffold(
      body: TemplateView(
        title: 'Roles',
        breadcrumbs: [
          BreadcrumbWidget('Masters'),
          BreadcrumbWidget('Roles', active: true),
        ],
        activeRoutes: [RouteList.master.index, RouteList.masterRole.index],
        child: Container(
          child: Column(
            children: [
              CustomDatabales(
                source: datatable,
                columns: datatable.columns,
                headerActions: [
                  if (permis
                      .where((element) => element.menunm == 'Master Datas')
                      .first
                      .children!
                      .where((element) => element.menunm == 'Role')
                      .first
                      .features!
                      .where((element) => element.featslug == 'create')
                      .first
                      .permissions!
                      .hasaccess!)
                    ThemeButtonCreate(
                      prefix: RoleText.title,
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
    final btn = Get.put(ButtonController());
    presenter.setProcessing(false);
    datatable.response = BsDatatableResponse.createFromJson(response.body);
    datatable.onEditListener = (roleid) => presenter.edit(context, roleid);

    if (btn.btnDeleteDisabled.value)
      datatable.onDeleteListener =
          (roleid, name) => presenter.delete(context, roleid, name);
    else
      datatable.onDeleteListener =
          (roleid, name) => Snackbar().regionDeletePermission();
  }
}
