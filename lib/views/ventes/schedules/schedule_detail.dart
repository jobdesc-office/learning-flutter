import 'package:boilerplate/styles/color_palattes.dart';
import 'package:boilerplate/widgets/form_group.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../contracts/base/details_view_contract.dart';
import '../../../models/ventes/schedule_model.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../presenters/ventes/schedule_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/snackbar.dart';
import '../../skins/template.dart';
import '_details_source.dart';
import '_text.dart';

final _navigation = Get.find<NavigationPresenter>();

class ScheduleDetails extends GetView implements DetailViewContract {
  final SchedulePresenter presenter = Get.find<SchedulePresenter>();
  final ScheduleDetailsSource controller = Get.put(ScheduleDetailsSource());

  ScheduleDetails() {
    Get.delete<ScheduleDetailsSource>();
    presenter.scheduleFetchDataDetailsContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        title: ScheduleText.title + ' Details',
        breadcrumbs: [
          BreadcrumbWidget('Ventes'),
          BreadcrumbWidget('Schedules', back: true),
          BreadcrumbWidget('Schedule Details', active: true),
        ],
        activeRoutes: [RouteList.master.index, RouteList.ventesSchedule.index],
        back: true,
        titlebg: true,
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
                                label: Text('Title',
                                    style: TextStyle(
                                        color: _navigation.darkTheme.value
                                            ? Colors.white
                                            : Colors.black)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(controller.title.value),
                                    Divider()
                                  ],
                                ))),
                        BsCol(
                            margin: EdgeInsets.only(top: 10),
                            sizes: ColScreen(lg: Col.col_12),
                            child: FormGroup(
                                label: Text('Name',
                                    style: TextStyle(
                                        color: _navigation.darkTheme.value
                                            ? Colors.white
                                            : Colors.black)),
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
                                label: Text('Start Date',
                                    style: TextStyle(
                                        color: _navigation.darkTheme.value
                                            ? Colors.white
                                            : Colors.black)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(controller.startdate.value),
                                    Divider()
                                  ],
                                ))),
                        BsCol(
                            margin: EdgeInsets.only(top: 10),
                            sizes: ColScreen(lg: Col.col_12),
                            child: FormGroup(
                                label: Text('Start Time',
                                    style: TextStyle(
                                        color: _navigation.darkTheme.value
                                            ? Colors.white
                                            : Colors.black)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(controller.starttime.value),
                                    Divider()
                                  ],
                                ))),
                        BsCol(
                            margin: EdgeInsets.only(top: 10),
                            sizes: ColScreen(lg: Col.col_12),
                            child: FormGroup(
                                label: Text('End Date',
                                    style: TextStyle(
                                        color: _navigation.darkTheme.value
                                            ? Colors.white
                                            : Colors.black)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(controller.enddate.value),
                                    Divider()
                                  ],
                                ))),
                        BsCol(
                            margin: EdgeInsets.only(top: 10),
                            sizes: ColScreen(lg: Col.col_12),
                            child: FormGroup(
                                label: Text('End Time',
                                    style: TextStyle(
                                        color: _navigation.darkTheme.value
                                            ? Colors.white
                                            : Colors.black)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(controller.endtime.value),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(controller.type.value),
                                    Divider()
                                  ],
                                ))),
                        BsCol(
                            margin: EdgeInsets.only(top: 10),
                            sizes: ColScreen(lg: Col.col_12),
                            child: FormGroup(
                                label: Text('Business Partner',
                                    style: TextStyle(
                                        color: _navigation.darkTheme.value
                                            ? Colors.white
                                            : Colors.black)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(controller.type.value),
                                    Divider()
                                  ],
                                ))),
                        BsCol(
                            margin: EdgeInsets.only(top: 10),
                            sizes: ColScreen(lg: Col.col_12),
                            child: FormGroup(
                                label: Text('Remind',
                                    style: TextStyle(
                                        color: _navigation.darkTheme.value
                                            ? Colors.white
                                            : Colors.black)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(controller.remind.value.toString()),
                                    Divider()
                                  ],
                                ))),
                        BsCol(
                            margin: EdgeInsets.only(top: 10),
                            sizes: ColScreen(lg: Col.col_12),
                            child: FormGroup(
                                label: Text('Time Zone',
                                    style: TextStyle(
                                        color: _navigation.darkTheme.value
                                            ? Colors.white
                                            : Colors.black)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(controller.timezone.value),
                                    Divider()
                                  ],
                                ))),
                        if (controller.loc.value != '')
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
                                      Tooltip(
                                        message: 'Tap to Copy',
                                        child: InkWell(
                                            onTap: () {
                                              Clipboard.setData(
                                                ClipboardData(
                                                    text: controller.loc.value),
                                              );
                                              Snackbar().copySuccess();
                                            },
                                            child: Text(controller.loc.value)),
                                      ),
                                      Divider()
                                    ],
                                  ))),
                        if (controller.link.value != '')
                          BsCol(
                              margin: EdgeInsets.only(top: 10),
                              sizes: ColScreen(lg: Col.col_12),
                              child: FormGroup(
                                  label: Text('Link',
                                      style: TextStyle(
                                          color: _navigation.darkTheme.value
                                              ? Colors.white
                                              : Colors.black)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Tooltip(
                                        message: 'Tap to Copy',
                                        child: InkWell(
                                            onTap: () {
                                              Clipboard.setData(
                                                ClipboardData(
                                                    text:
                                                        controller.link.value),
                                              );
                                              Snackbar().copySuccess();
                                            },
                                            child: Text(controller.link.value)),
                                      ),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(controller.desc.value),
                                    Divider()
                                  ],
                                ))),
                        if (controller.guest.length != 0)
                          BsCol(
                              margin: EdgeInsets.only(top: 10),
                              sizes: ColScreen(lg: Col.col_12),
                              child: FormGroup(
                                  label: Text('Guest',
                                      style: TextStyle(
                                          color: _navigation.darkTheme.value
                                              ? Colors.white
                                              : Colors.black)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: controller.guest.length,
                                          itemBuilder: (context, index) {
                                            var guest = controller.guest[index];
                                            int x = index + 1;
                                            String permis;

                                            switch (guest.schepermisid) {
                                              case '{1}':
                                                permis = 'Read Only';
                                                break;
                                              case '{2}':
                                                permis = 'Add Member';
                                                break;
                                              case '{3}':
                                                permis = 'Share Link';
                                                break;
                                              default:
                                                permis =
                                                    'Add Member & Share Link';
                                                break;
                                            }

                                            return Container(
                                                margin: EdgeInsets.only(top: 5),
                                                child: Text(x.toString() +
                                                    ' )  ' +
                                                    guest
                                                        .scheuser.userfullname +
                                                    ' ( ' +
                                                    permis +
                                                    ' )'));
                                          }),
                                      Divider()
                                    ],
                                  ))),
                      ],
                    ),
                  ),
                ),
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
                                        Text(controller.createdat.value),
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
                                        Text(controller.updatedat.value),
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
    var guest = [];
    ScheduleModel dt = ScheduleModel.fromJson(response.body);
    controller.title.value = dt.schenm ?? '';
    controller.name.value = dt.schetoward!.userfullname ?? '';
    controller.startdate.value = dt.schestartdate ?? '';
    controller.starttime.value = dt.schestarttime ?? '';
    controller.enddate.value = dt.scheenddate ?? '';
    controller.endtime.value = dt.scheendtime ?? '';
    controller.link.value = dt.scheonlink ?? '';
    controller.loc.value = dt.scheloc ?? '';
    controller.remind.value = dt.scheremind ?? 0;
    controller.timezone.value = dt.schetz ?? '';

    controller.createdby.value = dt.schecreatedby?.userfullname ?? '';
    controller.createdat.value = dt.createddate ?? '';
    controller.updatedby.value = dt.scheupdatedby?.userfullname ?? '';
    controller.updatedat.value = dt.updateddate ?? '';
    controller.isactive.value = dt.isactive ?? false;

    controller.desc.value = dt.schedesc ?? '';
    controller.type.value = dt.schetype!.typename ?? '';
    controller.allday.value = dt.scheallday ?? false;
    controller.online.value = dt.scheonline ?? false;
    controller.private.value = dt.scheprivate ?? false;
    controller.bp.value = dt.schebp!.bpname ?? '';
    if (dt.scheguest != null) {
      for (var item in dt.scheguest!) {
        guest.add(item);
      }
      controller.guest.value = guest;
    }
    presenter.setProcessing(false);
  }
}
