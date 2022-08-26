import 'package:boilerplate/contracts/base/index_view_contract.dart';
import 'package:boilerplate/middleware/verifyToken.dart';
import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../presenters/auth_presenter.dart';
import '../../../presenters/masters/customer_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/button/theme_button_create.dart';
import '../../../widgets/datatables/custom_datatable.dart';
import '../../../widgets/map/_map_source.dart';
import '../../../widgets/snackbar.dart';
import '../../skins/template.dart';
import '_datatable_source.dart';
import '_text.dart';

class CustomerView extends GetView implements IndexViewContract {
  final authPresenter = Get.find<AuthPresenter>();
  final presenter = Get.find<CustomerPresenter>();
  final datatable = CustomerDataTableSource();
  final map = Get.put(MapSource());

  CustomerView() {
    presenter.customerViewContract = this;
    if (authPresenter.rolepermis.value == []) checkJwtToken();
  }

  @override
  Widget build(BuildContext context) {
    var permis = authPresenter.rolepermis.value;
    return Scaffold(
      body: TemplateView(
        title: 'Customers',
        breadcrumbs: [
          BreadcrumbWidget('Masters'),
          BreadcrumbWidget('Customers', active: true),
        ],
        activeRoutes: [RouteList.master.index, RouteList.masterCustomer.index],
        child: Container(
          child: Column(
            children: [
              // if (permis
              //     .where((element) => element.menu?.menunm == 'Customers')
              //     .where((element) => element.feature?.feattitle == 'Read')
              //     .first
              //     .hasaccess!)
              CustomDatabales(
                source: datatable,
                columns: datatable.columns,
                headerActions: [
                  // if (permis
                  //     .where((element) => element.menu?.menunm == 'Customers')
                  //     .where(
                  //         (element) => element.feature?.feattitle == 'Create')
                  //     .first
                  //     .hasaccess!)
                  ThemeButtonCreate(
                    prefix: CustomerText.title,
                    onPressed: () => presenter.add(context),
                  )
                ],
                serverSide: (params) => presenter.datatables(context, params),
                // searchHintText: 'Search by customer name, customer phone ...',
              )
              // else
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Center(
              //       child: Text(
              //           'You Don\'t Have Permission to Read ${CustomerText.title}'),
              //     )
              //   ],
              // )
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
    final map = Get.find<MapSource>();
    presenter.setProcessing(false);
    map.reset();
    datatable.response = BsDatatableResponse.createFromJson(response.body);
    datatable.onDetailsListener =
        (userid) => presenter.details(context, userid);
    datatable.onEditListener =
        (countryid) => presenter.edit(context, countryid);
    datatable.onDeleteListener =
        (cstmid, cstmname) => presenter.delete(context, cstmid, cstmname);
  }
}
