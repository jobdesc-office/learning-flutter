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
import '../../../widgets/form_group.dart';
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
        back: true,
        child: Obx(() => BsRow(
              children: [
                BsCol(
                  sizes: ColScreen(lg: Col.col_6),
                  child: Container(
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
                            child: FormGroup(
                                label: Text('Name'),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(controller.name.value),
                                    Divider()
                                  ],
                                ))),
                        BsCol(
                            margin: EdgeInsets.only(top: 10),
                            sizes: ColScreen(lg: Col.col_12),
                            child: FormGroup(
                                label: Text('PIC'),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(controller.pic.value),
                                    Divider()
                                  ],
                                ))),
                        BsCol(
                            margin: EdgeInsets.only(top: 10),
                            sizes: ColScreen(lg: Col.col_12),
                            child: FormGroup(
                                label: Text('Phone'),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(controller.phone.value),
                                    Divider()
                                  ],
                                ))),
                        BsCol(
                            margin: EdgeInsets.only(top: 10),
                            sizes: ColScreen(lg: Col.col_12),
                            child: FormGroup(
                                label: Text('Email'),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(controller.email.value),
                                    Divider()
                                  ],
                                ))),
                        BsCol(
                            margin: EdgeInsets.only(top: 10),
                            sizes: ColScreen(lg: Col.col_12),
                            child: FormGroup(
                                label: Text('Type'),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(controller.type.value),
                                    Divider()
                                  ],
                                ))),
                      ],
                    ),
                  ),
                ),
                BsCol(
                  margin: EdgeInsets.only(left: 5),
                  sizes: ColScreen(lg: Col.col_6),
                  child: Container(
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
                          child: BsRow(
                            children: [
                              BsCol(
                                child: FormGroup(
                                    label: Text('Created By'),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(controller.createdby.value),
                                        Divider()
                                      ],
                                    )),
                              ),
                              BsCol(
                                margin: EdgeInsets.only(top: 10),
                                child: FormGroup(
                                    label: Text('Created At'),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(controller.createddate.value),
                                        Divider()
                                      ],
                                    )),
                              ),
                              BsCol(
                                margin: EdgeInsets.only(top: 10),
                                child: FormGroup(
                                    label: Text('Last Updated By'),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(controller.updatedby.value),
                                        Divider()
                                      ],
                                    )),
                              ),
                              BsCol(
                                margin: EdgeInsets.only(top: 10),
                                child: FormGroup(
                                    label: Text('Last Updated At'),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(controller.updateddate.value),
                                        Divider()
                                      ],
                                    )),
                              ),
                              BsCol(
                                margin: EdgeInsets.only(top: 10),
                                child: FormGroup(
                                    label: Text('Activation'),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (controller.isactive.value)
                                          Card(
                                            color: Colors.green,
                                            child: Text('Active'),
                                          )
                                        else
                                          Card(
                                            color: Colors.red,
                                            child: Text('Not Active'),
                                          ),
                                        Divider()
                                      ],
                                    )),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }

  @override
  void onSuccessFetchData(Response response) {
    BusinessPartnerModel dt = BusinessPartnerModel.fromJson(response.body);
    controller.name.value = dt.bpname ?? '';
    controller.type.value = dt.bptype?.typename ?? '';
    controller.pic.value = dt.bppicname ?? '';
    controller.email.value = dt.bpemail ?? '';
    controller.phone.value = dt.bpphone ?? '';
    controller.createdby.value = dt.bpcreatedby?.userfullname ?? '';
    controller.createddate.value = dt.createddate ?? '';
    controller.updatedby.value = dt.bpupdatedby?.userfullname ?? '';
    controller.updateddate.value = dt.updateddate ?? '';
    controller.isactive.value = dt.isactive ?? false;
    presenter.setProcessing(false);
  }
}
