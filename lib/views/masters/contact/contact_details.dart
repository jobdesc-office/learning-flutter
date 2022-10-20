import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/details_view_contract.dart';
import '../../../models/masters/contact_model.dart';
import '../../../presenters/masters/contact_presenter.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../styles/color_palattes.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/form_group.dart';
import '../../skins/template.dart';
import '_details_source.dart';

final _navigation = Get.find<NavigationPresenter>();

class ContactDetails extends GetView implements DetailViewContract {
  final ContactPresenter presenter = Get.find<ContactPresenter>();
  final ContactDetailsSource controller = Get.put(ContactDetailsSource());

  ContactDetails() {
    Get.delete<ContactDetailsSource>();
    presenter.contactDataDetailsContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        title: 'Contact Details',
        breadcrumbs: [
          BreadcrumbWidget('Masters'),
          BreadcrumbWidget('Contact', back: true),
          BreadcrumbWidget('Contact Details', active: true),
        ],
        back: true,
        activeRoutes: [RouteList.master.index, RouteList.masterContact.index],
        child: Obx(() => BsRow(
              children: [
                BsCol(
                    sizes: ColScreen(lg: Col.col_6),
                    child: Container(
                      height: MediaQuery.of(context).size.height,
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
                                  label: Text('Type'),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(controller.type.value),
                                      Divider()
                                    ],
                                  ))),
                          BsCol(
                              margin: EdgeInsets.only(top: 5),
                              sizes: ColScreen(lg: Col.col_12),
                              child: FormGroup(
                                  label: Text('Customer'),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(controller.customer.value),
                                      Divider()
                                    ],
                                  ))),
                          BsCol(
                              margin: EdgeInsets.only(top: 5),
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
                              margin: EdgeInsets.only(top: 5),
                              sizes: ColScreen(lg: Col.col_12),
                              child: FormGroup(
                                  label: Text('Value'),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(controller.value.value),
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
                                label: Text('Is Active'),
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
    ContactModel dt = ContactModel.fromJson(response.body);
    controller.type.value = dt.contacttype!.sbttypename ?? '';
    controller.customer.value = dt.contactcustomer!.sbccstmname ?? '';
    controller.name.value = dt.contactname ?? '';
    controller.value.value = dt.contactvalueid ?? '';

    controller.createdby.value = dt.contactcreatedby?.userfullname ?? '';
    controller.createddate.value = dt.createddate ?? '';
    controller.updatedby.value = dt.contactupdatedby?.userfullname ?? '';
    controller.updateddate.value = dt.updateddate ?? '';
    controller.isactive.value = dt.isactive ?? false;
    presenter.setProcessing(false);
  }
}
