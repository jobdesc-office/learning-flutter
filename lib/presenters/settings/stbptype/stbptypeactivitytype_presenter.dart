import 'package:boilerplate/models/masters/type_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/base_text.dart';
import '../../../constants/config_types.dart';
import '../../../contracts/base/details_view_contract.dart';
import '../../../contracts/base/edit_view_contract.dart';
import '../../../contracts/base/index_view_contract.dart';
import '../../../services/masters/stbptype_service.dart';
import '../../../services/masters/type_service.dart';
import '../../../utils/custom_get_controller.dart';
import '../../../views/settings/company/company_setting/_source.dart';
import '../../../widgets/confirm_dialog.dart';

class StBpTypeActivityTypePresenter extends CustomGetXController {
  final _StBpTypeService = Get.find<StBpTypeService>();
  final _TypeService = Get.put(TypeService());
  final _sources = Get.find<CompanySources>();

  late IndexViewContract _StBpTypeActivityTypeViewContract;
  set StBpTypeActivityTypeViewContract(IndexViewContract StBpTypeViewContract) {
    _StBpTypeActivityTypeViewContract = StBpTypeViewContract;
  }

  late EditViewContract _StBpTypeActivityTypeFetchDataContract;
  set StBpTypeActivityTypeFetchDataContract(
      EditViewContract StBpTypeFetchDataContract) {
    _StBpTypeActivityTypeFetchDataContract = StBpTypeFetchDataContract;
  }

  late DetailViewContract _StBpTypeActivityTypeDataDetailsContract;
  set StBpTypeActivityTypeDataDetailsContract(
      DetailViewContract StBpTypeDataDetailsContract) {
    _StBpTypeActivityTypeDataDetailsContract = StBpTypeDataDetailsContract;
  }

  Future datatables(BuildContext context, Map<String, String> params) async {
    late TypeModel types;
    Response type = await _TypeService.byCode(ConfigType.activitytype);
    for (var element in type.body) {
      types = TypeModel.fromJson(element);
    }

    int typeid = types.typemasterid!;
    _sources.typeid.value = typeid;

    Response response = await _StBpTypeService.datatable(params, typeid);
    if (response.statusCode == 200)
      _StBpTypeActivityTypeViewContract.onLoadDatatables(context, response);
    else
      _StBpTypeActivityTypeViewContract.onErrorRequest(response);
  }

  // void details(BuildContext context, int userid) async {
  //   setProcessing(true);
  //   showDialog(
  //     context: context,
  //     builder: (context) => StBpTypeDetails(),
  //   );

  //   Response response = await _StBpTypeService.show(userid);
  //   if (response.statusCode == 200)
  //     _StBpTypeDataDetailsContract.onSuccessFetchData(response);
  //   else
  //     _StBpTypeViewContract.onErrorRequest(response);
  // }

  // void add(BuildContext context) async {
  //   showDialog(
  //     context: context,
  //     builder: (context) => StBpTypeFormView(
  //       onSave: (body) => save(context, body),
  //     ),
  //   );
  // }

  void save(BuildContext context, Map<String, dynamic> body) async {
    setProcessing(true);
    Response response = await _StBpTypeService.store(body);
    if (response.statusCode == 200)
      _StBpTypeActivityTypeViewContract.onCreateSuccess(response,
          context: context);
    else
      _StBpTypeActivityTypeViewContract.onErrorRequest(response);
  }

  void edit(BuildContext context, int id) async {
    Response response = await _StBpTypeService.show(id);
    if (response.statusCode == 200)
      _StBpTypeActivityTypeFetchDataContract.onSuccessFetchData(response);
    else
      _StBpTypeActivityTypeViewContract.onErrorRequest(response);
  }

  void update(BuildContext context, Map<String, dynamic> body, int id) async {
    setProcessing(true);
    Response response = await _StBpTypeService.update(id, body);
    if (response.statusCode == 200)
      _StBpTypeActivityTypeViewContract.onEditSuccess(response,
          context: context);
    else
      _StBpTypeActivityTypeViewContract.onErrorRequest(response);
  }

  void delete(BuildContext context, int typeid, String name) {
    showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
        title: BaseText.confirmTitle,
        message: BaseText.deleteConfirmDatatable(field: name),
        onPressed: (_, value) async {
          if (value == ConfirmDialogOption.YES_OPTION) {
            Response response = await _StBpTypeService.destroy(typeid);
            if (response.statusCode == 200)
              _StBpTypeActivityTypeViewContract.onDeleteSuccess(response,
                  context: context);
            else
              _StBpTypeActivityTypeViewContract.onErrorRequest(response);
          } else {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
