import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/base_text.dart';
import '../../contracts/base/details_view_contract.dart';
import '../../contracts/base/edit_view_contract.dart';
import '../../contracts/base/index_view_contract.dart';
import '../../services/ventes/competitor_service.dart';
import '../../utils/custom_get_controller.dart';
import '../../views/ventes/competitor/competitor_details.dart';
import '../../views/ventes/competitor/competitor_form.dart';
import '../../widgets/confirm_dialog.dart';

class CompetitorPresenter extends CustomGetXController {
  final _competitorService = Get.find<CompetitorService>();

  late IndexViewContract _competitorViewContract;
  set competitorViewContract(IndexViewContract competitorViewContract) {
    _competitorViewContract = competitorViewContract;
  }

  late EditViewContract _competitorFetchDataContract;
  set competitorFetchDataContract(
      EditViewContract competitorFetchDataContract) {
    _competitorFetchDataContract = competitorFetchDataContract;
  }

  late DetailViewContract _competitorDataDetailsContract;
  set competitorDataDetailsContract(
      DetailViewContract competitorDataDetailsContract) {
    _competitorDataDetailsContract = competitorDataDetailsContract;
  }

  late EditViewContract _competitorsFetchDataContract;
  set competitorsFetchDataContract(
      EditViewContract competitorsFetchDataContract) {
    _competitorsFetchDataContract = competitorsFetchDataContract;
  }

  Future datatables(BuildContext context, Map<String, String> params) async {
    Response response = await _competitorService.datatables(params);
    if (response.statusCode == 200)
      _competitorViewContract.onLoadDatatables(context, response);
    else
      _competitorViewContract.onErrorRequest(response);
  }

  Future datatablesbp(BuildContext context, Map<String, String> params) async {
    Response response = await _competitorService.datatablesbp(params);
    if (response.statusCode == 200)
      _competitorViewContract.onLoadDatatables(context, response);
    else
      _competitorViewContract.onErrorRequest(response);
  }

  Future cstm(int id) async {
    Response response = await _competitorService.show(id);
    return response.body['cstmname'];
  }

  void deleteImages(BuildContext context, Map<String, dynamic> body) async {
    await _competitorService.deleteImages(
      query: body,
    );
  }

  void details(BuildContext context, int userid) async {
    setProcessing(true);
    showDialog(
      context: context,
      builder: (context) => CompetitorDetails(),
    );

    Response response = await _competitorService.show(userid);
    if (response.statusCode == 200)
      _competitorDataDetailsContract.onSuccessFetchData(response);
    else
      _competitorViewContract.onErrorRequest(response);
  }

  void add(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => CompetitorFormView(
        onSave: (body) => save(context, body),
      ),
    );
  }

  void save(BuildContext context, FormData body) async {
    Response response = await _competitorService.storeCompetitor(
      body,
      contentType: "multipart/form-data",
    );
    if (response.statusCode == 200)
      _competitorViewContract.onCreateSuccess(response, context: context);
    else
      _competitorViewContract.onErrorRequest(response);
  }

  void edit(BuildContext context, int id) async {
    setProcessing(true);
    showDialog(
      context: context,
      builder: (context) => CompetitorFormView(
        onSave: (body) => update(context, body, id),
      ),
    );

    Response response = await _competitorService.show(id);
    if (response.statusCode == 200)
      _competitorFetchDataContract.onSuccessFetchData(response);
    else
      _competitorViewContract.onErrorRequest(response);
  }

  void edits(BuildContext context, int id) async {
    Response response = await _competitorService.show(id);
    if (response.statusCode == 200)
      _competitorsFetchDataContract.onSuccessFetchData(response);
    else
      _competitorViewContract.onErrorRequest(response);
  }

  void update(BuildContext context, FormData body, int id) async {
    setProcessing(true);
    Response response = await _competitorService.updateCompetitor(id, body);
    if (response.statusCode == 200)
      _competitorViewContract.onEditSuccess(response, context: context);
    else
      _competitorViewContract.onErrorRequest(response);
  }

  void delete(BuildContext context, int typeid, String name) {
    showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
        title: BaseText.confirmTitle,
        message: BaseText.deleteConfirmDatatable(field: name),
        onPressed: (_, value) async {
          if (value == ConfirmDialogOption.YES_OPTION) {
            Response response = await _competitorService.destroy(typeid);
            if (response.statusCode == 200)
              _competitorViewContract.onDeleteSuccess(response,
                  context: context);
            else
              _competitorViewContract.onErrorRequest(response);
          } else {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
