import 'package:boilerplate/contracts/base/details_view_contract.dart';
import 'package:boilerplate/helpers/function.dart';
import 'package:boilerplate/views/masters/menus/feature/_form_source.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../../models/ventes/report_model.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../presenters/ventes/report_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../styles/color_palattes.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/form_group.dart';
import '../../skins/template.dart';
import '_details_source.dart';

final _navigation = Get.find<NavigationPresenter>();
final controller = Get.put(ReportDetailsSource());

class ReportDetail extends GetView implements DetailViewContract {
  final presenter = Get.find<ReportPresenter>();

  ReportDetail() {
    presenter.reportsFetchDataDetailsContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        title: 'Report Details',
        breadcrumbs: [
          BreadcrumbWidget('Venteses'),
          BreadcrumbWidget(
            'Report',
            back: true,
          ),
          BreadcrumbWidget(
            'Report Details',
            active: true,
          ),
        ],
        activeRoutes: [RouteList.ventes.index, RouteList.ventesReport.index],
        back: true,
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
                                  label: Text('Customer',
                                      style: TextStyle(
                                          color: _navigation.darkTheme.value
                                              ? Colors.white
                                              : Colors.black)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(controller.customer.value),
                                      Divider()
                                    ],
                                  ))),
                          BsCol(
                              margin: EdgeInsets.only(top: 10),
                              sizes: ColScreen(lg: Col.col_12),
                              child: FormGroup(
                                  label: Text('Category',
                                      style: TextStyle(
                                          color: _navigation.darkTheme.value
                                              ? Colors.white
                                              : Colors.black)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(controller.cat.value),
                                      Divider()
                                    ],
                                  ))),
                          BsCol(
                              margin: EdgeInsets.only(top: 10),
                              sizes: ColScreen(lg: Col.col_12),
                              child: FormGroup(
                                  label: Text('Type',
                                      style: TextStyle(
                                          color: _navigation.darkTheme.value
                                              ? Colors.white
                                              : Colors.black)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(controller.type.value),
                                      Divider()
                                    ],
                                  ))),
                          BsCol(
                              margin: EdgeInsets.only(top: 10),
                              sizes: ColScreen(lg: Col.col_12),
                              child: FormGroup(
                                  label: Text('Type Value',
                                      style: TextStyle(
                                          color: _navigation.darkTheme.value
                                              ? Colors.white
                                              : Colors.black)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(controller.typeval.value),
                                      Divider()
                                    ],
                                  ))),
                          BsCol(
                              margin: EdgeInsets.only(top: 10),
                              sizes: ColScreen(lg: Col.col_12),
                              child: FormGroup(
                                  label: Text('Date',
                                      style: TextStyle(
                                          color: _navigation.darkTheme.value
                                              ? Colors.white
                                              : Colors.black)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(controller.date.value),
                                      Divider()
                                    ],
                                  ))),
                          BsCol(
                              margin: EdgeInsets.only(top: 10),
                              sizes: ColScreen(lg: Col.col_12),
                              child: FormGroup(
                                  label: Text('Description',
                                      style: TextStyle(
                                          color: _navigation.darkTheme.value
                                              ? Colors.white
                                              : Colors.black)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(controller.desc.value),
                                      Divider()
                                    ],
                                  ))),
                          BsCol(
                              margin: EdgeInsets.only(top: 10),
                              sizes: ColScreen(lg: Col.col_12),
                              child: FormGroup(
                                  label: Text('Location Label',
                                      style: TextStyle(
                                          color: _navigation.darkTheme.value
                                              ? Colors.white
                                              : Colors.black)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(controller.loclab.value),
                                      Divider()
                                    ],
                                  ))),
                          BsCol(
                              margin: EdgeInsets.only(top: 10),
                              sizes: ColScreen(lg: Col.col_12),
                              child: FormGroup(
                                  label: Text('Location',
                                      style: TextStyle(
                                          color: _navigation.darkTheme.value
                                              ? Colors.white
                                              : Colors.black)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(controller.loc.value),
                                      Divider()
                                    ],
                                  ))),
                          BsCol(
                              margin: EdgeInsets.only(top: 10),
                              sizes: ColScreen(lg: Col.col_12),
                              child: FormGroup(
                                  label: Text('Latitude',
                                      style: TextStyle(
                                          color: _navigation.darkTheme.value
                                              ? Colors.white
                                              : Colors.black)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(controller.lat.value),
                                      Divider()
                                    ],
                                  ))),
                          BsCol(
                              margin: EdgeInsets.only(top: 10),
                              sizes: ColScreen(lg: Col.col_12),
                              child: FormGroup(
                                  label: Text('Longitude',
                                      style: TextStyle(
                                          color: _navigation.darkTheme.value
                                              ? Colors.white
                                              : Colors.black)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(controller.long.value),
                                      Divider()
                                    ],
                                  )))
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
                                label: Text('Created By',
                                    style: TextStyle(
                                        color: _navigation.darkTheme.value
                                            ? Colors.white
                                            : Colors.black)),
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
                                label: Text('Created At',
                                    style: TextStyle(
                                        color: _navigation.darkTheme.value
                                            ? Colors.white
                                            : Colors.black)),
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
                                label: Text('Last Updated By',
                                    style: TextStyle(
                                        color: _navigation.darkTheme.value
                                            ? Colors.white
                                            : Colors.black)),
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
                                label: Text('Last Updated At',
                                    style: TextStyle(
                                        color: _navigation.darkTheme.value
                                            ? Colors.white
                                            : Colors.black)),
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
                                label: Text('Is Active',
                                    style: TextStyle(
                                        color: _navigation.darkTheme.value
                                            ? Colors.white
                                            : Colors.black)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (controller.isactive.value)
                                      Card(
                                        color: Colors.green,
                                        child: Text('Active',
                                            style: TextStyle(
                                                color:
                                                    _navigation.darkTheme.value
                                                        ? Colors.white
                                                        : Colors.black)),
                                      )
                                    else
                                      Card(
                                        color: Colors.red,
                                        child: Text('Not Active',
                                            style: TextStyle(
                                                color:
                                                    _navigation.darkTheme.value
                                                        ? Colors.white
                                                        : Colors.black)),
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
    Activities dt = Activities.fromJson(response.body);
    controller.customer.value = dt.dayactcust?.cstmname ?? '';
    controller.cat.value = dt.dayactcat?.typename ?? '';
    controller.type.value = dt.dayacttype?.typename ?? '';
    controller.typeval.value = dt.dayacttypevalue ?? '';
    controller.date.value = dt.dayactdate ?? '';
    controller.desc.value = dt.dayactdesc ?? '';
    controller.loclab.value = dt.dayactloclabel ?? '';
    controller.loc.value = dt.dayactloc ?? '';
    controller.long.value = parseString(dt.dayactlongitude ?? '');
    controller.lat.value = parseString(dt.dayactlatitude ?? '');

    controller.createdby.value = dt.dayactuser?.userfullname ?? '';
    controller.createddate.value = dt.createddate ?? '';
    controller.updatedby.value = dt.dayactupdatedby?.userfullname ?? '';
    controller.updateddate.value = dt.updateddate ?? '';
    controller.isactive.value = dt.isactive ?? false;
  }
}
