// ignore: avoid_web_libraries_in_flutter
import 'dart:convert';
import 'dart:html' as html;

import 'package:boilerplate/contracts/base/details_view_contract.dart';
import 'package:boilerplate/contracts/base/edit_view_contract.dart';
import 'package:boilerplate/contracts/base/history_view_contract.dart';
import 'package:boilerplate/services/ventes/competitor_service.dart';
import 'package:boilerplate/services/ventes/prospect_service.dart';
import 'package:boilerplate/views/masters/menus/_menu_sbttype.dart';
import 'package:boilerplate/views/ventes/competitor/_form_source.dart';
import 'package:boilerplate/views/ventes/competitor/competitor_details.dart';
import 'package:boilerplate/views/ventes/competitor/competitor_form.dart';
import 'package:boilerplate/views/ventes/prospect/prospectdetail_component/_stagePipeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/base_text.dart';
import '../../contracts/base/index_view_contract.dart';
import '../../services/settings/file_service.dart';
import '../../utils/custom_get_controller.dart';
import '../../views/ventes/prospect/prospectfiles/remark.dart';
import '../../widgets/confirm_dialog.dart';

class ProspectCompetitorPresenter extends CustomGetXController {
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

  late IndexViewContract _prospectViewContract;
  set prospectViewContract(IndexViewContract prospectViewContract) {
    _prospectViewContract = prospectViewContract;
  }

  late EditViewContract _competitorsFetchDataContract;
  set competitorsFetchDataContract(
      EditViewContract competitorsFetchDataContract) {
    _competitorsFetchDataContract = competitorsFetchDataContract;
  }

  late MenuTypeViewDetailContract _prospectTypeViewDetailContract;
  set prospectTypeViewDetailContract(
      MenuTypeViewDetailContract prospectTypeViewContract) {
    _prospectTypeViewDetailContract = prospectTypeViewContract;
  }

  late IndexViewContract _prospectdtViewContract;
  set prospectdtViewContract(IndexViewContract prospectdtViewContract) {
    _prospectdtViewContract = prospectdtViewContract;
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

  void add(BuildContext context, {int? prospectid}) async {
    showDialog(
      context: context,
      builder: (context) => CompetitorFormView(
          onSave: (body, {int? prospectid}) =>
              save(context, body, prospectid: prospectid!),
          prospectid: prospectid),
    );
  }

  void save(BuildContext context, FormData body, {int? prospectid}) async {
    // if (prospectid != null) {
    //   body['comptrefid'] = prospectid;
    // }
    // print(body);
    Response response = await _competitorService.storeCompetitor(
      body,
      contentType: "multipart/form-data",
    );
    if (response.statusCode == 200)
      _prospectViewContract.onCreateSuccess(response, context: context);
    else
      _prospectViewContract.onErrorRequest(response);
  }

  void edit(BuildContext context, int comptid) async {
    setProcessing(true);
    showDialog(
      context: context,
      builder: (context) => CompetitorFormView(
          onSave: (body, {int? prospectid}) => update(context, body, comptid)),
    );

    Response response = await _competitorService.show(comptid);
    if (response.statusCode == 200)
      _competitorFetchDataContract.onSuccessFetchData(response);
    else
      _competitorViewContract.onErrorRequest(response);
  }

  void edits(BuildContext context, int comptid) async {
    Response response = await _competitorService.show(comptid);
    if (response.statusCode == 200)
      _competitorsFetchDataContract.onSuccessFetchData(response);
    else
      _competitorViewContract.onErrorRequest(response);
  }

  void update(BuildContext context, FormData body, int id) async {
    setProcessing(true);
    Response response = await _competitorService.updateCompetitor(
      id,
      body,
      contentType: "multipart/form-data",
    );
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
