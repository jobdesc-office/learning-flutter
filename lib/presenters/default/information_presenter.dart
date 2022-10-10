import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../contracts/base/edit_view_contract.dart';
import '../../contracts/base/index_view_contract.dart';
import '../../contracts/default/information_view_contract.dart';
import '../../services/default/info_service.dart';
import '../../utils/custom_get_controller.dart';
import '../../views/defaults/informations/info_form.dart';

class InformationPresenter extends CustomGetXController {
  final _infoService = Get.put(InfoService());

  late InformationViewContract _infoContract;
  set infoContract(InformationViewContract infoContract) {
    _infoContract = infoContract;
  }

  late IndexViewContract _informationViewContract;
  set informationViewContract(IndexViewContract informationViewContract) {
    _informationViewContract = informationViewContract;
  }

  late EditViewContract _informationFetchDataContract;
  set informationFetchDataContract(
      EditViewContract informationFetchDataContract) {
    _informationFetchDataContract = informationFetchDataContract;
  }

  Future getInfo(String infoname) async {
    Response response = await _infoService.getInfo(infoname);
    if (response.statusCode == 200) _infoContract.onSuccess(response);
  }

  Future datatables(BuildContext context, Map<String, String> params) async {
    Response response = await _infoService.datatables(params);
    if (response.statusCode == 200)
      _informationViewContract.onLoadDatatables(context, response);
    else
      _informationViewContract.onErrorRequest(response);
  }

  // void details(BuildContext context, int userid) async {
  //   setProcessing(true);
  //   showDialog(
  //     context: context,
  //     builder: (context) => informationDetails(),
  //   );

  //   Response response = await _informationService.show(userid);
  //   if (response.statusCode == 200)
  //     _informationDataDetailsContract.onSuccessFetchData(response);
  //   else
  //     _informationViewContract.onErrorRequest(response);
  // }

  void edit(BuildContext context, int id) async {
    setProcessing(true);
    showDialog(
      context: context,
      builder: (context) => InformationFormView(
        onSave: (body) => update(context, body, id),
      ),
    );

    Response response = await _infoService.show(id);
    if (response.statusCode == 200)
      _informationFetchDataContract.onSuccessFetchData(response);
    else
      _informationViewContract.onErrorRequest(response);
  }

  void update(BuildContext context, Map<String, dynamic> body, int id) async {
    setProcessing(true);
    Response response = await _infoService.update(id, body);
    if (response.statusCode == 200)
      _informationViewContract.onEditSuccess(response, context: context);
    else
      _informationViewContract.onErrorRequest(response);
  }

  // void delete(BuildContext context, int typeid, String name) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => ConfirmDialog(
  //       title: BaseText.confirmTitle,
  //       message: BaseText.deleteConfirmDatatable(field: name),
  //       onPressed: (_, value) async {
  //         if (value == ConfirmDialogOption.YES_OPTION) {
  //           Response response = await _informationService.destroy(typeid);
  //           if (response.statusCode == 200)
  //             _informationViewContract.onDeleteSuccess(response, context: context);
  //           else
  //             _informationViewContract.onErrorRequest(response);
  //         } else {
  //           Navigator.pop(context);
  //         }
  //       },
  //     ),
  //   );
  // }
}
