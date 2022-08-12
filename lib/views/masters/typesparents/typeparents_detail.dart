import 'package:bs_flutter_modal/bs_flutter_modal.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/details_view_contract.dart';
import '../../../models/masters/type_model.dart';
import '../../../presenters/masters/typeparent_presenter.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../styles/color_palattes.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/button/theme_button_back.dart';
import '../../skins/template.dart';
import '_detail_source.dart';
import '_text.dart';

final _navigation = Get.find<NavigationPresenter>();

class TypeParentDetails extends GetView implements DetailViewContract {
  final TypeParentPresenter presenter = Get.find<TypeParentPresenter>();
  final TypeParentDetailsSource controller = Get.put(TypeParentDetailsSource());

  TypeParentDetails() {
    Get.delete<TypeParentDetailsSource>();
    presenter.typeParentDataDetailsContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        title: TypeParentsText.title + ' Details',
        breadcrumbs: [
          BreadcrumbWidget('Masters'),
          BreadcrumbWidget('Type'),
          BreadcrumbWidget('Type Parent', back: true),
          BreadcrumbWidget('Type Parent Details', active: true),
        ],
        activeRoutes: [
          RouteList.masterTypeParent.index,
          RouteList.masterTypeParent.index
        ],
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
                          margin: EdgeInsets.only(top: 10),
                          sizes: ColScreen(lg: Col.col_12),
                          child: BsRow(
                            children: [
                              BsCol(
                                  sizes: ColScreen(lg: Col.col_3),
                                  child: Text('Code')),
                              BsCol(
                                  sizes: ColScreen(lg: Col.col_1),
                                  child: Text(':')),
                              BsCol(
                                  sizes: ColScreen(lg: Col.col_8),
                                  child: Text(controller.cd.value)),
                              BsCol(
                                  margin: EdgeInsets.only(top: 10),
                                  sizes: ColScreen(lg: Col.col_12),
                                  child: BsRow(
                                    children: [
                                      BsCol(
                                          sizes: ColScreen(lg: Col.col_3),
                                          child: Text('Sequel')),
                                      BsCol(
                                          sizes: ColScreen(lg: Col.col_1),
                                          child: Text(':')),
                                      BsCol(
                                          sizes: ColScreen(lg: Col.col_8),
                                          child: Text(controller.seq.value)),
                                      BsCol(
                                          margin: EdgeInsets.only(top: 10),
                                          sizes: ColScreen(lg: Col.col_12),
                                          child: BsRow(
                                            children: [
                                              BsCol(
                                                  sizes:
                                                      ColScreen(lg: Col.col_3),
                                                  child: Text('Description')),
                                              BsCol(
                                                  sizes:
                                                      ColScreen(lg: Col.col_1),
                                                  child: Text(':')),
                                              BsCol(
                                                  sizes:
                                                      ColScreen(lg: Col.col_8),
                                                  child: Text(
                                                      controller.desc.value))
                                            ],
                                          ))
                                    ],
                                  )),
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
    TypeModel dt = TypeModel.fromJson(response.body);
    controller.cd.value = dt.typecd;
    controller.name.value = dt.typename;
    controller.desc.value = dt.description;
    controller.seq.value = dt.typeseq.toString();
    presenter.setProcessing(false);
  }
}
