import 'package:boilerplate/models/masters/user_model.dart';
import 'package:boilerplate/utils/handle_error_request.dart';
import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/index_view_contract.dart';
import '../../../contracts/master/userReset_contract.dart';
import '../../../presenters/masters/user_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/button/theme_button_create.dart';
import '../../../widgets/datatables/custom_datatable.dart';
import '../../../widgets/snackbar.dart';
import '../../skins/template.dart';
import '_datatable_source.dart';
import '_form_source.dart';
import '_text.dart';

// ignore: must_be_immutable
class UserView extends GetView
    implements IndexViewContract, HandleErrorRequest, UserResetContract {
  final presenter = Get.find<UserPresenter>();
  late UserDataTableSource datatable;
  final UserSource c = Get.put(UserSource());

  UserView() {
    presenter.userViewContract = this;
    presenter.userResetContract = this;
    datatable = UserDataTableSource();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        title: 'Users',
        breadcrumbs: [
          BreadcrumbWidget('Masters'),
          BreadcrumbWidget('Users', active: true),
        ],
        activeRoutes: [RouteList.master.index, RouteList.masterUser.index],
        background: true,
        child: Container(
          child: Column(
            children: [
              CustomDatabales(
                source: datatable,
                columns: datatable.columns,
                headerActions: [
                  ThemeButtonCreate(
                    prefix: UserText.title,
                    onPressed: () => presenter.add(context),
                  )
                ],
                serverSide: (params) => presenter.datatablesbp(context, params),
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
    c.isAdd = true;
    presenter.setProcessing(false);
    datatable.controller.reload();
    if (context != null) Navigator.pop(context);
    Snackbar().editSuccess(context!);
  }

  @override
  void onErrorRequest(Response response, {context}) {
    presenter.setProcessing(false);
    if (context != null) Navigator.pop(context);
    Snackbar().createFailed(context!, response.body['message']);
  }

  @override
  void onLoadDatatables(BuildContext context, Response response) {
    presenter.setProcessing(false);
    datatable.response = BsDatatableResponse.createFromJson(response.body);
    datatable.onDetailsListener =
        (userid) => presenter.details(context, userid);
    datatable.onEditListener = (userid) => presenter.edit(context, userid);
    datatable.onDeleteListener =
        (userid, name) => presenter.delete(context, userid, name);
  }

  @override
  void onResetSuccess(Response response, {BuildContext? context}) {
    c.isAdd = true;
    presenter.setProcessing(false);
    datatable.controller.reload();
    if (context != null) Navigator.pop(context);
    Snackbar().resetSuccess();
  }
}
