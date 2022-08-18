import 'package:boilerplate/contracts/base/index_view_contract.dart';
import 'package:boilerplate/widgets/button/theme_button_create.dart';
import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:bs_flutter_modal/bs_flutter_modal.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/details_view_contract.dart';
import '../../../models/security/menu_model.dart';
import '../../../presenters/masters/feature_presenter.dart';
import '../../../presenters/masters/menu_presenter.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../styles/color_palattes.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/button/theme_button_back.dart';
import '../../../widgets/datatables/custom_datatable.dart';
import '../../../widgets/snackbar.dart';
import '../../skins/template.dart';
import '_details_source.dart';
import 'feature/_datatable_source.dart';

part 'menu_detail_component/_desc_part.dart';

final _navigation = Get.find<NavigationPresenter>();

class MenuDetails extends GetView
    implements DetailViewContract, IndexViewContract {
  final MenuPresenter presenter = Get.find<MenuPresenter>();
  final FeaturePresenter featurePresenter = Get.find<FeaturePresenter>();
  final datatable = FeatureDataTableSource();
  final MenuDetailsSource source = Get.put(MenuDetailsSource());

  MenuDetails() {
    Get.delete<MenuDetailsSource>();
    presenter.menuDataDetailsContract = this;
    featurePresenter.featureViewContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        title: 'Menu Details',
        breadcrumbs: [
          BreadcrumbWidget('Masters'),
          BreadcrumbWidget('Menus', back: true),
          BreadcrumbWidget('Menu Details', active: true),
        ],
        activeRoutes: [RouteList.master.index, RouteList.masterMenu.index],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ThemeButtonCreate(
                  onPressed: () =>
                      featurePresenter.add(context, source.id.value),
                  margin: EdgeInsets.only(bottom: 5),
                  prefix: 'Feature',
                ),
                ThemeButtonBack(
                  onPressed: () => Navigator.pop(context),
                  margin: EdgeInsets.only(bottom: 5, left: 5),
                ),
              ],
            ),
            Obx(() => BsRow(
                  children: [
                    BsCol(
                        sizes: ColScreen(lg: Col.col_4),
                        child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: _navigation.darkTheme.value
                                  ? ColorPallates.elseDarkColor
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: _menuDetailsDesc(source))),
                    if (source.id.value != 0)
                      BsCol(
                          margin: EdgeInsets.only(left: 5),
                          sizes: ColScreen(lg: Col.col_8),
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: _navigation.darkTheme.value
                                  ? ColorPallates.elseDarkColor
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: CustomDatabales(
                              source: datatable,
                              columns: datatable.columns,
                              serverSide: (params) => featurePresenter
                                  .datatables(context, params, source.id.value),
                            ),
                          )),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  @override
  void onSuccessFetchData(Response response) {
    MenuModel dt = MenuModel.fromJson(response.body);
    source.id.value = dt.menuid;
    print(source.id.value);
    source.type.value = dt.menutype.typename;
    source.parent.value = dt.parent.menunm;
    source.name.value = dt.menunm;
    source.icon.value = dt.icon;
    source.route.value = dt.route;
    source.color.value = dt.color;
    source.sequence.value = dt.seq.toString();
    presenter.setProcessing(false);
  }

  @override
  void onCreateSuccess(Response response, {BuildContext? context}) {
    featurePresenter.setProcessing(false);
    datatable.controller.reload();
    if (context != null) Navigator.pop(context);
    Snackbar().createSuccess();
  }

  @override
  void onDeleteSuccess(Response response, {BuildContext? context}) {
    featurePresenter.setProcessing(false);
    datatable.controller.reload();
    if (context != null) Navigator.pop(context);
    Snackbar().deleteSuccess();
  }

  @override
  void onEditSuccess(Response response, {BuildContext? context}) {
    featurePresenter.setProcessing(false);
    datatable.controller.reload();
    if (context != null) Navigator.pop(context);
    Snackbar().editSuccess();
  }

  @override
  void onLoadDatatables(BuildContext context, Response response) {
    featurePresenter.setProcessing(false);
    datatable.response = BsDatatableResponse.createFromJson(response.body);
    // datatable.onDetailsListener =
    //     (userid) => featurePresenter.details(context, userid);
    datatable.onEditListener =
        (menuid) => featurePresenter.edit(context, menuid);
    datatable.onDeleteListener =
        (menuid, name) => featurePresenter.delete(context, menuid, name);
  }

  @override
  void onErrorRequest(Response response) {
    // TODO: implement onErrorRequest
  }
}
