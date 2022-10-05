import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../contracts/default/home_view_contract.dart';
import '../../models/default/dspbystage_model.dart';
import '../../services/default/home_service.dart';
import '../../utils/custom_get_controller.dart';
import '../../views/defaults/home/home.dart';

class HomePresenter extends CustomGetXController {
  final _homeService = Get.find<HomeService>();
  final box = GetStorage();

  late HomeViewContract _homeContract;
  set homeContract(HomeViewContract homeContract) {
    _homeContract = homeContract;
  }

  Future byCust(
      {Map<String, dynamic> params = const {}, String order = 'asc'}) async {
    Response response = await _homeService.byCust(params: params, order: order);
    if (response.statusCode == 200)
      _homeContract.onSuccessDspbycust(response);
    else
      _homeContract.onError(response);
  }

  Future byCustLabel({Map<String, dynamic> params = const {}}) async {
    Response response = await _homeService.byCustLabel(params: params);
    if (response.statusCode == 200)
      _homeContract.onSuccessDspbycustlabel(response);
    else
      _homeContract.onError(response);
  }

  Future byStatus({Map<String, dynamic> params = const {}}) async {
    Response response = await _homeService.byStatus(params: params);
    if (response.statusCode == 200)
      _homeContract.onSuccessDspbystatus(response);
    else
      _homeContract.onError(response);
  }

  Future byStage(
      {Map<String, dynamic> params = const {}, String order = 'asc'}) async {
    Response response =
        await _homeService.byStage(params: params, order: order);
    if (response.statusCode == 200)
      _homeContract.onSuccessDspbystage(response);
    else
      _homeContract.onError(response);
  }

  void detailcust(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => CustDetails(),
    );
  }

  void detailstatus(BuildContext context, String status) async {
    showDialog(
      context: context,
      builder: (context) => StatusDetails(status),
    );
  }
}
