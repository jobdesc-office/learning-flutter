import 'dart:convert';
import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/base_text.dart';
import '../../contracts/base/index_view_contract.dart';
import '../../services/settings/file_service.dart';
import '../../utils/custom_get_controller.dart';
import '../../views/ventes/prospect/prospectfiles/remark.dart';
import '../../widgets/confirm_dialog.dart';

class ProspectFilePresenter extends CustomGetXController {
  final _fileService = Get.find<FileService>();

  late IndexViewContract _prospectViewContract;
  set prospectViewContract(IndexViewContract prospectViewContract) {
    _prospectViewContract = prospectViewContract;
  }

  void downloadFile(String url) {
    html.AnchorElement anchorElement = new html.AnchorElement(href: url);
    anchorElement.download = url;
    anchorElement.click();
    Get.snackbar('Success', 'Download in Progress');
  }

  void viewFile(String url) {
    html.window.open(url, "_blank");
    html.Url.revokeObjectUrl(url);
  }

  void save(BuildContext context, FormData body) async {
    setProcessing(true);
    Response response = await _fileService.storeProspect(
      body,
      contentType: "multipart/form-data",
    );
    if (response.statusCode == 200)
      _prospectViewContract.onCreateSuccess(response, context: context);
    else
      _prospectViewContract.onErrorRequest(response);
  }

  void edit(
      BuildContext context, int id, String filename, String remark) async {
    showDialog(
      context: context,
      builder: (context) => Remark(
        onSave: (body) => update(context, body, id),
        filename: filename,
        remark: remark,
      ),
    );
  }

  void update(BuildContext context, Map<String, dynamic> body, int id) async {
    setProcessing(true);
    Response response = await _fileService.update(id, body);
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
            Response response = await _fileService.destroy(prospectid);
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
