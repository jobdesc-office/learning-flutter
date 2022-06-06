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
import '../../services/ventes/bpcustomer_service.dart';
import '../../utils/custom_get_controller.dart';
import '../../views/masters/menus/_menu_type.dart';
import '../../views/ventes/bpcustomers/bpcustomer_form.dart';
import '../../widgets/confirm_dialog.dart';

class BpCustomerPresenter extends CustomGetXController {
  final _bpCustomerService = Get.find<BpCustomerService>();

  late IndexViewContract _bpCustomerViewContract;
  set BpCustomerViewContract(IndexViewContract bpCustomerViewContract) {
    _bpCustomerViewContract = bpCustomerViewContract;
  }

  late EditViewContract _bpCustomerFetchDataContract;
  set bpCustomerFetchDataContract(
      EditViewContract bpCustomerFetchDataContract) {
    _bpCustomerFetchDataContract = bpCustomerFetchDataContract;
  }

  // late DetailViewContract _BpCustomerTypeViewContract;
  // set BpCustomerDetailViewContract(DetailViewContract BpCustomerViewContract) {
  //   _BpCustomerTypeViewContract = BpCustomerViewContract;
  // }

  Future datatables(BuildContext context, Map<String, String> params) async {
    Response response = await _bpCustomerService.datatables(params);
    if (response.statusCode == 200)
      _bpCustomerViewContract.onLoadDatatables(context, response);
    else
      _bpCustomerViewContract.onErrorRequest(response);
  }

  void add(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => BpCustomerFormView(
        onSave: (body) => save(context, body),
      ),
    );
  }

  void save(BuildContext context, Map<String, dynamic> body) async {
    Response response = await _bpCustomerService.store(body);
    if (response.statusCode == 200)
      _bpCustomerViewContract.onCreateSuccess(response, context: context);
    else
      _bpCustomerViewContract.onErrorRequest(response);
  }

  // void details(BuildContext context, int userid) async {
  //   setProcessing(true);
  //   showDialog(
  //     context: context,
  //     builder: (context) => BpCustomerDetails(),
  //   );

  //   Response response = await _bpCustomerService.show(userid);
  //   if (response.statusCode == 200)
  //     _bpCustomerTypeViewContract.onSuccessFetchData(response);
  //   else
  //     _bpCustomerViewContract.onErrorRequest(response);
  // }

  // void edit(BuildContext context, int BpCustomerid) async {
  //   setProcessing(true);
  //   showDialog(
  //     context: context,
  //     builder: (context) => BpCustomerFormView(
  //       onSave: (body) => update(context, body, BpCustomerid),
  //     ),
  //   );

  //   Response response = await _BpCustomerService.show(BpCustomerid);
  //   if (response.statusCode == 200)
  //     _bpCustomerFetchDataContract.onSuccessFetchData(response);
  //   else
  //     _bpCustomerViewContract.onErrorRequest(response);
  // }

  // void update(
  //     BuildContext context, Map<String, dynamic> body, int BpCustomerid) async {
  //   setProcessing(true);
  //   Response response = await _BpCustomerService.update(BpCustomerid, body);
  //   if (response.statusCode == 200)
  //     _bpCustomerViewContract.onEditSuccess(response, context: context);
  //   else
  //     _bpCustomerViewContract.onErrorRequest(response);
  // }

  // void delete(BuildContext context, int BpCustomerid) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => ConfirmDialog(
  //       title: BaseText.confirmTitle,
  //       message: BaseText.confirmMessage,
  //       onPressed: (_, value) async {
  //         if (value == ConfirmDialogOption.YES_OPTION) {
  //           Response response = await _BpCustomerService.destroy(BpCustomerid);
  //           if (response.statusCode == 200)
  //             _bpCustomerViewContract.onDeleteSuccess(response, context: context);
  //           else
  //             _bpCustomerViewContract.onErrorRequest(response);
  //         } else {
  //           Navigator.pop(context);
  //         }
  //       },
  //     ),
  //   );
  // }
}
