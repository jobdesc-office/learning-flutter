import 'package:boilerplate/contracts/base/index_view_contract.dart';
import 'package:boilerplate/utils/handle_error_request.dart';
import 'package:boilerplate/widgets/button/button_delete_datatable.dart';
import 'package:boilerplate/widgets/button/button_edit_datatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../models/ventes/schedule_model.dart';
import '../../../presenters/ventes/schedule_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/button/theme_button_create.dart';
import '../../../widgets/snackbar.dart';
import '../../skins/template.dart';
import '_schedule_source.dart';
import '_text.dart';

class ScheduleView extends GetView
    implements HandleErrorRequest, IndexViewContract {
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
          BreadcrumbWidget('Venteses'),
          BreadcrumbWidget('Schedule', active: true),
        ],
        activeRoutes: [RouteList.master.index, RouteList.ventesSchedule.index],
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
                        showAgenda: true,
                        appointmentDisplayMode:
                            MonthAppointmentDisplayMode.indicator,
                      ),
                      onTap: (details) {
                        if (details.targetElement ==
                                CalendarElement.appointment ||
                            details.targetElement == CalendarElement.agenda) {
                          final ScheduleModel _meeting =
                              details.appointments![0];

                          presenter.details(context, _meeting.scheid);
                        }
                      },
                      onLongPress: (details) {
                        if (details.targetElement ==
                                CalendarElement.appointment ||
                            details.targetElement == CalendarElement.agenda) {
                          final ScheduleModel _meeting =
                              details.appointments![0];

                          Get.defaultDialog(
                              title: 'Actions',
                              content: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ButtonEditDatatables(onPressed: () {
                                    presenter.edit(context, _meeting.scheid);
                                  }),
                                  ButtonDeleteDatatables(
                                    onPressed: () {
                                      presenter.delete(
                                          context, _meeting.scheid);
                                    },
                                  )
                                ],
                              ));
                        }
                      },
                      view: CalendarView.month,
                      dataSource: ScheduleSource(snapshot.data),
                    );
                  } else {
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

  void calendarTapped(CalendarTapDetails details) {}

  @override
  void onCreateSuccess(Response response, {BuildContext? context}) {
    presenter.setProcessing(false);
    Snackbar().createSuccess();
    Get.toNamed(RouteList.ventesSchedule.index);
    Navigator.pop(context!);
  }

  @override
  void onDeleteSuccess(Response response, {BuildContext? context}) {
    presenter.setProcessing(false);
    Snackbar().deleteSuccess();
    Get.toNamed(RouteList.ventesSchedule.index);
    Navigator.pop(context!);
  }

  @override
  void onEditSuccess(Response response, {BuildContext? context}) {
    presenter.setProcessing(false);
    Snackbar().editSuccess();
    Get.toNamed(RouteList.ventesSchedule.index);
    Navigator.pop(context!);
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
