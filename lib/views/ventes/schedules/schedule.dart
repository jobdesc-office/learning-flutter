import 'dart:math';

import 'package:boilerplate/contracts/base/index_view_contract.dart';
import 'package:boilerplate/contracts/ventes/schedule_contract.dart';
import 'package:boilerplate/presenters/navigation_presenter.dart';
import 'package:boilerplate/styles/color_palattes.dart';
import 'package:boilerplate/utils/handle_error_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../helpers/function.dart';
import '../../../models/ventes/schedule_model.dart';
import '../../../presenters/ventes/schedule_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/button/theme_button_create.dart';
import '../../../widgets/map/_map_source.dart';
import '../../../widgets/snackbar.dart';
import '../../skins/template.dart';
import '_schedule_source.dart';
import '_text.dart';

class ScheduleView extends GetView
    implements HandleErrorRequest, IndexViewContract, ScheduleContract {
  final presenter = Get.find<SchedulePresenter>();
  final map = Get.put(MapSource());
  final _nav = Get.find<NavigationPresenter>();
  final source = Get.put(ScheduleSource());

  ScheduleView() {
    presenter.scheduleViewContract = this;
    presenter.scheduleContract = this;
    presenter.getDataFromAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        title: ScheduleText.title,
        breadcrumbs: [
          BreadcrumbWidget('Venteses'),
          BreadcrumbWidget('Schedule', active: true),
        ],
        activeRoutes: [RouteList.master.index, RouteList.ventesSchedule.index],
        child: Obx(() => Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ThemeButtonCreate(
                      margin: EdgeInsets.only(bottom: 5),
                      prefix: ScheduleText.title,
                      onPressed: () => presenter.add(context),
                    )
                  ],
                ),
                if (source.done.value)
                  Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: TableCalendar(
                      calendarStyle: CalendarStyle(),
                      rowHeight: 72,
                      daysOfWeekHeight: 24,
                      headerStyle: HeaderStyle(
                          headerMargin: EdgeInsets.only(bottom: 5),
                          leftChevronIcon: Icon(
                            Icons.chevron_left,
                            color: Colors.white,
                          ),
                          rightChevronIcon: Icon(
                            Icons.chevron_right,
                            color: Colors.white,
                          ),
                          formatButtonTextStyle: TextStyle(color: Colors.white),
                          formatButtonDecoration: BoxDecoration(
                              border: Border.fromBorderSide(
                                  BorderSide(color: Colors.white)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0))),
                          titleTextStyle: TextStyle(color: Colors.white),
                          decoration: BoxDecoration(
                              color: _nav.darkTheme.value
                                  ? ColorPallates.sidebarDarkColor
                                  : ColorPallates.primary,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)))),
                      focusedDay: source.focusedDay.value,
                      firstDay: DateTime.utc(2022, 1, 1),
                      lastDay: DateTime.utc(DateTime.now().year + 1, 12, 31),
                      eventLoader: getScheduleInDate,
                      calendarBuilders: CalendarBuilders(
                        markerBuilder: (_, date, schedules) {
                          return schedules.isNotEmpty
                              ? Container(
                                  width: 20,
                                  height: 20,
                                  margin: EdgeInsets.only(bottom: 5),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${schedules.length}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.primaries[Random()
                                        .nextInt(Colors.primaries.length)],
                                  ),
                                )
                              : SizedBox();
                        },
                      ),
                      onDaySelected:
                          (DateTime selectedDay, DateTime focusedDay) {
                        source.focusedDay.value = selectedDay;
                        Get.snackbar(
                            '${source.focusedDay.value}', '$focusedDay');
                      },
                    ),
                  )
                else
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Center(
                      child: Text('Proccessing ...'),
                    ),
                  )
              ],
            )),
      ),
    );
  }

  List<ScheduleModel> getScheduleInDate(DateTime date) {
    date = DateTime(date.year, date.month, date.day);
    return source.data.where((element) {
      DateTime startDate = parseDate(element.schestartdate)!;
      bool result = date.isAtSameMomentAs(startDate);

      // if (element.scheenddate != null) {
      //   DateTime endDate = parseDate(element.scheenddate)!;
      //   result = result ||
      //       date.isAtSameMomentAs(endDate) ||
      //       (date.isAfter(startDate) && date.isBefore(endDate));
      // }
      return result;
    }).toList();
  }

  @override
  void onCreateSuccess(Response response, {BuildContext? context}) {
    presenter.setProcessing(false);
    map.reset();
    Snackbar().createSuccess();
    Get.toNamed(RouteList.ventesSchedule.index);
    Navigator.pop(context!);
  }

  @override
  void onDeleteSuccess(Response response, {BuildContext? context}) {
    presenter.setProcessing(false);
    map.reset();
    Snackbar().deleteSuccess();
    Get.toNamed(RouteList.ventesSchedule.index);
    Navigator.pop(context!);
  }

  @override
  void onEditSuccess(Response response, {BuildContext? context}) {
    presenter.setProcessing(false);
    map.reset();
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
    map.reset();
    presenter.setProcessing(false);
  }

  @override
  void onLoadScheduleSuccess(List<ScheduleModel> response) {
    source.data.value = response;
    source.done.value = true;
  }
}
