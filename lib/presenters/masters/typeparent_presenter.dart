import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../contracts/base/edit_view_contract.dart';
import '../../contracts/base/index_view_contract.dart';
import '../../services/masters/type_service.dart';
import '../../utils/custom_get_controller.dart';

class TypeParentPresenter extends CustomGetXController {
  final _typeParentService = Get.find<TypeService>();

  late IndexViewContract _typeParentViewContract;
  set typeParentViewContract(IndexViewContract typeParentViewContract) {
    _typeParentViewContract = typeParentViewContract;
  }

  // late EditViewContract _typeParentFetchDataContract;
  // set typeParentFetchDataContract(EditViewContract typeParentFetchDataContract) {
  //   _typeParentFetchDataContract = typeParentFetchDataContract;
  // }

  // late typeParentTypeViewContract _typeParentTypeViewContract;
  // set typeParentTypeViewContract(typeParentTypeViewContract typeParentTypeViewContract) {
  //   _typeParentTypeViewContract = typeParentTypeViewContract;
  // }

  Future datatables(BuildContext context, Map<String, String> params) async {
    Response response = await _typeParentService.datatables(params);
    if (response.statusCode == 200)
      _typeParentViewContract.onLoadDatatables(context, response);
    else
      _typeParentViewContract.onErrorRequest(response);
  }

  // Future _loadType() async {
  //   Response response = await _typeService.byCode(ConfigType.typeParentType);
  //   if (response.statusCode == 200)
  //     _typeParentTypeViewContract.onLoadSuccess(response);
  //   else
  //     _typeParentViewContract.onErrorRequest(response);
  // }

  // void add(BuildContext context) async {
  //   showDialog(
  //     context: context,
  //     builder: (context) => typeParentFormView(
  //       onSave: (body) => save(context, body),
  //     ),
  //   );

  //   _loadType();
  // }

  // void save(BuildContext context, Map<String, dynamic> body) async {
  //   Response response = await _typeParentService.store(body);
  //   if (response.statusCode == 200)
  //     _typeParentViewContract.onCreateSuccess(response, context: context);
  //   else
  //     _typeParentViewContract.onErrorRequest(response);
  // }

  // void edit(BuildContext context, int typeParentid) async {
  //   setProcessing(true);
  //   showDialog(
  //     context: context,
  //     builder: (context) => typeParentFormView(
  //       onSave: (body) => update(context, body, typeParentid),
  //     ),
  //   );

  //   await _loadType();

  //   Response response = await _typeParentService.show(typeParentid);
  //   if (response.statusCode == 200)
  //     _typeParentFetchDataContract.onSuccessFetchData(response);
  //   else
  //     _typeParentViewContract.onErrorRequest(response);
  // }

  // void update(
  //     BuildContext context, Map<String, dynamic> body, int typeParentid) async {
  //   setProcessing(true);
  //   Response response = await _typeParentService.update(typeParentid, body);
  //   if (response.statusCode == 200)
  //     _typeParentViewContract.onEditSuccess(response, context: context);
  //   else
  //     _typeParentViewContract.onErrorRequest(response);
  // }

  // void delete(BuildContext context, int typeParentid) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => ConfirmDialog(
  //       title: BaseText.confirmTitle,
  //       message: BaseText.confirmMessage,
  //       onPressed: (_, value) async {
  //         if (value == ConfirmDialogOption.YES_OPTION) {
  //           Response response = await _typeParentService.destroy(typeParentid);
  //           if (response.statusCode == 200)
  //             _typeParentViewContract.onDeleteSuccess(response, context: context);
  //           else
  //             _typeParentViewContract.onErrorRequest(response);
  //         }
  //       },
  //     ),
  //   );
  // }
}
