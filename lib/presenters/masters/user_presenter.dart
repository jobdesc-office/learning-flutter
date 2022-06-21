import 'package:boilerplate/models/masters/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../constants/base_text.dart';
import '../../contracts/base/details_view_contract.dart';
import '../../contracts/base/edit_view_contract.dart';
import '../../contracts/base/index_view_contract.dart';
import '../../models/auth_model.dart';
import '../../services/masters/user_service.dart';
import '../../utils/custom_get_controller.dart';
import '../../views/masters/users/_form_source.dart';
import '../../views/masters/users/user_details.dart';
import '../../views/masters/users/user_form.dart';
import '../../widgets/confirm_dialog.dart';
import '../auth_presenter.dart';

class UserPresenter extends CustomGetXController {
  final UserSource c = Get.put(UserSource());
  final _userService = Get.put(UserService());
  final _auth = Get.find<AuthPresenter>();
  final box = GetStorage();

  late IndexViewContract _userViewContract;
  set userViewContract(IndexViewContract userViewContract) {
    _userViewContract = userViewContract;
  }

  late EditViewContract _userFetchDataContract;
  set userFetchDataContract(EditViewContract userFetchDataContract) {
    _userFetchDataContract = userFetchDataContract;
  }

  late DetailViewContract _userFetchDataDetailsContract;
  set userFetchDataDetailsContract(
      DetailViewContract userFetchDataDetailsContract) {
    _userFetchDataDetailsContract = userFetchDataDetailsContract;
  }

  Future checkDetail() async {
    Response response = await _userService.session(box.read('id'));
    var data = AuthModel.fromJson(response.body);
    List x = [];

    _auth.roleActive.value = data.userdetails!.first.usertype!.typename!;
    _auth.roleActiveId.value = data.userdetails!.first.usertype!.typeid!;
    _auth.bpActive.value = data.userdetails!.first.businesspartner!.bpname!;
    _auth.bpActiveId.value = data.userdetails!.first.businesspartner!.bpid!;
    for (var item in data.userdetails!) {
      x.add(item);
    }
    _auth.detail.value = x;
  }

  Future datatables(BuildContext context, Map<String, String> params) async {
    Response response = await _userService.datatables(params);
    if (response.statusCode == 200)
      _userViewContract.onLoadDatatables(context, response);
    else
      _userViewContract.onErrorRequest(response);
  }

  Future reset(BuildContext context, int id) async {
    Response response = await _userService.reset(id);
    if (response.statusCode == 200)
      _userViewContract.onEditSuccess(response, context: context);
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
      _userFetchDataDetailsContract.onSuccessFetchData(response);
    else
      _userViewContract.onErrorRequest(response);
  }

  void myProfile(int userid) async {
    setProcessing(true);
    Response response = await _userService.show(userid);
    if (response.statusCode == 200)
      _userFetchDataDetailsContract.onSuccessFetchData(response);
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
    c.isAdd = false;

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

  void delete(BuildContext context, int menuid, String name) {
    showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
        title: BaseText.confirmTitle,
        message: BaseText.deleteConfirmDatatable(field: name),
        onPressed: (_, value) async {
          if (value == ConfirmDialogOption.YES_OPTION) {
            Response response = await _userService.destroy(menuid);
            if (response.statusCode == 200)
              _userViewContract.onDeleteSuccess(response, context: context);
            else
              _userViewContract.onErrorRequest(response);
          } else {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
