import 'package:boilerplate/constants/base_text.dart';
import 'package:boilerplate/contracts/base/index_view_contract.dart';
import 'package:boilerplate/contracts/ventes/schedule_contract.dart';
import 'package:boilerplate/presenters/navigation_presenter.dart';
import 'package:boilerplate/styles/color_palattes.dart';
import 'package:boilerplate/utils/handle_error_request.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../helpers/function.dart';
import '../../../middleware/verifyToken.dart';
import '../../../models/ventes/schedule_model.dart';
import '../../../presenters/auth_presenter.dart';
import '../../../presenters/ventes/schedule_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/button/button_delete_datatable.dart';
import '../../../widgets/button/button_edit_datatable.dart';
import '../../../widgets/button/theme_button_create.dart';
import '../../../widgets/map/_map_source.dart';
import '../../../widgets/snackbar.dart';
import '../../skins/template.dart';
import '_schedule_source.dart';
import '_text.dart';

final authPresenter = Get.find<AuthPresenter>();

class ScheduleView extends GetView
    implements HandleErrorRequest, IndexViewContract, ScheduleContract {
  final presenter = Get.find<SchedulePresenter>();
  final map = Get.put(MapSource());
  final _nav = Get.find<NavigationPresenter>();
  final source = Get.put(ScheduleHelper());

  ScheduleView() {
    if (authPresenter.rolepermis.isEmpty) checkJwtToken();
    presenter.scheduleViewContract = this;
    presenter.scheduleContract = this;
    presenter.getDataFromAPI();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: invalid_use_of_protected_member
    var permis = authPresenter.rolepermis.value;
    return Scaffold(
      body: TemplateView(
        title: ScheduleText.title,
        breadcrumbs: [
          BreadcrumbWidget('Ventes'),
          BreadcrumbWidget('Schedule', active: true),
        ],
        activeRoutes: [RouteList.master.index, RouteList.ventesSchedule.index],
        background: true,
        child: Obx(() => Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10, left: 10),
                  child: BsRow(
                    children: [
                      BsCol(
                        sizes: ColScreen(sm: Col.col_1),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 3),
                              color: Color(0xFFFFBA00),
                              child: Text('     '),
                            ),
                            Text('Event')
                          ],
                        ),
                      ),
                      BsCol(
                        sizes: ColScreen(sm: Col.col_1),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 3),
                              color: Color(0xFFDD4A48),
                              child: Text('     '),
                            ),
                            Text('Task')
                          ],
                        ),
                      ),
                      BsCol(
                        sizes: ColScreen(sm: Col.col_1),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 3),
                              color: Color(0xFF01CAE4),
                              child: Text('     '),
                            ),
                            Text('Reminder')
                          ],
                        ),
                      ),
                      if (permis
                          .where((element) => element.menunm == 'Ventes Datas')
                          .first
                          .children!
                          .where((element) => element.menunm == 'Schedule')
                          .first
                          .features!
                          .where((element) => element.featslug == 'create')
                          .first
                          .permissions!
                          .hasaccess!)
                        BsCol(
                          alignment: Alignment.centerRight,
                          sizes: ColScreen(sm: Col.col_9),
                          child: ThemeButtonCreate(
                            margin: EdgeInsets.only(bottom: 5),
                            prefix: ScheduleText.title,
                            onPressed: () {
                              source.done.value = false;
                              presenter.add(context);
                            },
                          ),
                        )
                    ],
                  ),
                ),
                if (source.isTap.value)
                  SingleChildScrollView(
                    child: Column(
                      children: source.tappedData.map((element) {
                        return Tooltip(
                          message: BaseText.editDelete,
                          child: InkWell(
                            onLongPress: () => Get.defaultDialog(
                                middleText: '',
                                title: 'Setting',
                                actions: [
                                  if (permis
                                      .where((element) =>
                                          element.menunm == 'Ventes Datas')
                                      .first
                                      .children!
                                      .where((element) =>
                                          element.menunm == 'Schedule')
                                      .first
                                      .features!
                                      .where((element) =>
                                          element.featslug == 'update')
                                      .first
                                      .permissions!
                                      .hasaccess!)
                                    ButtonEditDatatables(onPressed: () {
                                      source.done.value = false;
                                      presenter.edit(context, element.scheid!);
                                    }),
                                  if (permis
                                      .where((element) =>
                                          element.menunm == 'Ventes Datas')
                                      .first
                                      .children!
                                      .where((element) =>
                                          element.menunm == 'Schedule')
                                      .first
                                      .features!
                                      .where((element) =>
                                          element.featslug == 'delete')
                                      .first
                                      .permissions!
                                      .hasaccess!)
                                    ButtonDeleteDatatables(onPressed: () {
                                      source.done.value = false;
                                      presenter.delete(context, element.scheid!,
                                          '${element.schenm!}');
                                    }),
                                ]),
                            onTap: () =>
                                presenter.details(context, element.scheid!),
                            child: Container(
                              margin: EdgeInsets.only(top: 5),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                color: element.schetype?.typename == 'Event'
                                    ? Color(0xFFFFBA00)
                                    : element.schetype!.typename! == 'Task'
                                        ? Color(0xFFDD4A48)
                                        : Color(0xFF01CAE4),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(element.schenm!),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                if (source.done.value)
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: TableCalendar<ScheduleModel>(
                          calendarStyle: CalendarStyle(
                              todayDecoration: BoxDecoration(
                                  color: ColorPallates.primary,
                                  shape: BoxShape.circle)),
                          rowHeight: 72,
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
                              formatButtonTextStyle:
                                  TextStyle(color: Colors.white),
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
                          eventLoader: getScheduleInDate,
                          calendarBuilders: CalendarBuilders(
                            markerBuilder: (_, date, schedules) {
                              return schedules.isNotEmpty
                                  ? InkWell(
                                      onTap: () {
                                        source.focusedDay.value = date;
                                        source.tappedData.value = schedules;
                                        source.isTap.value = true;
                                      },
                                      child: Container(
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
                                          // color: Colors.primaries[Random()
                                          //     .nextInt(
                                          //         Colors.primaries.length)],
                                          color: ColorPallates.primary,
                                        ),
                                      ),
                                    )
                                  : SizedBox();
                            },
                          ),
                        ),
                      ),
                    ],
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
    // Snackbar().createSuccess(context!);
    Navigator.pop(context!);
  }

  @override
  void onDeleteSuccess(Response response, {BuildContext? context}) {
    presenter.setProcessing(false);
    map.reset();
    Snackbar().deleteSuccess(context!);
    Navigator.pop(context);
    Navigator.pop(context);
  }

  @override
  void onEditSuccess(Response response, {BuildContext? context}) {
    presenter.setProcessing(false);
    map.reset();
    Snackbar().editSuccess(context!);
    Navigator.pop(context);
  }

  @override
  void onErrorRequest(Response response) {
    presenter.setProcessing(false);
  }

  @override
  void onLoadDatatables(BuildContext context, Response response) {
    map.reset();
    presenter.setProcessing(false);
  }

  @override
  void onLoadScheduleSuccess(List<ScheduleModel> response) {
    source.data.clear();
    source.data.value = response;
    source.done.value = true;
  }
}
