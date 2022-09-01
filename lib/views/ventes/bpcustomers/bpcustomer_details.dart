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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ThemeButtonBack(
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
                        sizes: ColScreen(lg: Col.col_4),
                        child: Container(
                          child: Image.network(
                            controller.pic.value,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.network(
                                  'http://10.21.1.63/learning-api/public/storage/images/default_image.png');
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
                                child: BsRow(
                                  children: [
                                    BsCol(
                                      sizes: ColScreen(sm: Col.col_4),
                                      child: Text('Name'),
                                    ),
                                    BsCol(
                                      sizes: ColScreen(sm: Col.col_1),
                                      child: Text(':'),
                                    ),
                                    BsCol(
                                      sizes: ColScreen(sm: Col.col_7),
                                      child: Text(controller.name.value),
                                    )
                                  ],
                                ),
                              ),
                              BsCol(
                                margin: EdgeInsets.only(top: 5),
                                sizes: ColScreen(sm: Col.col_12),
                                child: BsRow(
                                  children: [
                                    BsCol(
                                      sizes: ColScreen(sm: Col.col_4),
                                      child: Text('Type'),
                                    ),
                                    BsCol(
                                      sizes: ColScreen(sm: Col.col_1),
                                      child: Text(':'),
                                    ),
                                    BsCol(
                                      sizes: ColScreen(sm: Col.col_7),
                                      child: Text(controller.type.value),
                                    )
                                  ],
                                ),
                              ),
                              BsCol(
                                margin: EdgeInsets.only(top: 5),
                                sizes: ColScreen(sm: Col.col_12),
                                child: BsRow(
                                  children: [
                                    BsCol(
                                      sizes: ColScreen(sm: Col.col_4),
                                      child: Text('Phone'),
                                    ),
                                    BsCol(
                                      sizes: ColScreen(sm: Col.col_1),
                                      child: Text(':'),
                                    ),
                                    BsCol(
                                      sizes: ColScreen(sm: Col.col_7),
                                      child: Text(controller.phone.value),
                                    )
                                  ],
                                ),
                              ),
                              BsCol(
                                margin: EdgeInsets.only(top: 5),
                                sizes: ColScreen(sm: Col.col_12),
                                child: BsRow(
                                  children: [
                                    BsCol(
                                      sizes: ColScreen(sm: Col.col_4),
                                      child: Text('Address'),
                                    ),
                                    BsCol(
                                      sizes: ColScreen(sm: Col.col_1),
                                      child: Text(':'),
                                    ),
                                    BsCol(
                                      sizes: ColScreen(sm: Col.col_7),
                                      child: Text(controller.address.value),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      BsCol(
                        sizes: ColScreen(lg: Col.col_12),
                        // child: Container(
                        //     color: Colors.amber, width: 200, height: 200),
                      ),
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
    BusinessPartnerCustomerModel dt =
        BusinessPartnerCustomerModel.fromJson(response.body);
    controller.name.value = dt.sbccstmname.toString();
    controller.phone.value = dt.sbccstmphone ?? '';
    controller.type.value = dt.sbccstmstatus!.typename ?? '';
    controller.address.value = dt.sbccstmaddress ?? '';
    if (dt.sbccstmpics!.isNotEmpty) {
      controller.pic.value = dt.sbccstmpics!.first.url!;
    } else {
      controller.pic.value =
          'http://10.21.1.63/learning-api/public/storage/images/default_image.png';
    }
    presenter.setProcessing(false);
  }
}
