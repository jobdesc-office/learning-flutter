import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/base_text.dart';
import '../../contracts/base/details_view_contract.dart';
import '../../contracts/base/edit_view_contract.dart';
import '../../contracts/base/index_view_contract.dart';
import '../../services/ventes/prospectproduct_service.dart';
import '../../utils/custom_get_controller.dart';
import '../../views/ventes/prospect/prospectproduct/prospect_detail.dart';
import '../../views/ventes/prospect/prospectproduct/prospectproduct_form.dart';
import '../../widgets/confirm_dialog.dart';

class ProspectProductPresenter extends CustomGetXController {
  final _prospectService = Get.find<ProspectProductService>();

  late IndexViewContract _prospectViewContract;
  set prospectViewContract(IndexViewContract prospectViewContract) {
    _prospectViewContract = prospectViewContract;
  }

  late EditViewContract _prospectFetchDataContract;
  set setprospectFetchDataContract(EditViewContract prospectFetchDataContract) {
    _prospectFetchDataContract = prospectFetchDataContract;
  }

  late DetailViewContract _prospectTypeViewContract;
  set prospectProductViewContract(DetailViewContract prospectViewContract) {
    _prospectTypeViewContract = prospectViewContract;
  }

  void add(BuildContext context, int id) async {
    showDialog(
      context: context,
      builder: (context) => ProspectProductFormView(
          onSave: (body) => save(context, body), id: id),
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
      builder: (context) => ProspectProductDetails(),
    );
    Response response = await _prospectService.show(userid);
    if (response.statusCode == 200)
      _prospectTypeViewContract.onSuccessFetchData(response);
    else
      _prospectViewContract.onErrorRequest(response);
  }

  void edit(BuildContext context, int prospectid, int id) async {
    setProcessing(true);
    showDialog(
      context: context,
      builder: (context) => ProspectProductFormView(
          onSave: (body) => update(context, body, prospectid), id: id),
    );

    Response response = await _prospectService.show(prospectid);
    if (response.statusCode == 200)
      _prospectFetchDataContract.onSuccessFetchData(response);
    else
      _prospectViewContract.onErrorRequest(response);
  }

  void update(
      BuildContext context, Map<String, dynamic> body, int prospectid) async {
    setProcessing(true);
    Response response = await _prospectService.update(prospectid, body);
    if (response.statusCode == 200)
      _prospectViewContract.onEditSuccess(response, context: context);
    else
      _prospectViewContract.onErrorRequest(response);
  }

  void delete(BuildContext context, int prospectid, String name) {
    showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
        title: BaseText.confirmTitle,
        message: BaseText.deleteConfirmDatatable(field: name),
        onPressed: (_, value) async {
          if (value == ConfirmDialogOption.YES_OPTION) {
            Response response = await _prospectService.destroy(prospectid);
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
