import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/base_text.dart';
import '../../constants/config_types.dart';
import '../../contracts/base/edit_view_contract.dart';
import '../../contracts/base/index_view_contract.dart';
import '../../services/masters/type_service.dart';
import '../../utils/custom_get_controller.dart';
import '../../views/ventes/prospect/prospect.dart';
import '../../views/ventes/prospect/prospect_form.dart';
import '../../widgets/confirm_dialog.dart';

class ProspectPresenter extends CustomGetXController {
  // final _ProspectService = Get.find<ProspectService>();

  // late IndexViewContract _ProspectViewContract;
  // set ProspectViewContract(IndexViewContract ProspectViewContract) {
  //   _ProspectViewContract = ProspectViewContract;
  // }

  // late EditViewContract _ProspectFetchDataContract;
  // set ProspectFetchDataContract(EditViewContract ProspectFetchDataContract) {
  //   _ProspectFetchDataContract = ProspectFetchDataContract;
  // }

  // late ProspectTypeViewContract _ProspectTypeViewContract;
  // set ProspectTypeViewContract(ProspectTypeViewContract ProspectTypeViewContract) {
  //   _ProspectTypeViewContract = ProspectTypeViewContract;
  // }

  // Future datatables(BuildContext context, Map<String, String> params) async {
  //   Response response = await _ProspectService.datatables(params);
  //   if (response.statusCode == 200)
  //     _ProspectViewContract.onLoadDatatables(context, response);
  //   else
  //     _ProspectViewContract.onErrorRequest(response);
  // }

  void add(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => ProspectFormView(
        onSave: (body) => save(context, body),
      ),
    );
  }

  void save(BuildContext context, Map<String, dynamic> body) async {
    // Response response = await _ProspectService.store(body);
    // if (response.statusCode == 200)
    //   _ProspectViewContract.onCreateSuccess(response, context: context);
    // else
    //   _ProspectViewContract.onErrorRequest(response);
  }

  // void edit(BuildContext context, int Prospectid) async {
  //   setProcessing(true);
  //   showDialog(
  //     context: context,
  //     builder: (context) => ProspectFormView(
  //       onSave: (body) => update(context, body, Prospectid),
  //     ),
  //   );

  //   Response response = await _ProspectService.show(Prospectid);
  //   if (response.statusCode == 200)
  //     _ProspectFetchDataContract.onSuccessFetchData(response);
  //   else
  //     _ProspectViewContract.onErrorRequest(response);
  // }

  // void update(
  //     BuildContext context, Map<String, dynamic> body, int Prospectid) async {
  //   setProcessing(true);
  //   Response response = await _ProspectService.update(Prospectid, body);
  //   if (response.statusCode == 200)
  //     _ProspectViewContract.onEditSuccess(response, context: context);
  //   else
  //     _ProspectViewContract.onErrorRequest(response);
  // }

  // void delete(BuildContext context, int Prospectid) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => ConfirmDialog(
  //       title: BaseText.confirmTitle,
  //       message: BaseText.confirmMessage,
  //       onPressed: (_, value) async {
  //         if (value == ConfirmDialogOption.YES_OPTION) {
  //           Response response = await _ProspectService.destroy(Prospectid);
  //           if (response.statusCode == 200)
  //             _ProspectViewContract.onDeleteSuccess(response, context: context);
  //           else
  //             _ProspectViewContract.onErrorRequest(response);
  //         } else {
  //           Navigator.pop(context);
  //         }
  //       },
  //     ),
  //   );
  // }
}
