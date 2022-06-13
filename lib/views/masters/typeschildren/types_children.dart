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
import '../../../widgets/button/theme_button_search.dart';
import '../../../widgets/datatables/custom_datatable.dart';
import '../../../widgets/snackbar.dart';
import '../../skins/template.dart';
import '_datatable_source.dart';
import '_parent_controller.dart';
import 'parents.dart';
import '_text.dart';

class TypesChildrenView extends StatelessWidget
    with IndexViewContract, HandleErrorRequest, ParentViewContract {
  late ParentForm parent;
  final controller = Get.put(ParentSource());
  final presenter = Get.find<TypesChildrenPresenter>();
  final datatable = TypeChildrenDataTableSource();
  final source = ParentSource().obs;

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
          BreadcrumbWidget('Type Data', active: true),
        ],
        activeRoutes: [
          RouteList.masterTypeChildren.index,
          RouteList.masterTypeChildren.index
        ],
        child: Container(
          child: Column(
            children: [
              Obx(() {
                if (controller.isProcessing.isTrue) {
                  datatable.controller.reload();
                  controller.isProcessing.toggle();
                }
                parent = ParentForm(source.value);
                return CustomDatabales(
                  source: datatable,
                  columns: datatable.columns,
                  headerActions: [
                    ThemeButtonSearch(
                      onPressed: () => presenter.filter(context),
                    ),
                    // SizedBox(
                    //   width: 10,
                    // ),
                    // parent.menuType(),
                    SizedBox(
                      width: 10,
                    ),
                    ThemeButtonCreate(
                      prefix: TypeChildrenText.title,
                      onPressed: () => presenter.add(context),
                    )
                  ],
                  serverSide: (params) => controller.chosed == 0
                      ? presenter.datatablesNonFilter(context, params)
                      : presenter.datatables(
                          context, params, controller.chosed.value),
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
  void onLoadDatatables(BuildContext context, Response response) {
    presenter.setProcessing(false);
    datatable.response = BsDatatableResponse.createFromJson(response.body);
    datatable.onDetailsListener =
        (typeid) => presenter.details(context, typeid);
    datatable.onEditListener = (typeid) => presenter.edit(context, typeid);
    datatable.onDeleteListener =
        (typeid, name) => presenter.delete(context, typeid, name);
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
