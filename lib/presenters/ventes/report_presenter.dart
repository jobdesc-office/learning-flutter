import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../constants/base_text.dart';
import '../../contracts/base/details_view_contract.dart';
import '../../contracts/base/edit_view_contract.dart';
import '../../contracts/base/index_view_contract.dart';
import '../../contracts/ventes/report_contract.dart';
import '../../contracts/ventes/schedule_contract.dart';
import '../../models/ventes/report_model.dart';
import '../../services/ventes/report_service.dart';
import '../../utils/custom_get_controller.dart';
import '../../views/ventes/reports/report_detail.dart';
import '../../widgets/confirm_dialog.dart';
import '../../widgets/map/_map_source.dart';
import '../auth_presenter.dart';

class ReportPresenter extends CustomGetXController {
  final _reportService = Get.find<ReportService>();
  final authPresenter = Get.find<AuthPresenter>();
  final map = Get.put(MapSource());
  final box = GetStorage();

  late DetailViewContract _reportFetchDataDetailsContract;
  set reportFetchDataDetailsContract(
      DetailViewContract reportFetchDataDetailsContract) {
    _reportFetchDataDetailsContract = reportFetchDataDetailsContract;
  }

  late ReportContract _reportContract;
  set reportContract(ReportContract reportContract) {
    _reportContract = reportContract;
  }

  getDataFromAPI() async {
    Response response = await _reportService.bpid(box.read('mybpid'));

    _reportContract.onLoadReportSuccess(ReportModel.fromJson(response.body));
  }

  void details(BuildContext context, int scheid) async {
    setProcessing(true);
    showDialog(
      context: context,
      builder: (context) => ReportDetails(),
    );

    Response response = await _reportService.show(scheid);
    if (response.statusCode == 200)
      _reportFetchDataDetailsContract.onSuccessFetchData(response);
  }
}
