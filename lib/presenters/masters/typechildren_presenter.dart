import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../contracts/base/edit_view_contract.dart';
import '../../contracts/base/index_view_contract.dart';
import '../../services/masters/typechildren_service.dart';
import '../../utils/custom_get_controller.dart';
import '../../views/masters/typeschildren/_parents.dart';

class TypesChildrenPresenter extends CustomGetXController {
  final _typeChildrenService = Get.find<TypeChildrenService>();

  late IndexViewContract _typeChildrenViewContract;
  set typeChildrenViewContract(IndexViewContract typeChildrenViewContract) {
    _typeChildrenViewContract = typeChildrenViewContract;
  }

  // late EditViewContract _typeChildrenFetchDataContract;
  // set typeChildrenFetchDataContract(EditViewContract typeChildrenFetchDataContract) {
  //   _typeChildrenFetchDataContract = typeChildrenFetchDataContract;
  // }

  late ParentViewContract _typeChildrenTypeViewContract;
  set typeChildrenTypeViewContract(
      ParentViewContract typeChildrenTypeViewContract) {
    _typeChildrenTypeViewContract = typeChildrenTypeViewContract;
  }

  Future datatables(
      BuildContext context, Map<String, String> params, int id) async {
    Response response =
        await _typeChildrenService.datatablesTypesChild(params, id);
    if (response.statusCode == 200) {
      _loadType();
      _typeChildrenViewContract.onLoadDatatables(context, response);
    } else
      _typeChildrenViewContract.onErrorRequest(response);
  }

  Future _loadType() async {
    Response response = await _typeChildrenService.parent();
    if (response.statusCode == 200)
      _typeChildrenTypeViewContract.onLoadSuccess(response);
    else
      _typeChildrenViewContract.onErrorRequest(response);
  }

  // void add(BuildContext context) async {
  //   showDialog(
  //     context: context,
  //     builder: (context) => typeChildrenFormView(
  //       onSave: (body) => save(context, body),
  //     ),
  //   );

  //   _loadType();
  // }

  // void save(BuildContext context, Map<String, dynamic> body) async {
  //   Response response = await _typeChildrenService.store(body);
  //   if (response.statusCode == 200)
  //     _typeChildrenViewContract.onCreateSuccess(response, context: context);
  //   else
  //     _typeChildrenViewContract.onErrorRequest(response);
  // }

  // void edit(BuildContext context, int typeChildrenid) async {
  //   setProcessing(true);
  //   showDialog(
  //     context: context,
  //     builder: (context) => typeChildrenFormView(
  //       onSave: (body) => update(context, body, typeChildrenid),
  //     ),
  //   );

  //   await _loadType();

  //   Response response = await _typeChildrenService.show(typeChildrenid);
  //   if (response.statusCode == 200)
  //     _typeChildrenFetchDataContract.onSuccessFetchData(response);
  //   else
  //     _typeChildrenViewContract.onErrorRequest(response);
  // }

  // void update(
  //     BuildContext context, Map<String, dynamic> body, int typeChildrenid) async {
  //   setProcessing(true);
  //   Response response = await _typeChildrenService.update(typeChildrenid, body);
  //   if (response.statusCode == 200)
  //     _typeChildrenViewContract.onEditSuccess(response, context: context);
  //   else
  //     _typeChildrenViewContract.onErrorRequest(response);
  // }

  // void delete(BuildContext context, int typeChildrenid) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => ConfirmDialog(
  //       title: BaseText.confirmTitle,
  //       message: BaseText.confirmMessage,
  //       onPressed: (_, value) async {
  //         if (value == ConfirmDialogOption.YES_OPTION) {
  //           Response response = await _typeChildrenService.destroy(typeChildrenid);
  //           if (response.statusCode == 200)
  //             _typeChildrenViewContract.onDeleteSuccess(response, context: context);
  //           else
  //             _typeChildrenViewContract.onErrorRequest(response);
  //         }
  //       },
  //     ),
  //   );
  // }
}
