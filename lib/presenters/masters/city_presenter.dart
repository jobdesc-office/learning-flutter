import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/base_text.dart';
import '../../contracts/base/edit_view_contract.dart';
import '../../contracts/base/index_view_contract.dart';
import '../../services/masters/city_service.dart';
import '../../utils/custom_get_controller.dart';
import '../../views/masters/cities/city_form.dart';
import '../../widgets/confirm_dialog.dart';

class CityPresenter extends CustomGetXController {
  final _cityService = Get.find<CityService>();

  late IndexViewContract _cityViewContract;
  set cityViewContract(IndexViewContract cityViewContract) {
    _cityViewContract = cityViewContract;
  }

  late EditViewContract _cityFetchDataContract;
  set cityFetchDataContract(EditViewContract cityFetchDataContract) {
    _cityFetchDataContract = cityFetchDataContract;
  }

  Future datatables(BuildContext context, Map<String, String> params) async {
    Response response = await _cityService.datatables(params);
    if (response.statusCode == 200)
      _cityViewContract.onLoadDatatables(context, response);
    else
      _cityViewContract.onErrorRequest(response);
  }

  // void details(BuildContext context, int userid) async {
  //   setProcessing(true);
  //   showDialog(
  //     context: context,
  //     builder: (context) => CityDetails(),
  //   );

  //   Response response = await _CityService.show(userid);
  //   if (response.statusCode == 200)
  //     _CityDataDetailsContract.onSuccessFetchData(response);
  //   else
  //     _CityViewContract.onErrorRequest(response);
  // }

  void add(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => CityFormView(
        onSave: (body) => save(context, body),
      ),
    );
  }

  void save(BuildContext context, Map<String, dynamic> body) async {
    Response response = await _cityService.store(body);
    if (response.statusCode == 200)
      _cityViewContract.onCreateSuccess(response, context: context);
    else
      _cityViewContract.onErrorRequest(response);
  }

  void edit(BuildContext context, int id) async {
    setProcessing(true);
    showDialog(
      context: context,
      builder: (context) => CityFormView(
        onSave: (body) => update(context, body, id),
      ),
    );

    Response response = await _cityService.show(id);
    if (response.statusCode == 200)
      _cityFetchDataContract.onSuccessFetchData(response);
    else
      _cityViewContract.onErrorRequest(response);
  }

  void update(BuildContext context, Map<String, dynamic> body, int id) async {
    setProcessing(true);
    Response response = await _cityService.update(id, body);
    if (response.statusCode == 200)
      _cityViewContract.onEditSuccess(response, context: context);
    else
      _cityViewContract.onErrorRequest(response);
  }

  void delete(BuildContext context, int typeid, String name) {
    showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
        title: BaseText.confirmTitle,
        message: BaseText.deleteConfirmDatatable(field: name),
        onPressed: (_, value) async {
          if (value == ConfirmDialogOption.YES_OPTION) {
            Response response = await _cityService.destroy(typeid);
            if (response.statusCode == 200)
              _cityViewContract.onDeleteSuccess(response, context: context);
            else
              _cityViewContract.onErrorRequest(response);
          } else {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
