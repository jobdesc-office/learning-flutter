import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/base_text.dart';
import '../../constants/config_types.dart';
import '../../contracts/base/details_view_contract.dart';
import '../../contracts/base/edit_view_contract.dart';
import '../../contracts/base/index_view_contract.dart';
import '../../helpers/function.dart';
import '../../services/masters/type_service.dart';
import '../../services/masters/user_service.dart';
import '../../services/ventes/prospect_service.dart';
import '../../utils/custom_get_controller.dart';
import '../../views/masters/menus/_menu_type.dart';
import '../../views/ventes/prospect/prospect_detail.dart';
import '../../views/ventes/prospect/prospect_form.dart';
import '../../widgets/confirm_dialog.dart';

class ProspectPresenter extends CustomGetXController {
  final _prospectService = Get.find<ProspectService>();
  final _userService = Get.find<UserService>();
  final _typeService = Get.put(TypeService());

  late IndexViewContract _ProspectViewContract;
  set ProspectViewContract(IndexViewContract ProspectViewContract) {
    _ProspectViewContract = ProspectViewContract;
  }

  late EditViewContract _ProspectFetchDataContract;
  set ProspectFetchDataContract(EditViewContract ProspectFetchDataContract) {
    _ProspectFetchDataContract = ProspectFetchDataContract;
  }

  late DetailViewContract _ProspectTypeViewContract;
  set prospectViewContract(DetailViewContract ProspectViewContract) {
    _ProspectTypeViewContract = ProspectViewContract;
  }

  late MenuTypeViewContract _prospectTypeViewContract;
  set prospectTypeViewContract(MenuTypeViewContract prospectTypeViewContract) {
    _prospectTypeViewContract = prospectTypeViewContract;
  }

  Future getBpId(String id) async {
    Response response = await _userService.show(parseInt(id));
    print(response.body);
    if (response.statusCode == 200) {
      return response.body['businesspartner']['bpid'];
    }
    return null;
  }

  Future datatables(BuildContext context, Map<String, String> params) async {
    Response response = await _prospectService.datatables(params);
    if (response.statusCode == 200)
      _ProspectViewContract.onLoadDatatables(context, response);
    else
      _ProspectViewContract.onErrorRequest(response);
  }

  Future _loadType() async {
    Response response = await _typeService.byCode(ConfigType.prospectStage);
    if (response.statusCode == 200)
      _prospectTypeViewContract.onLoadSuccess(response);
    else
      _ProspectViewContract.onErrorRequest(response);
  }

  void add(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => ProspectFormView(
        onSave: (body) => save(context, body),
      ),
    );
    _loadType();
  }

  void save(BuildContext context, Map<String, dynamic> body) async {
    Response response = await _prospectService.store(body);
    if (response.statusCode == 200)
      _ProspectViewContract.onCreateSuccess(response, context: context);
    else
      _ProspectViewContract.onErrorRequest(response);
  }

  void details(BuildContext context, int userid) async {
    setProcessing(true);
    showDialog(
      context: context,
      builder: (context) => ProspectDetails(),
    );

    // Response response = await _typeParentService.show(userid);
    // if (response.statusCode == 200)
    //   _typeParentDataDetailsContract.onSuccessFetchData(response);
    // else
    //   _typeParentViewContract.onErrorRequest(response);
  }

  void edit(BuildContext context, int Prospectid) async {
    setProcessing(true);
    showDialog(
      context: context,
      builder: (context) => ProspectFormView(
        onSave: (body) => update(context, body, Prospectid),
      ),
    );
    _loadType();

    Response response = await _prospectService.show(Prospectid);
    if (response.statusCode == 200)
      _ProspectFetchDataContract.onSuccessFetchData(response);
    else
      _ProspectViewContract.onErrorRequest(response);
  }

  void update(
      BuildContext context, Map<String, dynamic> body, int Prospectid) async {
    setProcessing(true);
    Response response = await _prospectService.update(Prospectid, body);
    if (response.statusCode == 200)
      _ProspectViewContract.onEditSuccess(response, context: context);
    else
      _ProspectViewContract.onErrorRequest(response);
  }

  void delete(BuildContext context, int Prospectid) {
    showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
        title: BaseText.confirmTitle,
        message: BaseText.confirmMessage,
        onPressed: (_, value) async {
          if (value == ConfirmDialogOption.YES_OPTION) {
            Response response = await _prospectService.destroy(Prospectid);
            if (response.statusCode == 200)
              _ProspectViewContract.onDeleteSuccess(response, context: context);
            else
              _ProspectViewContract.onErrorRequest(response);
          } else {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
