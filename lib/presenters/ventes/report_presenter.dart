import 'dart:convert';

import 'package:boilerplate/contracts/base/recap_view_contract.dart';
import 'package:boilerplate/helpers/function.dart';
import 'package:boilerplate/models/session_model.dart';
import 'package:boilerplate/utils/google_api_service.dart';
import 'package:boilerplate/utils/session_manager.dart';
import 'package:boilerplate/views/ventes/reports/dailyactivity/report_dailyactivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:html';
import 'dart:js' as js;
import 'package:url_launcher/url_launcher.dart';

import '../../contracts/base/details_view_contract.dart';
import '../../contracts/base/index_view_contract.dart';
import '../../contracts/ventes/report_contract.dart';
import '../../models/ventes/report_model.dart';
import '../../services/masters/user_service.dart';
import '../../services/ventes/attendance_service.dart';
import '../../services/ventes/report_service.dart';
import '../../utils/custom_get_controller.dart';
import '../../views/ventes/reports/employees/report_employee.dart';
import '../../views/ventes/reports/nodailyactivity/report_nodailyactivity.dart';
import '../../views/ventes/reports/report_detail.dart';
import '../../widgets/map/_map_source.dart';
import '../auth_presenter.dart';

class ReportPresenter extends CustomGetXController {
  final _reportService = Get.find<ReportService>();
  final _attendService = Get.find<AttendanceService>();
  final _googleApiService = Get.put(GoogleAPIService());
  final _userService = Get.put(UserService());
  final authPresenter = Get.find<AuthPresenter>();
  final map = Get.put(MapSource());
  final box = GetStorage();

  late IndexViewContract _viewContract;
  set reportDataContract(IndexViewContract reportFetchDataDetailsContract) {
    _viewContract = reportFetchDataDetailsContract;
  }

  late RecapViewContract _recapViewContract;
  set recapViewContract(RecapViewContract recapViewContract) {
    _recapViewContract = recapViewContract;
  }

  late IndexViewContract _reportViewContract;
  set reportFetchDataDetailsContract(
      IndexViewContract reportFetchDataDetailsContract) {
    _reportViewContract = reportFetchDataDetailsContract;
  }

  late IndexViewContract _attendViewContract;
  set attendFetchDataDetailsContract(
      IndexViewContract attendFetchDataDetailsContract) {
    _attendViewContract = attendFetchDataDetailsContract;
  }

  late ReportContract _reportContract;
  set reportContract(ReportContract reportContract) {
    _reportContract = reportContract;
  }

  late DetailViewContract _reportFetchDataDetailsContract;
  set reportsFetchDataDetailsContract(
      DetailViewContract reportFetchDataDetailsContract) {
    _reportFetchDataDetailsContract = reportFetchDataDetailsContract;
  }

  getDataFromAPI() async {
    Response response = await _reportService.bpid(box.read('mybpid'));

    _reportContract.onLoadReportSuccess(ReportModel.fromJson(response.body));
  }

  Future datatabless(BuildContext context, Map<String, String> params,
      {start, end, categoryid}) async {
    Response response = await _reportService.datatablesbp(params,
        start: start, end: end, categoryid: categoryid);
    if (response.statusCode == 200)
      _viewContract.onLoadDatatables(context, response);
    else
      _viewContract.onErrorRequest(response);
  }

  Future datatables(BuildContext context, Map<String, String> params) async {
    Response response =
        await _userService.datatablesbp(params, box.read('mybpid'));
    if (response.statusCode == 200)
      _reportViewContract.onLoadDatatables(context, response);
    else
      _reportViewContract.onErrorRequest(response);
  }

  Future recapDatatables({start, end, startdate, enddate}) async {
    int currentMonth = DateTime.now().month;
    Response response = await _attendService.recap(
      start: start,
      end: end,
      startdate: startdate ?? currentMonth,
      enddate: enddate,
      bpid: box.read('mybpid'),
    );
    if (response.statusCode == 200)
      _recapViewContract.onLoadDatatables(response);
    else
      _recapViewContract.onErrorRequest(response);
  }

  Future indonesiaHolidays() async {
    Response response = await _googleApiService.getHolidays();
    if (response.statusCode == 200)
      _recapViewContract.onLoadHolidays(response);
    else
      _recapViewContract.onErrorRequest(response);
  }

  Future exportExcelRecap({start, end, startdate, enddate}) async {
    SessionModel session = await SessionManager.current();
    js.context.callMethod('open', [
      _attendService.exportRecap(
          parseString(start),
          parseString(end),
          parseString(startdate),
          parseString(enddate),
          parseString(box.read('mybpid')),
          parseString(session.jwtToken))
    ]);
  }

  Future attenddatatables(BuildContext context, Map<String, String> params,
      {start, end, userid}) async {
    Response response = await _attendService.datatablesbp(params,
        start: start, end: end, userid: userid);
    if (response.statusCode == 200)
      _attendViewContract.onLoadDatatables(context, response);
    else
      _attendViewContract.onErrorRequest(response);
  }

  void details(BuildContext context, int scheid) async {
    setProcessing(true);
    showDialog(
      context: context,
      builder: (context) => ReportDetail(),
    );

    Response response = await _reportService.show(scheid);
    if (response.statusCode == 200)
      _reportFetchDataDetailsContract.onSuccessFetchData(response);
    else
      _reportViewContract.onErrorRequest(response);
  }

  void detailsDayAct(BuildContext context, List<Activities> act) async {
    setProcessing(true);
    showDialog(
      context: context,
      builder: (context) => ReportDailyActivities(
        act: act,
      ),
    );
  }

  void detailsNoDayAct(BuildContext context, List<Dayactuser> act) async {
    setProcessing(true);
    showDialog(
      context: context,
      builder: (context) => ReportNoDailyActivities(
        act: act,
      ),
    );
  }

  void detailsEmployees(BuildContext context) async {
    setProcessing(true);
    showDialog(
      context: context,
      builder: (context) => ReportEmployees(),
    );
  }
}
