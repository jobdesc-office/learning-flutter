import 'package:boilerplate/views/ventes/reports/dailyactivity/report_dailyactivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../contracts/base/index_view_contract.dart';
import '../../contracts/ventes/report_contract.dart';
import '../../models/ventes/report_model.dart';
import '../../services/masters/user_service.dart';
import '../../services/ventes/report_service.dart';
import '../../utils/custom_get_controller.dart';
import '../../views/ventes/reports/employees/report_employee.dart';
import '../../views/ventes/reports/nodailyactivity/report_nodailyactivity.dart';
import '../../widgets/map/_map_source.dart';
import '../auth_presenter.dart';

class ReportPresenter extends CustomGetXController {
  final _reportService = Get.find<ReportService>();
  final _userService = Get.put(UserService());
  final authPresenter = Get.find<AuthPresenter>();
  final map = Get.put(MapSource());
  final box = GetStorage();

  late IndexViewContract _viewContract;
  set reportDataContract(IndexViewContract reportFetchDataDetailsContract) {
    _viewContract = reportFetchDataDetailsContract;
  }

  late IndexViewContract _reportViewContract;
  set reportFetchDataDetailsContract(
      IndexViewContract reportFetchDataDetailsContract) {
    _reportViewContract = reportFetchDataDetailsContract;
  }

  late ReportContract _reportContract;
  set reportContract(ReportContract reportContract) {
    _reportContract = reportContract;
  }

  getDataFromAPI() async {
    Response response = await _reportService.bpid(box.read('mybpid'));

    _reportContract.onLoadReportSuccess(ReportModel.fromJson(response.body));
  }

  Future datatabless(BuildContext context, Map<String, String> params) async {
    Response response = await _reportService.datatablesbp(params);
    if (response.statusCode == 200)
      _viewContract.onLoadDatatables(context, response);
    else
      _viewContract.onErrorRequest(response);
  }

  Future datatables(BuildContext context, Map<String, String> params) async {
    Response response = await _userService.datatables(params);
    if (response.statusCode == 200)
      _reportViewContract.onLoadDatatables(context, response);
    else
      _reportViewContract.onErrorRequest(response);
  }

  void details(BuildContext context, List<Activities> act) async {
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
