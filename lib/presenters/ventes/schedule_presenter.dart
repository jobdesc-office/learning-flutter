import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/base_text.dart';
import '../../contracts/base/details_view_contract.dart';
import '../../contracts/base/edit_view_contract.dart';
import '../../contracts/base/index_view_contract.dart';
import '../../models/ventes/schedule_model.dart';
import '../../services/ventes/schedule_service.dart';
import '../../utils/custom_get_controller.dart';
import '../../views/ventes/schedules/schedule_detail.dart';
import '../../views/ventes/schedules/schedule_form.dart';
import '../../widgets/confirm_dialog.dart';
import '../../widgets/map/_map_source.dart';

class SchedulePresenter extends CustomGetXController {
  List<Color> _colorCollection = <Color>[];
  final _scheduleService = Get.find<ScheduleService>();
  final map = Get.put(mapSource());

  late IndexViewContract _scheduleViewContract;
  set scheduleViewContract(IndexViewContract scheduleViewContract) {
    _scheduleViewContract = scheduleViewContract;
  }

  late DetailViewContract _scheduleFetchDataDetailsContract;
  set scheduleFetchDataDetailsContract(
      DetailViewContract scheduleFetchDataDetailsContract) {
    _scheduleFetchDataDetailsContract = scheduleFetchDataDetailsContract;
  }

  late EditViewContract _scheduleFetchDataContract;
  set scheduleFetchDataContract(EditViewContract scheduleFetchDataContract) {
    _scheduleFetchDataContract = scheduleFetchDataContract;
  }

  Future datatables(BuildContext context, Map<String, String> params) async {
    Response response = await _scheduleService.datatables(params);
    if (response.statusCode == 200)
      _scheduleViewContract.onLoadDatatables(context, response);
    else
      _scheduleViewContract.onErrorRequest(response);
  }

  Future<List<ScheduleModel>> getDataFromAPI() async {
    Response response = await _scheduleService.all();
    var jsonData = response.body;

    final Random random = new Random();
    final List<ScheduleModel> appointmentData = [];
    for (var data in jsonData) {
      _initializeEventColor();
      ScheduleModel meetingData = ScheduleModel(
          scheid: data['scheid'],
          schenm: data['schenm'],
          schestartdate: data['schestartdate'],
          // scheenddate: data['scheenddate'],
          bg: _colorCollection[random.nextInt(9)]
          // scheactdate: data['scheactdate'],
          // schestarttime: data['schestarttime'],
          // scheendtime: data['scheendtime'],
          );
      appointmentData.add(meetingData);
    }
    return appointmentData;
  }

  void _initializeEventColor() {
    _colorCollection.add(const Color(0xFF0F8644));
    _colorCollection.add(const Color(0xFF8B1FA9));
    _colorCollection.add(const Color(0xFFD20100));
    _colorCollection.add(const Color(0xFFFC571D));
    _colorCollection.add(const Color(0xFF36B37B));
    _colorCollection.add(const Color(0xFF01A1EF));
    _colorCollection.add(const Color(0xFF3D4FB5));
    _colorCollection.add(const Color(0xFFE47C73));
    _colorCollection.add(const Color(0xFF636363));
    _colorCollection.add(const Color(0xFF0A8043));
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
    Response response = await _scheduleService.store(body);
    if (response.statusCode == 200) {
      _scheduleViewContract.onCreateSuccess(response, context: context);
    } else
      _scheduleViewContract.onErrorRequest(response);
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

  void edit(BuildContext context, int typeid) async {
    setProcessing(true);
    showDialog(
      context: context,
      builder: (context) => ScheduleFormView(
        onSave: (body) => update(context, body, typeid),
      ),
    );

    Response response = await _scheduleService.show(typeid);
    if (response.statusCode == 200)
      _scheduleFetchDataContract.onSuccessFetchData(response);
    else
      _scheduleViewContract.onErrorRequest(response);
  }

  void update(
      BuildContext context, Map<String, dynamic> body, int typeid) async {
    setProcessing(true);
    Response response = await _scheduleService.update(typeid, body);
    if (response.statusCode == 200) {
      _scheduleViewContract.onEditSuccess(response, context: context);
    } else
      _scheduleViewContract.onErrorRequest(response);
  }

  void delete(BuildContext context, int typeid, String name) {
    showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
        title: BaseText.confirmTitle,
        message: BaseText.deleteConfirmDatatable(field: name),
        onPressed: (_, value) async {
          if (value == ConfirmDialogOption.YES_OPTION) {
            Response response = await _scheduleService.destroy(typeid);
            if (response.statusCode == 200)
              _scheduleViewContract.onDeleteSuccess(response, context: context);
            else
              _scheduleViewContract.onErrorRequest(response);
          } else {
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  // DateTime _convertDateFromString(String date) {
  //   return DateTime.parse(date);
  // }
}
