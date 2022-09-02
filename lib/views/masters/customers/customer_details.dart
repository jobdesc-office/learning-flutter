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
import '../../../widgets/form_group.dart';
import '../../skins/template.dart';
import '_details_source.dart';

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
                                  label: Text('Prefix'),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(controller.prefix.value),
                                      Divider()
                                    ],
                                  ))),
                          BsCol(
                              margin: EdgeInsets.only(top: 10),
                              sizes: ColScreen(lg: Col.col_12),
                              child: FormGroup(
                                  label: Text('Name'),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(controller.name.value),
                                      Divider()
                                    ],
                                  ))),
                          BsCol(
                              margin: EdgeInsets.only(top: 10),
                              sizes: ColScreen(lg: Col.col_12),
                              child: FormGroup(
                                  label: Text('Phone'),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(controller.phone.value),
                                      Divider()
                                    ],
                                  ))),
                          BsCol(
                              margin: EdgeInsets.only(top: 10),
                              sizes: ColScreen(lg: Col.col_12),
                              child: FormGroup(
                                  label: Text('Address'),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(controller.address.value),
                                      Divider()
                                    ],
                                  ))),
                          BsCol(
                              margin: EdgeInsets.only(top: 10),
                              sizes: ColScreen(lg: Col.col_12),
                              child: FormGroup(
                                  label: Text('Referal'),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(controller.referal.value),
                                      Divider()
                                    ],
                                  ))),
                          BsCol(
                              margin: EdgeInsets.only(top: 10),
                              sizes: ColScreen(lg: Col.col_12),
                              child: FormGroup(
                                  label: Text('Province'),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(controller.province.value),
                                      Divider()
                                    ],
                                  ))),
                          BsCol(
                            child: FormGroup(
                                label: Text('City'),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(controller.city.value),
                                    Divider()
                                  ],
                                )),
                          ),
                          BsCol(
                            child: FormGroup(
                                label: Text('Subdistrict'),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(controller.subdistrict.value),
                                    Divider()
                                  ],
                                )),
                          ),
                          BsCol(
                              margin: EdgeInsets.only(top: 10),
                              sizes: ColScreen(lg: Col.col_12),
                              child: FormGroup(
                                  label: Text('Village'),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(controller.muv.value),
                                      Divider()
                                    ],
                                  ))),
                          BsCol(
                              margin: EdgeInsets.only(top: 10),
                              sizes: ColScreen(lg: Col.col_12),
                              child: FormGroup(
                                  label: Text('Postal Code'),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(controller.postal.value),
                                      Divider()
                                    ],
                                  ))),
                          BsCol(
                              margin: EdgeInsets.only(top: 10),
                              sizes: ColScreen(lg: Col.col_12),
                              child: FormGroup(
                                  label: Text('Type'),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(controller.type.value),
                                      Divider()
                                    ],
                                  ))),
                        ],
                      ),
                    )),
                BsCol(
                    margin: EdgeInsets.only(left: 10),
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
                            child: FormGroup(
                                label: Text('Created By'),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    )),
              ],
            )),
      ),
    );
  }

  @override
  void onSuccessFetchData(Response response) {
    CustomerModel dt = CustomerModel.fromJson(response.body);
    controller.prefix.value = dt.cstmprefix ?? '';
    controller.name.value = dt.cstmname ?? '';
    controller.phone.value = dt.cstmphone ?? '';
    controller.address.value = dt.cstmaddress ?? '';
    controller.type.value = dt.cstmtype?.typename ?? '';
    controller.province.value = dt.cstmprovince?.provname ?? '';
    controller.city.value = dt.cstmcity?.cityname ?? '';
    controller.subdistrict.value = dt.cstmsubdistrict?.subdistrictname ?? '';
    controller.muv.value = dt.cstmvillage?.villagename ?? '';
    controller.postal.value = dt.cstmpostalcode ?? '';
    controller.latitude.value = dt.cstmlatitude ?? '';
    controller.longitude.value = dt.cstmlongitude ?? '';
    controller.referal.value = dt.referalcode ?? '';

    controller.createdby.value = dt.custcreatedby?.userfullname ?? '';
    controller.createddate.value = dt.createddate ?? '';
    controller.updatedby.value = dt.custupdatedby?.userfullname ?? '';
    controller.updateddate.value = dt.updateddate ?? '';
    controller.isactive.value = dt.isactive ?? false;
    presenter.setProcessing(false);
  }
}
