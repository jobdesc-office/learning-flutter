import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/index_view_contract.dart';
import '../../../presenters/auth_presenter.dart';
import '../../../presenters/masters/country_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/button/button_controller.dart';
import '../../../widgets/button/theme_button_create.dart';
import '../../../widgets/datatables/custom_datatable.dart';
import '../../../widgets/snackbar.dart';
import '../../skins/template.dart';
import '_datatable_source.dart';
import '_text.dart';

class CountryView extends GetView implements IndexViewContract {
  final presenter = Get.find<CountryPresenter>();
  final datatable = CountryDataTableSource();

  final authPresenter = Get.find<AuthPresenter>();

  CountryView() {
    presenter.countryViewContract = this;
  }

  @override
  Widget build(BuildContext context) {
    // ignore: invalid_use_of_protected_member
    var permis = authPresenter.rolepermis.value;
    return Scaffold(
      body: TemplateView(
        title: 'Countries',
        breadcrumbs: [
          BreadcrumbWidget('Masters'),
          BreadcrumbWidget('Countries', active: true),
        ],
        background: true,
        activeRoutes: [RouteList.master.index, RouteList.masterCountry.index],
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
                      .where((element) => element.menunm == 'Regions')
                      .first
                      .children!
                      .where((element) => element.menunm == 'Countries')
                      .first
                      .features!
                      .where((element) => element.featslug == 'create')
                      .first
                      .permissions!
                      .hasaccess!)
                    ThemeButtonCreate(
                      prefix: CountryText.title,
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
    datatable.onEditListener =
        (countryid) => presenter.edit(context, countryid);
    if (btn.btnDeleteDisabled.value)
      datatable.onDeleteListener =
          (countryid, name) => presenter.delete(context, countryid, name);
    else
      datatable.onDeleteListener =
          (countryid, name) => Snackbar().regionDeletePermission();
  }
}
