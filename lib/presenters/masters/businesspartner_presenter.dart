import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/base_text.dart';
import '../../constants/config_types.dart';
import '../../contracts/base/details_view_contract.dart';
import '../../contracts/base/edit_view_contract.dart';
import '../../contracts/base/index_view_contract.dart';
import '../../services/masters/businessPartner_service.dart';
import '../../services/masters/type_service.dart';
import '../../utils/custom_get_controller.dart';
import '../../views/masters/businesspartner/_businesspartner_type.dart';
import '../../views/masters/businesspartner/businesspartner_detail.dart';
import '../../views/masters/businesspartner/businesspartner_form.dart';
import '../../widgets/confirm_dialog.dart';

class BusinessPartnerPresenter extends CustomGetXController {
  final _businessPartnerService = Get.find<BusinessPartnerService>();
  final _typeService = Get.put(TypeService());

  late IndexViewContract _businessPartnerViewContract;
  set businessPartnerViewContract(IndexViewContract businessPartnerViewContract) {
    _businessPartnerViewContract = businessPartnerViewContract;
  }

  late EditViewContract _businessPartnerFetchDataContract;
  set businessPartnerFetchDataContract(EditViewContract businessPartnerFetchDataContract) {
    _businessPartnerFetchDataContract = businessPartnerFetchDataContract;
  }
  
  late BusinessPartnerTypeViewContract _businessPartnerTypeViewContract;
  set businessPartnerTypeViewContract(BusinessPartnerTypeViewContract businessPartnerTypeViewContract) {
    _businessPartnerTypeViewContract = businessPartnerTypeViewContract;
  }

  late DetailViewContract _businessPartnerFetchDataDetailsContract;
  set businessPartnerFetchDataDetailsContract(DetailViewContract businessPartnerFetchDataDetailsContract) {
    _businessPartnerFetchDataDetailsContract = businessPartnerFetchDataDetailsContract;
  }

  Future datatables(BuildContext context, Map<String, String> params) async {
    Response response = await _businessPartnerService.datatables(params);
    if (response.statusCode == 200)
      _businessPartnerViewContract.onLoadDatatables(context, response);
    else
      _businessPartnerViewContract.onErrorRequest(response);
  }

  Future _loadType() async {
    Response response = await _typeService.byCode(ConfigType.businessPartner);
    if (response.statusCode == 200)
      _businessPartnerTypeViewContract.onLoadSuccess(response);
    else
      _businessPartnerViewContract.onErrorRequest(response);
  }

  void details(BuildContext context, int userid) async {
    setProcessing(true);
    showDialog(
      context: context,
      builder: (context) => BusinessPartnerDetails(),
    );

    Response response = await _businessPartnerService.show(userid);
    print(response.body);
    if (response.statusCode == 200)
      _businessPartnerFetchDataDetailsContract.onSuccessFetchData(response);
    else
      _businessPartnerViewContract.onErrorRequest(response);
  }

  void add(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => BusinessPartnerFormView(
        onSave: (body) => save(context, body),
      ),
    );
    _loadType();
  }

  void save(BuildContext context, Map<String, dynamic> body) async {
    Response response = await _businessPartnerService.store(body);
    if (response.statusCode == 200)
      _businessPartnerViewContract.onCreateSuccess(response, context: context);
    else
      _businessPartnerViewContract.onErrorRequest(response);
  }

  void edit(BuildContext context, int businessPartnerid) async {
    setProcessing(true);
    showDialog(
      context: context,
      builder: (context) => BusinessPartnerFormView(
        onSave: (body) => update(context, body, businessPartnerid),
      ),
    );

    await _loadType();

    Response response = await _businessPartnerService.show(businessPartnerid);
    if (response.statusCode == 200)
      _businessPartnerFetchDataContract.onSuccessFetchData(response);
    else
      _businessPartnerViewContract.onErrorRequest(response);
  }

  void update(
    BuildContext context, Map<String, dynamic> body, int menuid) async {
    setProcessing(true);
    Response response = await _businessPartnerService.update(menuid, body);
    if (response.statusCode == 200)
      _businessPartnerViewContract.onEditSuccess(response, context: context);
    else
      _businessPartnerViewContract.onErrorRequest(response);
  }

  void delete(BuildContext context, int menuid) {
    showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
        title: BaseText.confirmTitle,
        message: BaseText.confirmMessage,
        onPressed: (_, value) async {
          if (value == ConfirmDialogOption.YES_OPTION) {
            Response response = await _businessPartnerService.destroy(menuid);
            if (response.statusCode == 200)
              _businessPartnerViewContract.onDeleteSuccess(response, context: context);
            else
              _businessPartnerViewContract.onErrorRequest(response);
          }else{
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
