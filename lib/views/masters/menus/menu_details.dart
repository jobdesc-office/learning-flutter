import 'package:bs_flutter_modal/bs_flutter_modal.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/details_view_contract.dart';
import '../../../models/security/menu_model.dart';
import '../../../presenters/masters/menu_presenter.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../styles/color_palattes.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/button/theme_button_back.dart';
import '../../skins/template.dart';
import '_details_source.dart';

final _navigation = Get.find<NavigationPresenter>();

class MenuDetails extends GetView implements DetailViewContract {
  final MenuPresenter presenter = Get.find<MenuPresenter>();
  final MenuDetailsSource controller = Get.put(MenuDetailsSource());

  MenuDetails() {
    Get.delete<MenuDetailsSource>();
    presenter.menuDataDetailsContract = this;
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
            ThemeButtonBack(
              onPressed: () => Navigator.pop(context),
              margin: EdgeInsets.only(bottom: 5),
            ),
            Obx(() => Container(
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
                          sizes: ColScreen(lg: Col.col_12),
                          child: BsRow(
                            children: [
                              BsCol(
                                  sizes: ColScreen(lg: Col.col_3),
                                  child: Text('Type')),
                              BsCol(
                                  sizes: ColScreen(lg: Col.col_1),
                                  child: Text(':')),
                              BsCol(
                                  sizes: ColScreen(lg: Col.col_8),
                                  child: Text(controller.type.value))
                            ],
                          )),
                      BsCol(
                          margin: EdgeInsets.only(top: 5),
                          sizes: ColScreen(lg: Col.col_12),
                          child: BsRow(
                            children: [
                              BsCol(
                                  sizes: ColScreen(lg: Col.col_3),
                                  child: Text('Parent')),
                              BsCol(
                                  sizes: ColScreen(lg: Col.col_1),
                                  child: Text(':')),
                              BsCol(
                                  sizes: ColScreen(lg: Col.col_8),
                                  child: Text(controller.parent.value))
                            ],
                          )),
                      BsCol(
                          margin: EdgeInsets.only(top: 5),
                          sizes: ColScreen(lg: Col.col_12),
                          child: BsRow(
                            children: [
                              BsCol(
                                  sizes: ColScreen(lg: Col.col_3),
                                  child: Text('Name')),
                              BsCol(
                                  sizes: ColScreen(lg: Col.col_1),
                                  child: Text(':')),
                              BsCol(
                                  sizes: ColScreen(lg: Col.col_8),
                                  child: Text(controller.name.value))
                            ],
                          )),
                      BsCol(
                          margin: EdgeInsets.only(top: 5),
                          sizes: ColScreen(lg: Col.col_12),
                          child: BsRow(
                            children: [
                              BsCol(
                                  sizes: ColScreen(lg: Col.col_3),
                                  child: Text('Icon')),
                              BsCol(
                                  sizes: ColScreen(lg: Col.col_1),
                                  child: Text(':')),
                              BsCol(
                                  sizes: ColScreen(lg: Col.col_8),
                                  child: Text(controller.icon.value))
                            ],
                          )),
                      BsCol(
                          margin: EdgeInsets.only(top: 5),
                          sizes: ColScreen(lg: Col.col_12),
                          child: BsRow(
                            children: [
                              BsCol(
                                  sizes: ColScreen(lg: Col.col_3),
                                  child: Text('Route')),
                              BsCol(
                                  sizes: ColScreen(lg: Col.col_1),
                                  child: Text(':')),
                              BsCol(
                                  sizes: ColScreen(lg: Col.col_8),
                                  child: Text(controller.route.value))
                            ],
                          )),
                      BsCol(
                          margin: EdgeInsets.only(top: 5),
                          sizes: ColScreen(lg: Col.col_12),
                          child: BsRow(
                            children: [
                              BsCol(
                                  sizes: ColScreen(lg: Col.col_3),
                                  child: Text('Color')),
                              BsCol(
                                  sizes: ColScreen(lg: Col.col_1),
                                  child: Text(':')),
                              BsCol(
                                  sizes: ColScreen(lg: Col.col_8),
                                  child: Text(controller.color.value))
                            ],
                          )),
                      BsCol(
                          margin: EdgeInsets.only(top: 5),
                          sizes: ColScreen(lg: Col.col_12),
                          child: BsRow(
                            children: [
                              BsCol(
                                  sizes: ColScreen(lg: Col.col_3),
                                  child: Text('Sequence')),
                              BsCol(
                                  sizes: ColScreen(lg: Col.col_1),
                                  child: Text(':')),
                              BsCol(
                                  sizes: ColScreen(lg: Col.col_8),
                                  child: Text(controller.sequence.value))
                            ],
                          )),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  @override
  void onSuccessFetchData(Response response) {
    MenuModel dt = MenuModel.fromJson(response.body);
    controller.type.value = dt.menutype.typename;
    controller.parent.value = dt.parent.menunm;
    controller.name.value = dt.menunm;
    controller.icon.value = dt.icon;
    controller.route.value = dt.route;
    controller.color.value = dt.color;
    controller.sequence.value = dt.seq.toString();
    presenter.setProcessing(false);
  }
}
