import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/base_text.dart';
import '../../contracts/base/details_view_contract.dart';
import '../../contracts/base/edit_view_contract.dart';
import '../../contracts/base/index_view_contract.dart';
import '../../services/masters/contact_service.dart';
import '../../utils/custom_get_controller.dart';
import '../../views/masters/contact/contact_form.dart';
import '../../widgets/confirm_dialog.dart';

class ContactPresenter extends CustomGetXController {
  final _contactService = Get.find<ContactService>();

  late IndexViewContract _contactViewContract;
  set contactViewContract(IndexViewContract contactViewContract) {
    _contactViewContract = contactViewContract;
  }

  late EditViewContract _contactFetchDataContract;
  set contactFetchDataContract(EditViewContract contactFetchDataContract) {
    _contactFetchDataContract = contactFetchDataContract;
  }

  late DetailViewContract _contactDataDetailsContract;
  set contactDataDetailsContract(
      DetailViewContract contactDataDetailsContract) {
    _contactDataDetailsContract = contactDataDetailsContract;
  }

  Future datatables(BuildContext context, Map<String, String> params) async {
    Response response = await _contactService.datatables(params);
    if (response.statusCode == 200)
      _contactViewContract.onLoadDatatables(context, response);
    else
      _contactViewContract.onErrorRequest(response);
  }

  // void details(BuildContext context, int userid) async {
  //   setProcessing(true);
  //   showDialog(
  //     context: context,
  //     builder: (context) => ContactDetails(),
  //   );

  //   Response response = await _ContactService.show(userid);
  //   if (response.statusCode == 200)
  //     _ContactDataDetailsContract.onSuccessFetchData(response);
  //   else
  //     _ContactViewContract.onErrorRequest(response);
  // }

  void add(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => ContactFormView(
        onSave: (body) => save(context, body),
      ),
    );
  }

  void save(BuildContext context, Map<String, dynamic> body) async {
    Response response = await _contactService.store(body);
    if (response.statusCode == 200)
      _contactViewContract.onCreateSuccess(response, context: context);
    else
      _contactViewContract.onErrorRequest(response);
  }

  void edit(BuildContext context, int id) async {
    setProcessing(true);
    showDialog(
      context: context,
      builder: (context) => ContactFormView(
        onSave: (body) => update(context, body, id),
      ),
    );

    Response response = await _contactService.show(id);
    if (response.statusCode == 200)
      _contactFetchDataContract.onSuccessFetchData(response);
    else
      _contactViewContract.onErrorRequest(response);
  }

  void update(BuildContext context, Map<String, dynamic> body, int id) async {
    setProcessing(true);
    Response response = await _contactService.update(id, body);
    if (response.statusCode == 200)
      _contactViewContract.onEditSuccess(response, context: context);
    else
      _contactViewContract.onErrorRequest(response);
  }

  void delete(BuildContext context, int typeid, String name) {
    showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
        title: BaseText.confirmTitle,
        message: BaseText.deleteConfirmDatatable(field: name),
        onPressed: (_, value) async {
          if (value == ConfirmDialogOption.YES_OPTION) {
            Response response = await _contactService.destroy(typeid);
            if (response.statusCode == 200)
              _contactViewContract.onDeleteSuccess(response, context: context);
            else
              _contactViewContract.onErrorRequest(response);
          } else {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
