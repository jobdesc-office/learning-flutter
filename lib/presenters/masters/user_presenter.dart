import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/base_text.dart';
import '../../contracts/base/details_view_contract.dart';
import '../../contracts/base/edit_view_contract.dart';
import '../../contracts/base/index_view_contract.dart';
import '../../services/masters/user_service.dart';
import '../../utils/custom_get_controller.dart';
import '../../views/masters/users/user_details.dart';
import '../../views/masters/users/user_form.dart';
import '../../widgets/confirm_dialog.dart';

class UserPresenter extends CustomGetXController {
  Rx<List<Widget>> role = Rx<List<Widget>>([]);
  final _userService = Get.find<UserService>();

  late IndexViewContract _userViewContract;
  set userViewContract(IndexViewContract userViewContract) {
    _userViewContract = userViewContract;
  }

  late EditViewContract _userFetchDataContract;
  set userFetchDataContract(EditViewContract userFetchDataContract) {
    _userFetchDataContract = userFetchDataContract;
  }

  late DetailViewContract _userFetchDataDetailsContract;
  set userFetchDataDetailsContract(DetailViewContract userFetchDataDetailsContract) {
    _userFetchDataDetailsContract = userFetchDataDetailsContract;
  }

  Future datatables(BuildContext context, Map<String, String> params) async {
    Response response = await _userService.datatables(params);
    if (response.statusCode == 200)
      _userViewContract.onLoadDatatables(context, response);
    else
      _userViewContract.onErrorRequest(response);
  }

  void add(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => UserFormView(
        onSave: (body) => save(context, body),
      ),
    );
  }

  void save(BuildContext context, Map<String, dynamic> body) async {
    Response response = await _userService.store(body);
    if (response.statusCode == 200)
      _userViewContract.onCreateSuccess(response, context: context);
    else
      _userViewContract.onErrorRequest(response);
  }

  void details(BuildContext context, int userid) async {
    setProcessing(true);
    showDialog(
      context: context,
      builder: (context) => UserDetails(),
    );

    Response response = await _userService.show(userid);
    if (response.statusCode == 200)
      _userFetchDataContract.onSuccessFetchData(response);
    else
      _userViewContract.onErrorRequest(response);
  }

  void edit(BuildContext context, int userid) async {
    setProcessing(true);
    showDialog(
      context: context,
      builder: (context) => UserFormView(
        onSave: (body) => update(context, body, userid),
      ),
    );

    Response response = await _userService.show(userid);
    if (response.statusCode == 200)
      _userFetchDataContract.onSuccessFetchData(response);
    else
      _userViewContract.onErrorRequest(response);
  }

  void update(
      BuildContext context, Map<String, dynamic> body, int menuid) async {
    setProcessing(true);
    Response response = await _userService.update(menuid, body);
    if (response.statusCode == 200)
      _userViewContract.onEditSuccess(response, context: context);
    else
      _userViewContract.onErrorRequest(response);
  }

  void delete(BuildContext context, int menuid) {
    showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
        title: BaseText.confirmTitle,
        message: BaseText.confirmMessage,
        onPressed: (_, value) async {
          if (value == ConfirmDialogOption.YES_OPTION) {
            Response response = await _userService.destroy(menuid);
            if (response.statusCode == 200)
              _userViewContract.onDeleteSuccess(response, context: context);
            else
              _userViewContract.onErrorRequest(response);
          }else{
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
