import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/index_view_contract.dart';
import '../../../presenters/masters/typeparent_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../utils/handle_error_request.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/button/theme_button_create.dart';
import '../../../widgets/datatables/custom_datatable.dart';
import '../../skins/tempalte.dart';
import '_datatable_source.dart';
import '_text.dart';

class TypesParentView extends StatelessWidget
    with IndexViewContract, HandleErrorRequest {
  final presenter = Get.find<TypeParentPresenter>();
  final datatable = TypeParentDataTableSource();

  TypesParentView() {
    presenter.typeParentViewContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        title: TypeParentsText.title,
        breadcrumbs: [
          BreadcrumbWidget('Dashboard', route: RouteList.home.index),
          BreadcrumbWidget('Masters'),
          BreadcrumbWidget('Type'),
          BreadcrumbWidget('Type Parent', active: true),
        ],
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
                // headerActions: [
                //   ThemeButtonCreate(
                //     prefix: TypeParentsText.title,
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
    // TODO: implement onCreateSuccess
  }

  @override
  void onDeleteSuccess(Response response, {BuildContext? context}) {
    // TODO: implement onDeleteSuccess
  }

  @override
  void onEditSuccess(Response response, {BuildContext? context}) {
    // TODO: implement onEditSuccess
  }

  @override
  void onLoadDatatables(BuildContext context, Response response) {
    presenter.setProcessing(false);
    datatable.response = BsDatatableResponse.createFromJson(response.body);
  }
}
