import 'package:boilerplate/constants/base_text.dart';
import 'package:boilerplate/contracts/base/edit_view_contract.dart';
import 'package:boilerplate/contracts/base/index_view_contract.dart';
import 'package:boilerplate/services/masters/contact_service.dart';
import 'package:boilerplate/utils/custom_get_controller.dart';
import 'package:boilerplate/widgets/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CPContactPresenter extends CustomGetXController {
  final _contactService = Get.find<ContactService>();

  late IndexViewContract _contactContract;
  set contactContract(IndexViewContract contactContract) {
    _contactContract = contactContract;
  }

  late EditViewContract _contactEditContract;
  set contactEditContract(EditViewContract contactEditContract) {
    _contactEditContract = contactEditContract;
  }

  Future datatables(BuildContext context, Map<String, String> params) async {
    Response response = await _contactService.datatables(params);
    if (response.statusCode == 200)
      _contactContract.onLoadDatatables(context, response);
    else
      _contactContract.onErrorRequest(response);
  }

  void save(BuildContext context, Map<String, dynamic> body) async {
    Response response = await _contactService.store(body);
    if (response.statusCode == 200)
      _contactContract.onCreateSuccess(response, context: context);
    else
      _contactContract.onErrorRequest(response);
  }

  void edit(BuildContext context, int id) async {
    setProcessing(true);

    Response response = await _contactService.show(id);
    if (response.statusCode == 200)
      _contactEditContract.onSuccessFetchData(response);
    else
      _contactContract.onErrorRequest(response);
  }

  void update(BuildContext context, Map<String, dynamic> body, int id) async {
    setProcessing(true);
    Response response = await _contactService.update(id, body);
    if (response.statusCode == 200)
      _contactContract.onEditSuccess(response, context: context);
    else
      _contactContract.onErrorRequest(response);
  }

  void delete(BuildContext context, int typeid, String name) {
    showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
        title: BaseText.confirmTitle,
        message: BaseText.deleteConfirmDatatable(field: name),
        onPressed: (_, value) async {
          if (value == ConfirmDialogOption.YES_OPTION) {
            Navigator.pop(context);
            Response response = await _contactService.destroy(typeid);
            if (response.statusCode == 200)
              _contactContract.onDeleteSuccess(response, context: context);
            else
              _contactContract.onErrorRequest(response);
          } else {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
