import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/base_text.dart';
import '../../contracts/base/details_view_contract.dart';
import '../../contracts/base/edit_view_contract.dart';
import '../../contracts/base/index_view_contract.dart';
import '../../services/ventes/prospect_service.dart';
import '../../services/ventes/prospectdetail_service.dart';
import '../../utils/custom_get_controller.dart';
import '../../views/ventes/prospect/prospectdetail/prospect_detail.dart';
import '../../views/ventes/prospect/prospectdetail/prospectdetail_form.dart';
import '../../widgets/confirm_dialog.dart';

class ProspectDetailPresenter extends CustomGetXController {
  final _prospectService = Get.find<ProspectDetailService>();

  late IndexViewContract _prospectViewContract;
  set prospectViewContract(IndexViewContract prospectViewContract) {
    _prospectViewContract = prospectViewContract;
  }

  late EditViewContract _prospectFetchDataContract;
  set setProspectFetchDataContract(EditViewContract prospectFetchDataContract) {
    _prospectFetchDataContract = prospectFetchDataContract;
  }

  late DetailViewContract _prospectTypeViewContract;
  set prospectDetailViewContract(DetailViewContract prospectViewContract) {
    _prospectTypeViewContract = prospectViewContract;
  }

  Future details(BuildContext context, Map<String, String> params) async {
    Response response = await _prospectService.prospectDetails(params);
    if (response.statusCode == 200)
      _prospectViewContract.onLoadDatatables(context, response);
    else
      _prospectViewContract.onErrorRequest(response);
  }

  void add(BuildContext context, int id) async {
    showDialog(
      context: context,
      builder: (context) =>
          ProspectDetailFormView(onSave: (body) => save(context, body), id: id),
    );
  }

  void save(BuildContext context, Map<String, dynamic> body) async {
    Response response = await _prospectService.store(body);
    if (response.statusCode == 200)
      _prospectViewContract.onCreateSuccess(response, context: context);
    else
      _prospectViewContract.onErrorRequest(response);
  }

  void detail(BuildContext context, int userid) async {
    setProcessing(true);
    showDialog(
      context: context,
      builder: (context) => ProspectDetailDetails(),
    );
    Response response = await _prospectService.show(userid);
    if (response.statusCode == 200)
      _prospectTypeViewContract.onSuccessFetchData(response);
    else
      _prospectViewContract.onErrorRequest(response);
  }

  void edit(BuildContext context, int Prospectid, int id) async {
    setProcessing(true);
    showDialog(
      context: context,
      builder: (context) => ProspectDetailFormView(
          onSave: (body) => update(context, body, Prospectid), id: id),
    );

    Response response = await _prospectService.show(Prospectid);
    if (response.statusCode == 200)
      _prospectFetchDataContract.onSuccessFetchData(response);
    else
      _prospectViewContract.onErrorRequest(response);
  }

  void update(
      BuildContext context, Map<String, dynamic> body, int Prospectid) async {
    setProcessing(true);
    Response response = await _prospectService.update(Prospectid, body);
    if (response.statusCode == 200)
      _prospectViewContract.onEditSuccess(response, context: context);
    else
      _prospectViewContract.onErrorRequest(response);
  }

  void delete(BuildContext context, int Prospectid, String name) {
    showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
        title: BaseText.confirmTitle,
        message: BaseText.deleteConfirmDatatable(field: name),
        onPressed: (_, value) async {
          if (value == ConfirmDialogOption.YES_OPTION) {
            Response response = await _prospectService.destroy(Prospectid);
            if (response.statusCode == 200)
              _prospectViewContract.onDeleteSuccess(response, context: context);
            else
              _prospectViewContract.onErrorRequest(response);
          } else {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
