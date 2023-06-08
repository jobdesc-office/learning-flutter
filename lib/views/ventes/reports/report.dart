// ignore_for_file: invalid_use_of_protected_member

import 'package:boilerplate/contracts/base/calendar_view_contract.dart';
import 'package:boilerplate/widgets/datatables/custom_datatable.dart';
import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../../../models/masters/user_model.dart';

import '../../../constants/base_text.dart';
import '../../../contracts/base/index_view_contract.dart';
import '../../../contracts/ventes/report_contract.dart';
import '../../../helpers/function.dart';
import '../../../models/ventes/report_model.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../presenters/ventes/report_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../styles/color_palattes.dart';
import '../../../utils/handle_error_request.dart';
import '../../../utils/select_api.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/map/_map_source.dart';
import '../../../widgets/selectbox/custom_selectbox.dart';
import '../../../widgets/snackbar.dart';
import '../../skins/template.dart';
import '_datatable_source.dart';
import '_report_source.dart';
import '_text.dart';
import 'tabs/attendance_source/_datatable_source.dart';

part 'tabs/dailyactivity_tab.dart';
part 'tabs/attendance_tab.dart';
part 'tabs/calendars_tab.dart';

class ReportView extends StatefulWidget {
  const ReportView({Key? key}) : super(key: key);

  @override
  State<ReportView> createState() => _ReportViewState();
}

final presenter = Get.find<ReportPresenter>();
final map = Get.put(MapSource());
final _nav = Get.find<NavigationPresenter>();
final source = Get.put(ReportHelper());

late TabController _tabControllers;

class _ReportViewState extends State<ReportView>
    with TickerProviderStateMixin
    implements HandleErrorRequest, IndexViewContract, ReportContract {
  @override
  void initState() {
    super.initState();
    _tabControllers = TabController(length: 3, vsync: this);
    presenter.reportContract = this;
    presenter.getDataFromAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        title: ReportText.title,
        breadcrumbs: [
          BreadcrumbWidget('Ventes'),
          BreadcrumbWidget('Report', active: true),
        ],
        activeRoutes: [RouteList.master.index, RouteList.ventesReport.index],
        background: true,
        child: Column(
          children: [
            Obx(() => Container(
                  child: BsRow(
                    children: [
                      BsCol(
                        sizes: ColScreen(sm: Col.col_3),
                        child: TabBar(
                            labelColor: Colors.green,
                            controller: _tabControllers,
                            unselectedLabelColor: _nav.darkTheme.value
                                ? Colors.white
                                : Colors.black,
                            tabs: [
                              Tab(
                                text: 'Daily Activity',
                              ),
                              Tab(
                                text: 'Attendance',
                              ),
                              Tab(
                                text: 'Calendars',
                              )
                            ]),
                      ),
                    ],
                  ),
                )),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: TabBarView(controller: _tabControllers, children: [
                DailyActivityTab(),
                AttendanceTab(),
                CalendarsTab()
              ]),
            )
          ],
        ),
      ),
    );
  }

  @override
  void onCreateSuccess(Response response, {BuildContext? context}) {
    presenter.setProcessing(false);
    map.reset();
    Snackbar().createSuccess(context!);
    Navigator.pop(context);
  }

  @override
  void onDeleteSuccess(Response response, {BuildContext? context}) {
    source.done.value = true;
    presenter.setProcessing(false);
    map.reset();
    Snackbar().deleteSuccess(context!);
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
  void onErrorRequest(Response response, {context}) {
    presenter.setProcessing(false);
  }

  @override
  void onLoadDatatables(BuildContext context, Response response) {
    final datatable = ReportDataTableSource();
    map.reset();
    presenter.setProcessing(false);
    datatable.response = BsDatatableResponse.createFromJson(response.body);
    datatable.onDetailsListener =
        (userid) => presenter.details(context, userid);
  }

  @override
  void onLoadReportSuccess(ReportModel response) {
    final data = <Activities>[];
    for (var item in response.activities!) {
      data.add(item);
    }
    source.data.value = data;

    final employees = <Dayactuser>[];
    for (var item in response.employees!) {
      employees.add(item);
    }
    source.employees.value = employees;
    source.employeesCount.value = employees.length;

    source.done.value = true;
  }
}
