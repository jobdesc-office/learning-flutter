import 'package:boilerplate/contracts/base/index_view_contract.dart';
import 'package:boilerplate/widgets/button/theme_button_create.dart';
import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
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
import '../../../widgets/datatables/custom_datatable.dart';
import '../../../widgets/form_group.dart';
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
  final source = Get.put(MenuDetailsSource());

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
        back: true,
        activeRoutes: [RouteList.master.index, RouteList.masterMenu.index],
        child: Obx(() => BsRow(
              children: [
                BsCol(
                    sizes: ColScreen(lg: Col.col_4),
                    child: Column(
                      children: [
                        Container(
                            height: MediaQuery.of(context).size.height,
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: _navigation.darkTheme.value
                                  ? ColorPallates.elseDarkColor
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: _menuDetailsDesc(source)),
                        Container(
                            margin: EdgeInsets.only(top: 5),
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: _navigation.darkTheme.value
                                  ? ColorPallates.elseDarkColor
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: BsRow(
                              children: [
                                BsCol(
                                  child: FormGroup(
                                      label: Text('Created By',
                                          style: TextStyle(
                                              color: _navigation.darkTheme.value
                                                  ? Colors.white
                                                  : Colors.black)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(source.createdby.value),
                                          Divider()
                                        ],
                                      )),
                                ),
                                BsCol(
                                  margin: EdgeInsets.only(top: 10),
                                  child: FormGroup(
                                      label: Text('Created At',
                                          style: TextStyle(
                                              color: _navigation.darkTheme.value
                                                  ? Colors.white
                                                  : Colors.black)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(source.createddate.value),
                                          Divider()
                                        ],
                                      )),
                                ),
                                BsCol(
                                  margin: EdgeInsets.only(top: 10),
                                  child: FormGroup(
                                      label: Text('Last Updated By',
                                          style: TextStyle(
                                              color: _navigation.darkTheme.value
                                                  ? Colors.white
                                                  : Colors.black)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(source.updatedby.value),
                                          Divider()
                                        ],
                                      )),
                                ),
                                BsCol(
                                  margin: EdgeInsets.only(top: 10),
                                  child: FormGroup(
                                      label: Text('Last Updated At',
                                          style: TextStyle(
                                              color: _navigation.darkTheme.value
                                                  ? Colors.white
                                                  : Colors.black)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(source.updateddate.value),
                                          Divider()
                                        ],
                                      )),
                                ),
                                BsCol(
                                  margin: EdgeInsets.only(top: 10),
                                  child: FormGroup(
                                      label: Text('Is Active',
                                          style: TextStyle(
                                              color: _navigation.darkTheme.value
                                                  ? Colors.white
                                                  : Colors.black)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if (source.isactive.value)
                                            Card(
                                              color: Colors.green,
                                              child: Text('Active',
                                                  style: TextStyle(
                                                      color: _navigation
                                                              .darkTheme.value
                                                          ? Colors.white
                                                          : Colors.black)),
                                            )
                                          else
                                            Card(
                                              color: Colors.red,
                                              child: Text('Not Active',
                                                  style: TextStyle(
                                                      color: _navigation
                                                              .darkTheme.value
                                                          ? Colors.white
                                                          : Colors.black)),
                                            ),
                                          Divider()
                                        ],
                                      )),
                                ),
                              ],
                            )),
                      ],
                    )),
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
                          headerActions: [
                            ThemeButtonCreate(
                              onPressed: () => featurePresenter.add(
                                  context, source.id.value),
                              margin: EdgeInsets.only(bottom: 5),
                              prefix: 'Feature',
                            ),
                          ],
                          serverSide: (params) => featurePresenter.datatables(
                              context, params, source.id.value),
                        ),
                      )),
              ],
            )),
      ),
    );
  }

  @override
  void onSuccessFetchData(Response response) {
    MenuModel dt = MenuModel.fromJson(response.body);
    source.id.value = dt.menuid!;
    source.type.value = dt.menutype?.typename ?? '';
    source.parent.value = dt.parent?.menunm ?? '';
    source.name.value = dt.menunm ?? '';
    source.icon.value = dt.menuicon ?? '';
    source.route.value = dt.menuroute ?? '';
    source.color.value = dt.menucolor ?? '';
    source.sequence.value = dt.menuseq.toString();

    source.createdby.value = dt.menucreatedby?.userfullname ?? '';
    source.createddate.value = dt.createddate ?? '';
    source.updatedby.value = dt.menucreatedby?.userfullname ?? '';
    source.updateddate.value = dt.updateddate ?? '';
    source.isactive.value = dt.isactive ?? false;
    presenter.setProcessing(false);
  }

  @override
  void onCreateSuccess(Response response, {BuildContext? context}) {
    featurePresenter.setProcessing(false);
    datatable.controller.reload();
    if (context != null) Navigator.pop(context);
    Snackbar().createSuccess(context!);
  }

  @override
  void onDeleteSuccess(Response response, {BuildContext? context}) {
    featurePresenter.setProcessing(false);
    datatable.controller.reload();
    if (context != null) Navigator.pop(context);
    Snackbar().deleteSuccess(context!);
  }

  @override
  void onEditSuccess(Response response, {BuildContext? context}) {
    featurePresenter.setProcessing(false);
    datatable.controller.reload();
    if (context != null) Navigator.pop(context);
    Snackbar().editSuccess(context!);
  }

  @override
  void onLoadDatatables(BuildContext context, Response response) {
    featurePresenter.setProcessing(false);
    datatable.response = BsDatatableResponse.createFromJson(response.body);
    datatable.onDetailsListener =
        (userid) => featurePresenter.details(context, userid);
    datatable.onEditListener =
        (menuid) => featurePresenter.edit(context, menuid);
    datatable.onDeleteListener =
        (menuid, name) => featurePresenter.delete(context, menuid, name);
  }

  @override
  void onErrorRequest(Response response) {}
}
