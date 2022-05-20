import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/base_text.dart';
import '../../contracts/base/details_view_contract.dart';
import '../../contracts/base/edit_view_contract.dart';
import '../../contracts/base/index_view_contract.dart';
import '../../services/masters/subdistrict_service.dart';
import '../../utils/custom_get_controller.dart';
import '../../views/masters/subdistricts/subdistrict_form.dart';
import '../../widgets/confirm_dialog.dart';

class SubdistrictPresenter extends CustomGetXController {
  final _subdistrictService = Get.find<SubdistrictService>();

  late IndexViewContract _subdistrictViewContract;
  set subdistrictViewContract(IndexViewContract subdistrictViewContract) {
    _subdistrictViewContract = subdistrictViewContract;
  }

  late EditViewContract _subdistrictFetchDataContract;
  set subdistrictFetchDataContract(
      EditViewContract subdistrictFetchDataContract) {
    _subdistrictFetchDataContract = subdistrictFetchDataContract;
  }

  late DetailViewContract _subdistrictDataDetailsContract;
  set subdistrictDataDetailsContract(
      DetailViewContract subdistrictDataDetailsContract) {
    _subdistrictDataDetailsContract = subdistrictDataDetailsContract;
  }

  Future datatables(BuildContext context, Map<String, String> params) async {
    Response response = await _subdistrictService.datatables(params);
    if (response.statusCode == 200)
      _subdistrictViewContract.onLoadDatatables(context, response);
    else
      _subdistrictViewContract.onErrorRequest(response);
  }

  // void details(BuildContext context, int userid) async {
  //   setProcessing(true);
  //   showDialog(
  //     context: context,
  //     builder: (context) => SubdistrictDetails(),
  //   );

  //   Response response = await _SubdistrictService.show(userid);
  //   if (response.statusCode == 200)
  //     _SubdistrictDataDetailsContract.onSuccessFetchData(response);
  //   else
  //     _SubdistrictViewContract.onErrorRequest(response);
  // }

  void add(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => SubdistrictFormView(
        onSave: (body) => save(context, body),
      ),
    );
  }

  void save(BuildContext context, Map<String, dynamic> body) async {
    Response response = await _subdistrictService.store(body);
    if (response.statusCode == 200)
      _subdistrictViewContract.onCreateSuccess(response, context: context);
    else
      _subdistrictViewContract.onErrorRequest(response);
  }

  void edit(BuildContext context, int id) async {
    setProcessing(true);
    showDialog(
      context: context,
      builder: (context) => SubdistrictFormView(
        onSave: (body) => update(context, body, id),
      ),
    );

    Response response = await _subdistrictService.show(id);
    if (response.statusCode == 200)
      _subdistrictFetchDataContract.onSuccessFetchData(response);
    else
      _subdistrictViewContract.onErrorRequest(response);
  }

  void update(BuildContext context, Map<String, dynamic> body, int id) async {
    setProcessing(true);
    Response response = await _subdistrictService.update(id, body);
    if (response.statusCode == 200)
      _subdistrictViewContract.onEditSuccess(response, context: context);
    else
      _subdistrictViewContract.onErrorRequest(response);
  }

  void delete(BuildContext context, int typeid) {
    showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
        title: BaseText.confirmTitle,
        message: BaseText.confirmMessage,
        onPressed: (_, value) async {
          if (value == ConfirmDialogOption.YES_OPTION) {
            Response response = await _subdistrictService.destroy(typeid);
            if (response.statusCode == 200)
              _subdistrictViewContract.onDeleteSuccess(response,
                  context: context);
            else
              _subdistrictViewContract.onErrorRequest(response);
          } else {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
