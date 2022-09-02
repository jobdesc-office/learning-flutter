import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/details_view_contract.dart';
import '../../../models/ventes/bpcustomer_model.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../presenters/ventes/bpcustomer_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../styles/color_palattes.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/button/theme_button_back.dart';
import '../../../widgets/form_group.dart';
import '../../skins/template.dart';
import '_details_source.dart';

final _navigation = Get.find<NavigationPresenter>();

class BpCustomerDetails extends GetView implements DetailViewContract {
  final BpCustomerPresenter presenter = Get.find<BpCustomerPresenter>();
  final BpCustomerDetailsSource controller = Get.put(BpCustomerDetailsSource());

  BpCustomerDetails() {
    Get.delete<BpCustomerDetailsSource>();
    presenter.bpCustomerDetailViewContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        title: 'BpCustomer Details',
        breadcrumbs: [
          BreadcrumbWidget('Masters'),
          BreadcrumbWidget('BpCustomers', back: true),
          BreadcrumbWidget('BpCustomer Details', active: true),
        ],
        activeRoutes: [
          RouteList.master.index,
          RouteList.ventesBpCustomer.index
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
                          sizes: ColScreen(lg: Col.col_4),
                          child: Container(
                            child: Image.network(
                              controller.pic.value,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.network(
                                    'http://10.21.1.63/learning-api/public/storage/images/default_image.jpeg');
                              },
                            ),
                          ),
                        ),
                        BsCol(
                          sizes: ColScreen(lg: Col.col_8),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: BsRow(
                              children: [
                                BsCol(
                                  sizes: ColScreen(sm: Col.col_12),
                                  child: FormGroup(
                                      label: Text('Name'),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(controller.name.value),
                                          Divider()
                                        ],
                                      )),
                                ),
                                BsCol(
                                  margin: EdgeInsets.only(top: 5),
                                  sizes: ColScreen(sm: Col.col_12),
                                  child: FormGroup(
                                      label: Text('Type'),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(controller.type.value),
                                          Divider()
                                        ],
                                      )),
                                ),
                                BsCol(
                                  margin: EdgeInsets.only(top: 5),
                                  sizes: ColScreen(sm: Col.col_12),
                                  child: FormGroup(
                                      label: Text('Phone'),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(controller.phone.value),
                                          Divider()
                                        ],
                                      )),
                                ),
                                BsCol(
                                  margin: EdgeInsets.only(top: 5),
                                  sizes: ColScreen(sm: Col.col_12),
                                  child: FormGroup(
                                      label: Text('Address'),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(controller.address.value),
                                          Divider()
                                        ],
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
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
                ),
              ],
            )),
      ),
    );
  }

  @override
  void onSuccessFetchData(Response response) {
    BusinessPartnerCustomerModel dt =
        BusinessPartnerCustomerModel.fromJson(response.body);
    controller.name.value = dt.sbccstmname.toString();
    controller.phone.value = dt.sbccstmphone ?? '';
    controller.type.value = dt.sbccstmstatus!.typename ?? '';
    controller.address.value = dt.sbccstmaddress ?? '';

    controller.createdby.value = dt.bpcustcreatedby?.userfullname ?? '';
    controller.createddate.value = dt.createddate ?? '';
    controller.updatedby.value = dt.bpcustupdatedby?.userfullname ?? '';
    controller.updateddate.value = dt.updateddate ?? '';
    controller.isactive.value = dt.isactive ?? false;

    if (dt.sbccstmpics!.isNotEmpty) {
      controller.pic.value = dt.sbccstmpics!.first.url!;
    } else {
      controller.pic.value =
          'http://10.21.1.63/learning-api/public/storage/images/default_image.jpeg';
    }
    presenter.setProcessing(false);
  }
}
