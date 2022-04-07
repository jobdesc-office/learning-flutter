import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/index_view_contract.dart';
import '../../../models/masters/type_model.dart';
import '../../../presenters/masters/typechildren_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../utils/handle_error_request.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/button/theme_button_create.dart';
import '../../../widgets/datatables/custom_datatable.dart';
import '../../skins/tempalte.dart';
import '_datatable_source.dart';
import '_parent_controller.dart';
import 'parents.dart';
import '_text.dart';

class TypesChildrenView extends StatelessWidget
    with IndexViewContract, HandleErrorRequest, ParentViewContract {
  late ParentForm parent;
  final c = Get.put(TypeChildrenSource());
  final presenter = Get.find<TypesChildrenPresenter>();
  final datatable = TypeChildrenDataTableSource();
  final source = TypeChildrenSource().obs;

  TypesChildrenView() {
    presenter.typeChildrenViewContract = this;
    presenter.typeChildrenTypeViewContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        title: TypeChildrenText.title,
        breadcrumbs: [
          BreadcrumbWidget('Dashboard', route: RouteList.home.index),
          BreadcrumbWidget('Masters'),
          BreadcrumbWidget('Type'),
          BreadcrumbWidget('Type Children', active: true),
        ],
        activeRoutes: [
          RouteList.masterTypeChildren.index,
          RouteList.masterTypeChildren.index
        ],
        child: Container(
          child: Column(
            children: [
              Obx(() {
                if (c.isProcessing.isTrue) {
                  datatable.controller.reload();
                  c.isProcessing.toggle();
                }
                parent = ParentForm(source.value);
                return CustomDatabales(
                  source: datatable,
                  columns: datatable.columns,
                  headerActions: [
                    parent.menuType(),
                    // SizedBox(
                    //   width: 10,
                    // ),
                    // ThemeButtonCreate(
                    //   prefix: TypeParentsText.title,
                    //   onPressed: () {},
                    // )
                  ],
                  serverSide: (params) =>
                      presenter.datatables(context, params, c.chosed.value),
                );
              })
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
    datatable.onDetailsListener =
        (typeid) => presenter.details(context, typeid);
  }

  @override
  void onLoadSuccess(Response response) {
    source.update((val) {
      source.value.parentOptionsController.options = List<TypeModel>.from(
        response.body.map((data) {
          return TypeModel.fromJson(data);
        }),
      );
    });
  }
}
