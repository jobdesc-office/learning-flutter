import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/details_view_contract.dart';
import '../../../models/masters/businesspartner_model.dart';
import '../../../presenters/masters/businesspartner_presenter.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../styles/color_palattes.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/button/theme_button_back.dart';
import '../../skins/template.dart';
import '_details_source.dart';

class BusinessPartnerDetails extends GetView implements DetailViewContract {
  final _navigation = Get.find<NavigationPresenter>();

  final BusinessPartnerPresenter presenter =
      Get.find<BusinessPartnerPresenter>();
  final BusinessPartnerDetailsSource controller =
      Get.put(BusinessPartnerDetailsSource());

  BusinessPartnerDetails() {
    Get.delete<BusinessPartnerDetailsSource>();
    presenter.businessPartnerFetchDataDetailsContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        title: 'Business Partner Details',
        breadcrumbs: [
          BreadcrumbWidget('Masters'),
          BreadcrumbWidget(
            'Business Partner',
            back: true,
          ),
          BreadcrumbWidget('Business Partner Details', active: true),
        ],
        activeRoutes: [
          RouteList.master.index,
          RouteList.masterBusinessPartner.index
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ThemeButtonBack(
              margin: EdgeInsets.only(bottom: 5),
            ),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: _navigation.darkTheme.value
                    ? ColorPallates.elseDarkColor
                    : Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Obx(() => BsRow(
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
                                  child: Text('PIC')),
                              BsCol(
                                  sizes: ColScreen(lg: Col.col_1),
                                  child: Text(':')),
                              BsCol(
                                  sizes: ColScreen(lg: Col.col_8),
                                  child: Text(controller.pic.value))
                            ],
                          )),
                      BsCol(
                          margin: EdgeInsets.only(top: 10),
                          sizes: ColScreen(lg: Col.col_12),
                          child: BsRow(
                            children: [
                              BsCol(
                                  sizes: ColScreen(lg: Col.col_3),
                                  child: Text('Phone')),
                              BsCol(
                                  sizes: ColScreen(lg: Col.col_1),
                                  child: Text(':')),
                              BsCol(
                                  sizes: ColScreen(lg: Col.col_8),
                                  child: Text(controller.phone.value))
                            ],
                          )),
                      BsCol(
                          margin: EdgeInsets.only(top: 10),
                          sizes: ColScreen(lg: Col.col_12),
                          child: BsRow(
                            children: [
                              BsCol(
                                  sizes: ColScreen(lg: Col.col_3),
                                  child: Text('Email')),
                              BsCol(
                                  sizes: ColScreen(lg: Col.col_1),
                                  child: Text(':')),
                              BsCol(
                                  sizes: ColScreen(lg: Col.col_8),
                                  child: Text(controller.email.value))
                            ],
                          )),
                      BsCol(
                          margin: EdgeInsets.only(top: 10),
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
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onSuccessFetchData(Response response) {
    BusinessPartnerModel dt = BusinessPartnerModel.fromJson(response.body);
    controller.name.value = dt.bpname;
    controller.type.value = dt.typename;
    controller.pic.value = dt.bppicname;
    controller.email.value = dt.bpemail;
    controller.phone.value = dt.bpphone;
    presenter.setProcessing(false);
  }
}
