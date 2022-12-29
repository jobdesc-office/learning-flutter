import 'package:boilerplate/utils/handle_error_request.dart';
import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/index_view_contract.dart';
import '../../../middleware/verifyToken.dart';
import '../../../presenters/auth_presenter.dart';
import '../../../presenters/masters/businesspartner_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/button/theme_button_create.dart';
import '../../../widgets/datatables/custom_datatable.dart';
import '../../../widgets/snackbar.dart';
import '../../skins/template.dart';
import '_datatable_source.dart';
import '_text.dart';

class BusinessPartnerView extends GetView implements IndexViewContract, HandleErrorRequest {
  final authPresenter = Get.find<AuthPresenter>();
  final presenter = Get.find<BusinessPartnerPresenter>();
  final datatable = BusinessPartnerDataTableSource();

  BusinessPartnerView() {
    presenter.businessPartnerViewContract = this;
    if (authPresenter.rolepermis.isEmpty) checkJwtToken();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: invalid_use_of_protected_member
    var permis = authPresenter.rolepermis.value;
    return Scaffold(
      body: TemplateView(
        title: 'Business Partner',
        breadcrumbs: [
          BreadcrumbWidget('Masters'),
          BreadcrumbWidget('Business Partner', active: true),
        ],
        activeRoutes: [RouteList.master.index, RouteList.masterBusinessPartner.index],
        background: true,
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
                      .where((element) => element.menunm == 'Business Partner')
                      .first
                      .features!
                      .where((element) => element.featslug == 'create')
                      .first
                      .permissions!
                      .hasaccess!)
                    ThemeButtonCreate(
                      prefix: BusinessPartnerText.title,
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
  void onErrorRequest(Response response) {}

  @override
  void onLoadDatatables(BuildContext context, Response response) {
    presenter.setProcessing(false);
    datatable.response = BsDatatableResponse.createFromJson(response.body);
    datatable.onDetailsListener = (bpid) => presenter.details(context, bpid);
    datatable.onEditListener = (bpid) => presenter.edit(context, bpid);
    datatable.onDeleteListener = (bpid, name) => presenter.delete(context, bpid, name);
  }
}
