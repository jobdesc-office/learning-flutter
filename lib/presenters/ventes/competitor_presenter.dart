import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/base_text.dart';
import '../../contracts/base/details_view_contract.dart';
import '../../contracts/base/edit_view_contract.dart';
import '../../contracts/base/index_view_contract.dart';
import '../../services/masters/city_service.dart';
import '../../services/masters/province_service.dart';
import '../../services/masters/subdistrict_service.dart';
import '../../services/masters/village_service.dart';
import '../../services/ventes/competitor_service.dart';
import '../../utils/connect_internet_api.dart';
import '../../utils/custom_get_controller.dart';
import '../../views/ventes/competitor/competitor_details.dart';
import '../../views/ventes/competitor/competitor_form.dart';
import '../../widgets/confirm_dialog.dart';

class CompetitorPresenter extends CustomGetXController {
  final _CompetitorService = Get.find<CompetitorService>();

  late IndexViewContract _CompetitorViewContract;
  set CompetitorViewContract(IndexViewContract CompetitorViewContract) {
    _CompetitorViewContract = CompetitorViewContract;
  }

  late EditViewContract _CompetitorFetchDataContract;
  set CompetitorFetchDataContract(
      EditViewContract CompetitorFetchDataContract) {
    _CompetitorFetchDataContract = CompetitorFetchDataContract;
  }

  late DetailViewContract _CompetitorDataDetailsContract;
  set CompetitorDataDetailsContract(
      DetailViewContract CompetitorDataDetailsContract) {
    _CompetitorDataDetailsContract = CompetitorDataDetailsContract;
  }

  Future datatables(BuildContext context, Map<String, String> params) async {
    Response response = await _CompetitorService.datatables(params);
    if (response.statusCode == 200)
      _CompetitorViewContract.onLoadDatatables(context, response);
    else
      _CompetitorViewContract.onErrorRequest(response);
  }

  Future cstm(int id) async {
    Response response = await _CompetitorService.show(id);
    return response.body['cstmname'];
  }

  void details(BuildContext context, int userid) async {
    setProcessing(true);
    showDialog(
      context: context,
      builder: (context) => CompetitorDetails(),
    );

    Response response = await _CompetitorService.show(userid);
    if (response.statusCode == 200)
      _CompetitorDataDetailsContract.onSuccessFetchData(response);
    else
      _CompetitorViewContract.onErrorRequest(response);
  }

  void add(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => CompetitorFormView(
        onSave: (body) => save(context, body),
      ),
    );
  }

  void save(BuildContext context, Map<String, dynamic> body) async {
    Response response = await _CompetitorService.store(body);
    if (response.statusCode == 200)
      _CompetitorViewContract.onCreateSuccess(response, context: context);
    else
      _CompetitorViewContract.onErrorRequest(response);
  }

  void edit(BuildContext context, int id) async {
    setProcessing(true);
    showDialog(
      context: context,
      builder: (context) => CompetitorFormView(
        onSave: (body) => update(context, body, id),
      ),
    );

    Response response = await _CompetitorService.show(id);
    if (response.statusCode == 200)
      _CompetitorFetchDataContract.onSuccessFetchData(response);
    else
      _CompetitorViewContract.onErrorRequest(response);
  }

  void update(BuildContext context, Map<String, dynamic> body, int id) async {
    setProcessing(true);
    Response response = await _CompetitorService.update(id, body);
    if (response.statusCode == 200)
      _CompetitorViewContract.onEditSuccess(response, context: context);
    else
      _CompetitorViewContract.onErrorRequest(response);
  }

  void delete(BuildContext context, int typeid, String name) {
    showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
        title: BaseText.confirmTitle,
        message: BaseText.deleteConfirmDatatable(field: name),
        onPressed: (_, value) async {
          if (value == ConfirmDialogOption.YES_OPTION) {
            Response response = await _CompetitorService.destroy(typeid);
            if (response.statusCode == 200)
              _CompetitorViewContract.onDeleteSuccess(response,
                  context: context);
            else
              _CompetitorViewContract.onErrorRequest(response);
          } else {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
