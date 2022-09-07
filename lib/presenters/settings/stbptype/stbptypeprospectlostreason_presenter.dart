import 'package:boilerplate/models/masters/type_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/base_text.dart';
import '../../../constants/config_types.dart';
import '../../../contracts/base/edit_view_contract.dart';
import '../../../contracts/base/index_view_contract.dart';
import '../../../models/session_model.dart';
import '../../../services/masters/stbptype_service.dart';
import '../../../services/masters/type_service.dart';
import '../../../utils/custom_get_controller.dart';
import '../../../utils/session_manager.dart';
import '../../../views/settings/company/company_setting/_source.dart';
import '../../../widgets/confirm_dialog.dart';

class StBpTypeProspectLostReasonPresenter extends CustomGetXController {
  final _stBpTypeService = Get.find<StBpTypeService>();
  final _typeService = Get.put(TypeService());
  final _sources = Get.find<CompanySources>();

  late IndexViewContract _stBpTypeProspectLostReasonViewContract;
  set stBpTypeProspectLostReasonViewContract(
      IndexViewContract stBpTypeViewContract) {
    _stBpTypeProspectLostReasonViewContract = stBpTypeViewContract;
  }

  late EditViewContract _stBpTypeProspectLostReasonFetchDataContract;
  set stBpTypeProspectLostReasonFetchDataContract(
      EditViewContract stBpTypeFetchDataContract) {
    _stBpTypeProspectLostReasonFetchDataContract = stBpTypeFetchDataContract;
  }

  Future datatables(BuildContext context) async {
    Response type =
        await _typeService.byCodeMaster(ConfigType.prospectLostReason);
    for (var element in type.body) {
      _sources.type.value = TypeModel.fromJson(element);
    }

    int typeid = _sources.type.value.typeid!;
    _sources.prospectLostReasontypeid.value = typeid;

    Response response = await _stBpTypeService.datatable(typeid);
    if (response.statusCode == 200)
      _stBpTypeProspectLostReasonViewContract.onLoadDatatables(
          context, response);
    else
      _stBpTypeProspectLostReasonViewContract.onErrorRequest(response);
  }

  void changeStatus(BuildContext context, int id, bool status) async {
    setProcessing(true);
    Map<String, dynamic> body;

    SessionModel session = await SessionManager.current();
    body = {
      'createdby': session.userid,
      'updatedby': session.userid,
      'isactive': !status,
    };
    Response response = await _stBpTypeService.update(id, body);
    if (response.statusCode == 200)
      _stBpTypeProspectLostReasonViewContract.onEditSuccess(response,
          context: context);
    else
      _stBpTypeProspectLostReasonViewContract.onErrorRequest(response);
  }

  void save(BuildContext context, Map<String, dynamic> body) async {
    setProcessing(true);
    Response response = await _stBpTypeService.store(body);
    if (response.statusCode == 200)
      _stBpTypeProspectLostReasonViewContract.onCreateSuccess(response,
          context: context);
    else
      _stBpTypeProspectLostReasonViewContract.onErrorRequest(response);
  }

  void edit(BuildContext context, int id) async {
    Response response = await _stBpTypeService.show(id);
    if (response.statusCode == 200)
      _stBpTypeProspectLostReasonFetchDataContract.onSuccessFetchData(response);
    else
      _stBpTypeProspectLostReasonViewContract.onErrorRequest(response);
  }

  void update(BuildContext context, Map<String, dynamic> body, int id) async {
    setProcessing(true);
    Response response = await _stBpTypeService.update(id, body);
    if (response.statusCode == 200)
      _stBpTypeProspectLostReasonViewContract.onEditSuccess(response,
          context: context);
    else
      _stBpTypeProspectLostReasonViewContract.onErrorRequest(response);
  }

  void delete(BuildContext context, int typeid, String name) {
    showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
        title: BaseText.confirmTitle,
        message: BaseText.deleteConfirmDatatable(field: name),
        onPressed: (_, value) async {
          if (value == ConfirmDialogOption.YES_OPTION) {
            Response response = await _stBpTypeService.destroy(typeid);
            if (response.statusCode == 200)
              _stBpTypeProspectLostReasonViewContract.onDeleteSuccess(response,
                  context: context);
            else
              _stBpTypeProspectLostReasonViewContract.onErrorRequest(response);
          } else {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
