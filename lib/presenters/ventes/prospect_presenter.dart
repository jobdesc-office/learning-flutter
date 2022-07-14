import 'package:boilerplate/models/ventes/prospect_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/base_text.dart';
import '../../constants/config_types.dart';
import '../../contracts/base/details_view_contract.dart';
import '../../contracts/base/edit_view_contract.dart';
import '../../contracts/base/index_view_contract.dart';
import '../../models/masters/type_model.dart';
import '../../services/masters/type_service.dart';
import '../../services/ventes/prospect_service.dart';
import '../../utils/custom_get_controller.dart';
import '../../views/masters/menus/_menu_type.dart';
import '../../views/ventes/prospect/prospectdetail_component/_stagePipeline.dart';
import '../../views/ventes/prospect/prospect_detail.dart';
import '../../views/ventes/prospect/prospect_form.dart';
import '../../views/ventes/prospect/prospectlost/lost_popup.dart';
import '../../views/ventes/prospect/prospectlost/prospect_lost.dart';
import '../../widgets/confirm_dialog.dart';

class ProspectPresenter extends CustomGetXController {
  final _prospectService = Get.find<ProspectService>();
  final _typeService = Get.put(TypeService());

  late IndexViewContract _prospectViewContract;
  set prospectViewContract(IndexViewContract prospectViewContract) {
    _prospectViewContract = prospectViewContract;
  }

  late EditViewContract _prospectFetchDataContract;
  set prospectFetchDataContract(EditViewContract prospectFetchDataContract) {
    _prospectFetchDataContract = prospectFetchDataContract;
  }

  late DetailViewContract _prospectDetailsViewContract;
  set prospectDetailsViewContract(DetailViewContract prospectViewContract) {
    _prospectDetailsViewContract = prospectViewContract;
  }

  late MenuTypeViewContract _prospectTypeViewContract;
  set prospectTypeViewContract(MenuTypeViewContract prospectTypeViewContract) {
    _prospectTypeViewContract = prospectTypeViewContract;
  }

  late MenuTypeViewDetailContract _prospectTypeViewDetailContract;
  set prospectTypeViewDetailContract(
      MenuTypeViewDetailContract prospectTypeViewContract) {
    _prospectTypeViewDetailContract = prospectTypeViewContract;
  }

  late IndexViewContract _addCustomerViewContract;
  set addCustomerViewContract(IndexViewContract addCustomerViewContract) {
    _addCustomerViewContract = addCustomerViewContract;
  }

  Future datatables(BuildContext context, Map<String, String> params) async {
    Response response = await _prospectService.datatables(params);
    if (response.statusCode == 200)
      _prospectViewContract.onLoadDatatables(context, response);
    else
      _prospectViewContract.onErrorRequest(response);
  }

  Future lastid() async {
    Response response = await _prospectService.lastid();
    if (response.statusCode == 200) {
      return ProspectModel.fromJson(response.body).prospectid;
    } else
      return null;
  }

  Future _loadType() async {
    Response response = await _typeService.byCode(ConfigType.prospectStage);
    if (response.statusCode == 200)
      _prospectTypeViewContract.onLoadSuccess(response);
    else
      _prospectViewContract.onErrorRequest(response);
  }

  Future lostStatus() async {
    Response response = await _typeService.byCode(ConfigType.prospectStatus);
    if (response.statusCode == 200) {
      List<TypeModel> data = [];
      for (var item in response.body) {
        data.add(TypeModel.fromJson(item));
      }
      data.removeWhere((element) => element.typename != 'Closed Lost');
      return data.first.typeid;
    }
    return null;
  }

  Future completePipeline() async {
    Response response = await _typeService.byCode(ConfigType.prospectStage);
    if (response.statusCode == 200) {
      List<TypeModel> data = [];
      for (var item in response.body) {
        data.add(TypeModel.fromJson(item));
      }
      data.removeWhere((element) => element.typename != 'Complete');
      return data.first;
    }
    return null;
  }

  Future wonStatus() async {
    Response response = await _typeService.byCode(ConfigType.prospectStatus);
    if (response.statusCode == 200) {
      List<TypeModel> data = [];
      for (var item in response.body) {
        data.add(TypeModel.fromJson(item));
      }
      data.removeWhere((element) => element.typename != 'Closed Won');
      return data.first.typeid;
    }
    return null;
  }

  Future _loadStage() async {
    Response response = await _typeService.byCode(ConfigType.prospectStage);
    if (response.statusCode == 200)
      _prospectTypeViewDetailContract.onLoadSuccess(response);
    else
      _prospectViewContract.onErrorRequest(response);
  }

  void losePopup(BuildContext context) async {
    setProcessing(true);
    showDialog(
      context: context,
      builder: (context) => LostPopup(),
    );
  }

  void saveCustomer(BuildContext context, Map<String, dynamic> body) async {
    Response response = await _prospectService.storeCustomer(body);
    if (response.statusCode == 200)
      _addCustomerViewContract.onCreateSuccess(response, context: context);
    else
      _addCustomerViewContract.onErrorRequest(response);
  }

  void saveProduct(BuildContext context, Map<String, dynamic> body) async {
    Response response = await _prospectService.storeProduct(body);
    if (response.statusCode == 200)
      _addCustomerViewContract.onCreateSuccess(response, context: context);
    else
      _addCustomerViewContract.onErrorRequest(response);
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
      _prospectViewContract.onCreateSuccess(response, context: context);
    else
      _prospectViewContract.onErrorRequest(response);
  }

  void details(BuildContext context, int userid) async {
    setProcessing(true);
    showDialog(
      context: context,
      builder: (context) => ProspectDetails(),
    );
    _loadStage();
    Response response = await _prospectService.show(userid);
    if (response.statusCode == 200)
      _prospectDetailsViewContract.onSuccessFetchData(response);
    else
      _prospectViewContract.onErrorRequest(response);
  }

  void lose(BuildContext context, int prospectid) async {
    setProcessing(true);
    showDialog(
      context: context,
      builder: (context) => ProspectLose(
        onSave: (body) => update(context, body, prospectid),
      ),
    );
  }

  void edit(BuildContext context, int prospectid) async {
    setProcessing(true);
    showDialog(
      context: context,
      builder: (context) => ProspectFormView(
        onSave: (body) => update(context, body, prospectid),
      ),
    );
    _loadType();

    Response response = await _prospectService.show(prospectid);
    if (response.statusCode == 200)
      _prospectFetchDataContract.onSuccessFetchData(response);
    else
      _prospectViewContract.onErrorRequest(response);
  }

  void update(
      BuildContext context, Map<String, dynamic> body, int prospectid) async {
    setProcessing(true);
    Response response = await _prospectService.update(prospectid, body);
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
            Response response = await _prospectService.destroy(prospectid);
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
