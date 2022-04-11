import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../contracts/base/details_view_contract.dart';
import '../../contracts/base/index_view_contract.dart';
import '../../services/masters/schedule_service.dart';
import '../../utils/custom_get_controller.dart';
import '../../views/ventes/schedules/schedule_detail.dart';
import '../../views/ventes/schedules/schedule_form.dart';

class SchedulePresenter extends CustomGetXController {
  final _scheduleService = Get.find<ScheduleService>();

  late IndexViewContract _scheduleViewContract;
  set scheduleViewContract(IndexViewContract scheduleViewContract) {
    _scheduleViewContract = scheduleViewContract;
  }

  late DetailViewContract _scheduleFetchDataDetailsContract;
  set scheduleFetchDataDetailsContract(
      DetailViewContract scheduleFetchDataDetailsContract) {
    _scheduleFetchDataDetailsContract = scheduleFetchDataDetailsContract;
  }

  Future datatables(BuildContext context, Map<String, String> params) async {
    Response response = await _scheduleService.datatables(params);
    if (response.statusCode == 200)
      _scheduleViewContract.onLoadDatatables(context, response);
    else
      _scheduleViewContract.onErrorRequest(response);
  }

  void add(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => ScheduleFormView(
        onSave: (body) => save(context, body),
      ),
    );
  }

  void save(BuildContext context, Map<String, dynamic> body) async {
    // Response response = await _typeChildrenService.store(body);
    // if (response.statusCode == 200)
    //   _typeChildrenViewContract.onCreateSuccess(response, context: context);
    // else
    //   _typeChildrenViewContract.onErrorRequest(response);
  }

  void details(BuildContext context, int scheid) async {
    setProcessing(true);
    showDialog(
      context: context,
      builder: (context) => ScheduleDetails(),
    );

    Response response = await _scheduleService.show(scheid);
    if (response.statusCode == 200)
      _scheduleFetchDataDetailsContract.onSuccessFetchData(response);
    else
      _scheduleViewContract.onErrorRequest(response);
  }
}
