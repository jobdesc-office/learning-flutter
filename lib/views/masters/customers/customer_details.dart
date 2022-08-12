import 'package:bs_flutter_modal/bs_flutter_modal.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/details_view_contract.dart';
import '../../../models/masters/customer_model.dart';
import '../../../presenters/masters/customer_presenter.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../styles/color_palattes.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/button/theme_button_back.dart';
import '../../skins/template.dart';
import '_details_source.dart';
import '_text.dart';

final _navigation = Get.find<NavigationPresenter>();

class CustomerDetails extends GetView implements DetailViewContract {
  final CustomerPresenter presenter = Get.find<CustomerPresenter>();
  final CustomerDetailsSource controller = Get.put(CustomerDetailsSource());

  CustomerDetails() {
    Get.delete<CustomerDetailsSource>();
    presenter.customerDataDetailsContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        title: 'Customer Details',
        breadcrumbs: [
          BreadcrumbWidget('Masters'),
          BreadcrumbWidget('Customers', back: true),
          BreadcrumbWidget('Customer Details', active: true),
        ],
        activeRoutes: [RouteList.master.index, RouteList.masterCustomer.index],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ThemeButtonBack(
              onPressed: () => Navigator.pop(context),
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
                                  child: Text('Prefix')),
                              BsCol(
                                  sizes: ColScreen(lg: Col.col_1),
                                  child: Text(':')),
                              BsCol(
                                  sizes: ColScreen(lg: Col.col_8),
                                  child: Text(controller.prefix.value))
                            ],
                          )),
                      BsCol(
                          margin: EdgeInsets.only(top: 10),
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
                                  child: Text('Address')),
                              BsCol(
                                  sizes: ColScreen(lg: Col.col_1),
                                  child: Text(':')),
                              BsCol(
                                  sizes: ColScreen(lg: Col.col_8),
                                  child: Text(controller.address.value)),
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
                              BsCol(
                                  margin: EdgeInsets.only(top: 10),
                                  sizes: ColScreen(lg: Col.col_12),
                                  child: BsRow(
                                    children: [
                                      BsCol(
                                          sizes: ColScreen(lg: Col.col_3),
                                          child: Text('Referal')),
                                      BsCol(
                                          sizes: ColScreen(lg: Col.col_1),
                                          child: Text(':')),
                                      BsCol(
                                          sizes: ColScreen(lg: Col.col_8),
                                          child: Text(controller.referal.value))
                                    ],
                                  )),
                              BsCol(
                                  margin: EdgeInsets.only(top: 10),
                                  sizes: ColScreen(lg: Col.col_12),
                                  child: BsRow(
                                    children: [
                                      BsCol(
                                          sizes: ColScreen(lg: Col.col_3),
                                          child: Text('Province')),
                                      BsCol(
                                          sizes: ColScreen(lg: Col.col_1),
                                          child: Text(':')),
                                      BsCol(
                                          sizes: ColScreen(lg: Col.col_8),
                                          child:
                                              Text(controller.province.value))
                                    ],
                                  )),
                              BsCol(
                                  margin: EdgeInsets.only(top: 10),
                                  sizes: ColScreen(lg: Col.col_12),
                                  child: BsRow(
                                    children: [
                                      BsCol(
                                          sizes: ColScreen(lg: Col.col_3),
                                          child: Text('City')),
                                      BsCol(
                                          sizes: ColScreen(lg: Col.col_1),
                                          child: Text(':')),
                                      BsCol(
                                          sizes: ColScreen(lg: Col.col_8),
                                          child: Text(controller.city.value)),
                                      BsCol(
                                          margin: EdgeInsets.only(top: 10),
                                          sizes: ColScreen(lg: Col.col_12),
                                          child: BsRow(
                                            children: [
                                              BsCol(
                                                  sizes:
                                                      ColScreen(lg: Col.col_3),
                                                  child: Text('Subdistrict')),
                                              BsCol(
                                                  sizes:
                                                      ColScreen(lg: Col.col_1),
                                                  child: Text(':')),
                                              BsCol(
                                                  sizes:
                                                      ColScreen(lg: Col.col_8),
                                                  child: Text(controller
                                                      .subdistrict.value)),
                                              BsCol(
                                                  margin:
                                                      EdgeInsets.only(top: 10),
                                                  sizes:
                                                      ColScreen(lg: Col.col_12),
                                                  child: BsRow(
                                                    children: [
                                                      BsCol(
                                                          sizes: ColScreen(
                                                              lg: Col.col_3),
                                                          child:
                                                              Text('Village')),
                                                      BsCol(
                                                          sizes: ColScreen(
                                                              lg: Col.col_1),
                                                          child: Text(':')),
                                                      BsCol(
                                                          sizes: ColScreen(
                                                              lg: Col.col_8),
                                                          child: Text(controller
                                                              .muv.value))
                                                    ],
                                                  )),
                                              BsCol(
                                                  margin:
                                                      EdgeInsets.only(top: 10),
                                                  sizes:
                                                      ColScreen(lg: Col.col_12),
                                                  child: BsRow(
                                                    children: [
                                                      BsCol(
                                                          sizes: ColScreen(
                                                              lg: Col.col_3),
                                                          child: Text(
                                                              'Postal Code')),
                                                      BsCol(
                                                          sizes: ColScreen(
                                                              lg: Col.col_1),
                                                          child: Text(':')),
                                                      BsCol(
                                                          sizes: ColScreen(
                                                              lg: Col.col_8),
                                                          child: Text(controller
                                                              .postal.value))
                                                    ],
                                                  )),
                                            ],
                                          )),
                                    ],
                                  )),
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
    CustomerModel dt = CustomerModel.fromJson(response.body);
    controller.prefix.value = dt.cstmprefix;
    controller.name.value = dt.cstmname;
    controller.phone.value = dt.cstmphone;
    controller.address.value = dt.cstmaddress;
    controller.type.value = dt.typename;
    controller.province.value = dt.provname;
    controller.city.value = dt.cityname;
    controller.subdistrict.value = dt.subdistrictname;
    controller.muv.value = dt.villagename.toString();
    controller.postal.value = dt.cstmpostalcode;
    controller.latitude.value = dt.cstmlatitude.toString();
    controller.longitude.value = dt.cstmlongitude.toString();
    controller.referal.value = dt.referalcode;
    presenter.setProcessing(false);
  }
}
