import 'package:boilerplate/contracts/base/details_view_contract.dart';
import 'package:boilerplate/helpers/function.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../models/ventes/report_model.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../presenters/ventes/prospect_presenter.dart';
import '../../../presenters/ventes/report_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../styles/color_palattes.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/form_group.dart';
import '../../../widgets/map/mapreadonly.dart';
import '../../skins/template.dart';
import '_details_source.dart';

final _navigation = Get.find<NavigationPresenter>();
final controller = Get.put(ReportDetailsSource());

class ReportDetail extends GetView implements DetailViewContract {
  final presenter = Get.find<ReportPresenter>();
  final prospectPresenter = Get.put(ProspectPresenter());

  ReportDetail() {
    controller.showMap.value = false;
    presenter.reportsFetchDataDetailsContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        title: 'Report Details',
        breadcrumbs: [
          BreadcrumbWidget('Ventes'),
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
                          if (controller.ref.value != '')
                            BsCol(
                                sizes: ColScreen(lg: Col.col_12),
                                child: FormGroup(
                                    label: Text('Reference',
                                        style: TextStyle(
                                            color: _navigation.darkTheme.value
                                                ? Colors.white
                                                : Colors.black)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Get.toNamed(
                                                RouteList.ventesProspect.index);
                                            prospectPresenter.details(context,
                                                controller.prospectid.value);
                                          },
                                          child: Text(
                                            controller.ref.value +
                                                ' - ' +
                                                controller.refprospect.value,
                                            style: TextStyle(
                                                color: Colors.blue.shade300),
                                          ),
                                        ),
                                        Divider()
                                      ],
                                    ))),
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
                                  label: Text('Additional Information',
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
                                  ))),
                          if (controller.cf.isNotEmpty)
                            BsCol(
                                margin: EdgeInsets.only(top: 10),
                                sizes: ColScreen(lg: Col.col_12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Custom Field',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Column(
                                      children: controller.cf
                                          .map((element) => Column(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.all(5),
                                                    child: BsRow(children: [
                                                      BsCol(
                                                          sizes: ColScreen(
                                                              sm: Col.col_3),
                                                          child: Text(element
                                                                  .customfield
                                                                  ?.custfname ??
                                                              '')),
                                                      BsCol(
                                                          sizes: ColScreen(
                                                              sm: Col.col_1),
                                                          child: Text(':')),
                                                      BsCol(
                                                          sizes: ColScreen(
                                                              sm: Col.col_8),
                                                          child: Text(element
                                                                  .activitycfvalue ??
                                                              ''))
                                                    ]),
                                                  ),
                                                  Divider()
                                                ],
                                              ))
                                          .toList(),
                                    ),
                                  ],
                                )),
                        ],
                      ),
                    )),
                BsCol(
                    margin: EdgeInsets.only(left: 10),
                    sizes: ColScreen(lg: Col.col_6),
                    child: Column(
                      children: [
                        Container(
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
                                    label: Text('Created At',
                                        style: TextStyle(
                                            color: _navigation.darkTheme.value
                                                ? Colors.white
                                                : Colors.black)),
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
                                    label: Text('Last Updated By',
                                        style: TextStyle(
                                            color: _navigation.darkTheme.value
                                                ? Colors.white
                                                : Colors.black)),
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
                                    label: Text('Last Updated At',
                                        style: TextStyle(
                                            color: _navigation.darkTheme.value
                                                ? Colors.white
                                                : Colors.black)),
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
                                    label: Text('Is Active',
                                        style: TextStyle(
                                            color: _navigation.darkTheme.value
                                                ? Colors.white
                                                : Colors.black)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (controller.isactive.value)
                                          Card(
                                            color: Colors.green,
                                            child: Text('Active',
                                                style: TextStyle(
                                                    color: _navigation
                                                            .darkTheme.value
                                                        ? Colors.white
                                                        : Colors.black)),
                                          )
                                        else
                                          Card(
                                            color: Colors.red,
                                            child: Text('Not Active',
                                                style: TextStyle(
                                                    color: _navigation
                                                            .darkTheme.value
                                                        ? Colors.white
                                                        : Colors.black)),
                                          ),
                                        Divider()
                                      ],
                                    )),
                              ),
                            ],
                          ),
                        ),
                        if (controller.showMap.value)
                          Container(
                            margin: EdgeInsets.only(top: 5),
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
                                  height:
                                      MediaQuery.of(context).size.height * 0.44,
                                  child: GoogleMapsRead(
                                    camera: CameraPosition(
                                      target: LatLng(
                                          parseDouble(controller.lat.value),
                                          parseDouble(controller.long.value)),
                                      zoom: 14.4746,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                      ],
                    )),
              ],
            )),
      ),
    );
  }

  @override
  void onSuccessFetchData(Response response) {
    controller.cf.clear();
    Activities dt = Activities.fromJson(response.body);
    if (dt.dayactreftype != null) {
      controller.ref.value = dt.dayactreftype?.typename ?? '';
      controller.refprospect.value = dt.refprospect?.prospectcode ?? '';
      controller.prospectid.value = dt.refprospect?.prospectid ?? 0;
    } else
      controller.ref.value = '';
    controller.customer.value = dt.dayactcust?.sbccstmname ?? '';
    controller.cat.value = dt.dayactcat?.sbttypename ?? '';
    controller.date.value = dt.dayactdate ?? '';
    controller.desc.value = dt.dayactdesc ?? '';
    controller.loclab.value = dt.dayactloclabel ?? '';
    controller.loc.value = dt.dayactloc ?? '';
    controller.long.value = parseString(dt.dayactlongitude ?? '');
    controller.lat.value = parseString(dt.dayactlatitude ?? '');
    if (dt.dayactlongitude != null && dt.dayactlatitude != null)
      controller.showMap.value = true;

    if (dt.activitycustomfield!.isNotEmpty)
      controller.cf.value = dt.activitycustomfield!;

    controller.createdby.value = dt.dayactuser?.userfullname ?? '';
    controller.createddate.value = dt.createddate ?? '';
    controller.updatedby.value = dt.dayactupdatedby?.userfullname ?? '';
    controller.updateddate.value = dt.updateddate ?? '';
    controller.isactive.value = dt.isactive ?? false;
  }
}
