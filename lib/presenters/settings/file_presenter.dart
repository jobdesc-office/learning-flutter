import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/base_text.dart';
import '../../contracts/base/details_view_contract.dart';
import '../../contracts/base/index_view_contract.dart';
import '../../services/settings/file_service.dart';
import '../../utils/custom_get_controller.dart';
import '../../views/settings/files/file_detail.dart';
import '../../widgets/confirm_dialog.dart';

class FilePresenter extends CustomGetXController {
  final _fileService = Get.find<FileService>();

  late IndexViewContract _fileViewContract;
  set fileViewContract(IndexViewContract fileViewContract) {
    _fileViewContract = fileViewContract;
  }

  late DetailViewContract _fileDataDetailsContract;
  set fileDataDetailsContract(DetailViewContract fileDataDetailsContract) {
    _fileDataDetailsContract = fileDataDetailsContract;
  }

  Future datatables(BuildContext context, Map<String, String> params) async {
    Response response = await _fileService.datatables(params);
    if (response.statusCode == 200)
      _fileViewContract.onLoadDatatables(context, response);
    else
      _fileViewContract.onErrorRequest(response);
  }

  void details(BuildContext context, int userid) async {
    setProcessing(true);
    showDialog(
      context: context,
      builder: (context) => FileDetails(),
    );

    Response response = await _fileService.show(userid);
    if (response.statusCode == 200)
      _fileDataDetailsContract.onSuccessFetchData(response);
    else
      _fileViewContract.onErrorRequest(response);
  }

  void delete(BuildContext context, int typeid, String name) {
    showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
        title: BaseText.confirmTitle,
        message: BaseText.deleteConfirmDatatable(field: name),
        onPressed: (_, value) async {
          if (value == ConfirmDialogOption.YES_OPTION) {
            Response response = await _fileService.destroy(typeid);
            if (response.statusCode == 200)
              _fileViewContract.onDeleteSuccess(response, context: context);
            else
              _fileViewContract.onErrorRequest(response);
          } else {
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  void deleteCompetitor(int typeid) async {
    await _fileService.destroy(typeid);
  }
}
