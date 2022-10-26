import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/base_text.dart';
import '../../contracts/base/index_view_contract.dart';
import '../../services/ventes/option_service.dart';
import '../../utils/custom_get_controller.dart';
import '../../views/settings/company/company_setting/company.dart';
import '../../widgets/confirm_dialog.dart';
import '../../widgets/snackbar.dart';

final sources = Get.put(CustomizeFieldSource());

class OptionPresenter extends CustomGetXController {
  final _optionService = Get.find<OptionService>();

  late IndexViewContract _optionViewContract;
  set optionViewContract(IndexViewContract optionViewContract) {
    _optionViewContract = optionViewContract;
  }

  Future datatables(BuildContext context, Map<String, String> params) async {
    Response response = await _optionService.datatables(params);
    if (response.statusCode == 200)
      _optionViewContract.onLoadDatatables(context, response);
    else
      _optionViewContract.onErrorRequest(response);
  }

  // void details(BuildContext context, int userid) async {
  //   setProcessing(true);
  //   showDialog(
  //     context: context,
  //     builder: (context) => OptionDetails(),
  //   );

  //   Response response = await _optionService.show(userid);
  //   if (response.statusCode == 200)
  //     _OptionDataDetailsContract.onSuccessFetchData(response);
  //   else
  //     _optionViewContract.onErrorRequest(response);
  // }

  void save(BuildContext context, Map<String, dynamic> body) async {
    await _optionService.store(body);
  }

  void update(BuildContext context, Map<String, dynamic> body, int id) async {
    await _optionService.update(id, body);
  }

  void delete(BuildContext context, int typeid, String name, int index) {
    showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
        title: BaseText.confirmTitle,
        message: BaseText.deleteConfirmDatatable(field: name),
        onPressed: (_, value) async {
          if (value == ConfirmDialogOption.YES_OPTION) {
            Response response = await _optionService.destroy(typeid);
            if (response.statusCode == 200) {
              Snackbar().deleteSuccess(context);
              sources.inputOptions.removeAt(index);
              sources.optid.removeAt(index);
              sources.optname.removeAt(index);
              Navigator.pop(context);
            }
          } else {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
