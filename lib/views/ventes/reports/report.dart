import 'dart:math';

import 'package:boilerplate/contracts/base/index_view_contract.dart';
import 'package:boilerplate/models/ventes/schedule_model.dart';
import 'package:boilerplate/presenters/navigation_presenter.dart';
import 'package:boilerplate/styles/color_palattes.dart';
import 'package:boilerplate/utils/handle_error_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../contracts/ventes/report_contract.dart';
import '../../../contracts/ventes/schedule_contract.dart';
import '../../../helpers/function.dart';
import '../../../models/ventes/report_model.dart';
import '../../../presenters/ventes/report_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/map/_map_source.dart';
import '../../../widgets/snackbar.dart';
import '../../skins/template.dart';
import '_report_source.dart';
import '_text.dart';

class ReportView extends GetView
    implements HandleErrorRequest, IndexViewContract, ReportContract {
  final presenter = Get.find<ReportPresenter>();
  final map = Get.put(MapSource());
  final _nav = Get.find<NavigationPresenter>();
  final source = Get.put(ReportHelper());

  ReportView() {
    presenter.reportContract = this;
    presenter.getDataFromAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        title: ReportText.title,
        breadcrumbs: [
          BreadcrumbWidget('Venteses'),
          BreadcrumbWidget('Report', active: true),
        ],
        activeRoutes: [RouteList.master.index, RouteList.ventesReport.index],
        child: Obx(() => SingleChildScrollView(
              child: Column(
                children: [
                  if (source.done.value)
                    TableCalendar<Activities>(
                      calendarStyle: CalendarStyle(
                          todayDecoration: BoxDecoration(
                              color: ColorPallates.primary,
                              shape: BoxShape.circle)),
                      rowHeight: 160,
                      daysOfWeekHeight: 24,
                      headerStyle: HeaderStyle(
                          formatButtonVisible: false,
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
                      lastDay: DateTime.utc(DateTime.now().year, 12, 31),
                      eventLoader: getReportInDate,
                      calendarBuilders: CalendarBuilders(
                        outsideBuilder: (context, date, events) =>
                            source.dayContainer(
                          context,
                          date,
                          outsideDay: true,
                          color: Color.fromARGB(255, 156, 156, 156),
                        ),
                        todayBuilder: (context, date, events) =>
                            source.dayContainer(
                          context,
                          date,
                          color: Colors.white,
                          textBackground: ColorPallates.tertiary,
                        ),
                        defaultBuilder: (context, date, _) =>
                            source.dayContainer(context, date),
                        markerBuilder: (_, date, reports) {
                          List<int> employee = source.employees;
                          for (var item in reports) {
                            employee.removeWhere(
                                (element) => element == item.createdby);
                          }

                          return reports.isNotEmpty
                              ? InkWell(
                                  onTap: () {
                                    source.focusedDay.value = date;
                                    // source.tappedData.value = Reports;
                                    source.isTap.value = true;
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(top: 50),
                                    child: Column(
                                      children: [
                                        InkWell(
                                          onTap: () => presenter.details(
                                              context, reports),
                                          child: Container(
                                            width: 150,
                                            height: 20,
                                            margin: EdgeInsets.only(bottom: 5),
                                            padding: EdgeInsets.only(left: 5),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Daily Activity : ${reports.length}",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)),
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 150,
                                          height: 20,
                                          margin: EdgeInsets.only(bottom: 5),
                                          padding: EdgeInsets.only(left: 5),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "No Daily Activity : ${employee.length}",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                            color: Colors.green,
                                          ),
                                        ),
                                        Container(
                                          width: 150,
                                          height: 20,
                                          margin: EdgeInsets.only(bottom: 5),
                                          padding: EdgeInsets.only(left: 5),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Employees : ${source.employeesCount.value}",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                            color: Colors.purple,
                                          ),
                                        ),
                                        Container(
                                          width: 150,
                                          height: 20,
                                          margin: EdgeInsets.only(bottom: 5),
                                          padding: EdgeInsets.only(left: 5),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Other : ${reports.length}",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : SizedBox();
                        },
                      ),
                    )
                  else
                    Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Center(
                        child: Text('Proccessing ...'),
                      ),
                    ),
                ],
              ),
            )),
      ),
    );
  }

  List<Activities> getReportInDate(DateTime date) {
    date = DateTime(date.year, date.month, date.day);
    return source.data.where((element) {
      DateTime startDate = parseDate(element.dayactdate)!;
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
    Navigator.pop(context!);
  }

  @override
  void onDeleteSuccess(Response response, {BuildContext? context}) {
    source.done.value = true;
    presenter.setProcessing(false);
    map.reset();
    Snackbar().deleteSuccess();
    Navigator.pop(context!);
  }

  @override
  void onEditSuccess(Response response, {BuildContext? context}) {
    presenter.setProcessing(false);
    map.reset();
    Snackbar().editSuccess();
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
  void onLoadReportSuccess(ReportModel response) {
    final data = <Activities>[];
    for (var item in response.activities!) {
      data.add(item);
    }
    source.data.value = data;

    final employees = <int>[];
    for (var item in response.employees!) {
      employees.add(item.userid!);
    }
    source.employees.value = employees;
    source.employeesCount.value = employees.length;

    source.done.value = true;
  }
}
