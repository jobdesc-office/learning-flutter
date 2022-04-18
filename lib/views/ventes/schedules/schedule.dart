import 'package:boilerplate/utils/handle_error_request.dart';
import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../contracts/base/index_view_contract.dart';
import '../../../presenters/ventes/schedule_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/button/theme_button_create.dart';
import '../../skins/tempalte.dart';
import '_schedule_source.dart';
import '_text.dart';

class ScheduleView extends GetView
    implements IndexViewContract, HandleErrorRequest {
  final presenter = Get.find<SchedulePresenter>();

  ScheduleView() {
    presenter.scheduleViewContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        title: ScheduleText.title,
        breadcrumbs: [
          BreadcrumbWidget('Dashboard', route: RouteList.home.index),
          BreadcrumbWidget('Masters'),
          BreadcrumbWidget('Schedule', active: true),
        ],
        activeRoutes: [RouteList.master.index, RouteList.masterSchedule.index],
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ThemeButtonCreate(
                  prefix: ScheduleText.title,
                  onPressed: () => presenter.add(context),
                )
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              child: FutureBuilder(
                future: presenter.getDataFromAPI(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data != null) {
                    return SfCalendar(
                      monthViewSettings: MonthViewSettings(
                        appointmentDisplayMode:
                            MonthAppointmentDisplayMode.indicator,
                      ),
                      onTap: (value) {},
                      onLongPress: (value) {},
                      view: CalendarView.month,
                      dataSource: ScheduleSource(snapshot.data),
                    );
                  } else {
                    // print(snapshot.data);
                    return Container(
                      child: Center(
                        child: Text('Error'),
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void onCreateSuccess(Response response, {BuildContext? context}) {
    presenter.setProcessing(false);
    if (context != null) Navigator.pop(context);
  }

  @override
  void onDeleteSuccess(Response response, {BuildContext? context}) {
    presenter.setProcessing(false);
    if (context != null) Navigator.pop(context);
  }

  @override
  void onEditSuccess(Response response, {BuildContext? context}) {
    presenter.setProcessing(false);
    if (context != null) Navigator.pop(context);
  }

  @override
  void onErrorRequest(Response response) {
    presenter.setProcessing(false);
    print(response);
  }

  @override
  void onLoadDatatables(BuildContext context, Response response) {
    presenter.setProcessing(false);
  }
}
