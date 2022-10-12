import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/index_view_contract.dart';
import '../../../presenters/auth_presenter.dart';
import '../../../presenters/masters/typeparent_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../utils/handle_error_request.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/button/button_controller.dart';
import '../../../widgets/button/theme_button_create.dart';
import '../../../widgets/datatables/custom_datatable.dart';
import '../../../widgets/snackbar.dart';
import '../../skins/template.dart';
import '_datatable_source.dart';
import '_text.dart';

class TypesParentView extends StatelessWidget
    with IndexViewContract, HandleErrorRequest {
  final presenter = Get.find<TypeParentPresenter>();
  final datatable = TypeParentDataTableSource();

  final authPresenter = Get.find<AuthPresenter>();

  TypesParentView() {
    presenter.typeParentViewContract = this;
  }

  @override
  Widget build(BuildContext context) {
    // ignore: invalid_use_of_protected_member
    var permis = authPresenter.rolepermis.value;
    return Scaffold(
      body: TemplateView(
        title: TypeParentsText.title,
        breadcrumbs: [
          BreadcrumbWidget('Masters'),
          BreadcrumbWidget('Type'),
          BreadcrumbWidget('Type Parent', active: true),
        ],
        background: true,
        activeRoutes: [
          RouteList.masterTypeParent.index,
          RouteList.masterTypeParent.index
        ],
        child: Container(
          child: Column(
            children: [
              CustomDatabales(
                source: datatable,
                columns: datatable.columns,
                headerActions: [
                  if (permis
                      .where((element) => element.menunm == 'Settings')
                      .first
                      .children!
                      .where((element) => element.menunm == 'Types')
                      .first
                      .children!
                      .where((element) => element.menunm == 'Type Parents')
                      .first
                      .features!
                      .where((element) => element.featslug == 'create')
                      .first
                      .permissions!
                      .hasaccess!)
                    ThemeButtonCreate(
                      prefix: TypeParentsText.title,
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
  void onLoadDatatables(BuildContext context, Response response) {
    final btn = Get.put(ButtonController());
    presenter.setProcessing(false);
    datatable.response = BsDatatableResponse.createFromJson(response.body);
    datatable.onDetailsListener =
        (typeid) => presenter.details(context, typeid);
    datatable.onEditListener = (typeid) => presenter.edit(context, typeid);
    if (btn.btnDeleteDisabled.value)
      datatable.onDeleteListener =
          (typeid, name) => presenter.delete(context, typeid, name);
    else
      datatable.onDeleteListener =
          (typeid, name) => Snackbar().regionDeletePermission();
  }
}
