import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/base_text.dart';
import '../../contracts/base/edit_view_contract.dart';
import '../../contracts/base/index_view_contract.dart';
import '../../services/masters/village_service.dart';
import '../../utils/custom_get_controller.dart';
import '../../views/masters/villages/village_form.dart';
import '../../widgets/confirm_dialog.dart';

class VillagePresenter extends CustomGetXController {
  final _villageService = Get.find<VillageService>();

  late IndexViewContract _villageViewContract;
  set villageViewContract(IndexViewContract villageViewContract) {
    _villageViewContract = villageViewContract;
  }

  late EditViewContract _villageFetchDataContract;
  set villageFetchDataContract(EditViewContract villageFetchDataContract) {
    _villageFetchDataContract = villageFetchDataContract;
  }

  Future datatables(BuildContext context, Map<String, String> params) async {
    Response response = await _villageService.datatables(params);
    if (response.statusCode == 200)
      _villageViewContract.onLoadDatatables(context, response);
    else
      _villageViewContract.onErrorRequest(response);
  }

  // void details(BuildContext context, int userid) async {
  //   setProcessing(true);
  //   showDialog(
  //     context: context,
  //     builder: (context) => VillageDetails(),
  //   );

  //   Response response = await _VillageService.show(userid);
  //   if (response.statusCode == 200)
  //     _VillageDataDetailsContract.onSuccessFetchData(response);
  //   else
  //     _VillageViewContract.onErrorRequest(response);
  // }

  void add(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => VillageFormView(
        onSave: (body) => save(context, body),
      ),
    );
  }

  void save(BuildContext context, Map<String, dynamic> body) async {
    Response response = await _villageService.store(body);
    if (response.statusCode == 200)
      _villageViewContract.onCreateSuccess(response, context: context);
    else
      _villageViewContract.onErrorRequest(response);
  }

  void edit(BuildContext context, int id) async {
    setProcessing(true);
    showDialog(
      context: context,
      builder: (context) => VillageFormView(
        onSave: (body) => update(context, body, id),
      ),
    );

    Response response = await _villageService.show(id);
    if (response.statusCode == 200)
      _villageFetchDataContract.onSuccessFetchData(response);
    else
      _villageViewContract.onErrorRequest(response);
  }

  void update(BuildContext context, Map<String, dynamic> body, int id) async {
    setProcessing(true);
    Response response = await _villageService.update(id, body);
    if (response.statusCode == 200)
      _villageViewContract.onEditSuccess(response, context: context);
    else
      _villageViewContract.onErrorRequest(response);
  }

  void delete(BuildContext context, int typeid, String name) {
    showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
        title: BaseText.confirmTitle,
        message: BaseText.deleteConfirmDatatable(field: name),
        onPressed: (_, value) async {
          if (value == ConfirmDialogOption.YES_OPTION) {
            Response response = await _villageService.destroy(typeid);
            if (response.statusCode == 200)
              _villageViewContract.onDeleteSuccess(response, context: context);
            else
              _villageViewContract.onErrorRequest(response);
          } else {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
