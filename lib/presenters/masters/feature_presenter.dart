import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/base_text.dart';
import '../../contracts/base/edit_view_contract.dart';
import '../../contracts/base/index_view_contract.dart';
import '../../services/security/feature_service.dart';
import '../../styles/color_palattes.dart';
import '../../utils/custom_get_controller.dart';
import '../../views/masters/menus/_details_source.dart';
import '../../views/masters/menus/feature/feature_form.dart';
import '../../widgets/confirm_dialog.dart';

class FeaturePresenter extends CustomGetXController {
  final _featureService = Get.find<FeatureService>();

  late IndexViewContract _featureViewContract;
  set featureViewContract(IndexViewContract featureViewContract) {
    _featureViewContract = featureViewContract;
  }

  late EditViewContract _featureFetchDataContract;
  set featureFetchDataContract(EditViewContract featureFetchDataContract) {
    _featureFetchDataContract = featureFetchDataContract;
  }

  Future datatables(
      BuildContext context, Map<String, String> params, int id) async {
    Response response = await _featureService.datatablesMenu(id, params);
    if (response.statusCode == 200)
      _featureViewContract.onLoadDatatables(context, response);
    else
      _featureViewContract.onErrorRequest(response);
  }

  void add(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => FeatureFormView(
        onSave: (body) => save(context, body),
      ),
    );
  }

  void save(BuildContext context, Map<String, dynamic> body) async {
    Response response = await _featureService.store(body);
    if (response.statusCode == 200)
      _featureViewContract.onCreateSuccess(response, context: context);
    else
      _featureViewContract.onErrorRequest(response);
  }

  void edit(BuildContext context, int featureid) async {
    setProcessing(true);
    showDialog(
      context: context,
      builder: (context) => FeatureFormView(
        onSave: (body) => update(context, body, featureid),
      ),
    );

    Response response = await _featureService.show(featureid);
    if (response.statusCode == 200)
      _featureFetchDataContract.onSuccessFetchData(response);
    else
      _featureViewContract.onErrorRequest(response);
  }

  void update(
      BuildContext context, Map<String, dynamic> body, int featureid) async {
    setProcessing(true);
    Response response = await _featureService.update(featureid, body);
    if (response.statusCode == 200)
      _featureViewContract.onEditSuccess(response, context: context);
    else
      _featureViewContract.onErrorRequest(response);
  }

  void delete(BuildContext context, int featureid, String name) {
    showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
        title: BaseText.confirmTitle,
        message: BaseText.deleteConfirmDatatable(field: name),
        onPressed: (_, value) async {
          if (value == ConfirmDialogOption.YES_OPTION) {
            Response response = await _featureService.destroy(featureid);
            if (response.statusCode == 200)
              _featureViewContract.onDeleteSuccess(response, context: context);
            else
              _featureViewContract.onErrorRequest(response);
          } else {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
