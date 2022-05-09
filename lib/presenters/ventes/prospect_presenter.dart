import 'package:flutter/material.dart';

import '../../utils/custom_get_controller.dart';
import '../../views/ventes/prospect/prospect_detail.dart';
import '../../views/ventes/prospect/prospect_form.dart';

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

  void details(BuildContext context, int userid) async {
    setProcessing(true);
    showDialog(
      context: context,
      builder: (context) => ProspectDetails(),
    );

    // Response response = await _typeParentService.show(userid);
    // if (response.statusCode == 200)
    //   _typeParentDataDetailsContract.onSuccessFetchData(response);
    // else
    //   _typeParentViewContract.onErrorRequest(response);
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
