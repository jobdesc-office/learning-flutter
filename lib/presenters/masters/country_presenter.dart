import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/base_text.dart';
import '../../contracts/base/details_view_contract.dart';
import '../../contracts/base/edit_view_contract.dart';
import '../../contracts/base/index_view_contract.dart';
import '../../services/masters/country_service.dart';
import '../../utils/custom_get_controller.dart';
import '../../views/masters/countries/country_form.dart';
import '../../widgets/confirm_dialog.dart';

class CountryPresenter extends CustomGetXController {
  final _countryService = Get.find<CountryService>();

  late IndexViewContract _countryViewContract;
  set countryViewContract(IndexViewContract countryViewContract) {
    _countryViewContract = countryViewContract;
  }

  late EditViewContract _countryFetchDataContract;
  set countryFetchDataContract(EditViewContract countryFetchDataContract) {
    _countryFetchDataContract = countryFetchDataContract;
  }

  late DetailViewContract _countryDataDetailsContract;
  set countryDataDetailsContract(
      DetailViewContract countryDataDetailsContract) {
    _countryDataDetailsContract = countryDataDetailsContract;
  }

  Future datatables(BuildContext context, Map<String, String> params) async {
    Response response = await _countryService.datatables(params);
    if (response.statusCode == 200)
      _countryViewContract.onLoadDatatables(context, response);
    else
      _countryViewContract.onErrorRequest(response);
  }

  // void details(BuildContext context, int userid) async {
  //   setProcessing(true);
  //   showDialog(
  //     context: context,
  //     builder: (context) => CountryDetails(),
  //   );

  //   Response response = await _CountryService.show(userid);
  //   if (response.statusCode == 200)
  //     _CountryDataDetailsContract.onSuccessFetchData(response);
  //   else
  //     _CountryViewContract.onErrorRequest(response);
  // }

  void add(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => CountryFormView(
        onSave: (body) => save(context, body),
      ),
    );
  }

  void save(BuildContext context, Map<String, dynamic> body) async {
    Response response = await _countryService.store(body);
    if (response.statusCode == 200)
      _countryViewContract.onCreateSuccess(response, context: context);
    else
      _countryViewContract.onErrorRequest(response);
  }

  void edit(BuildContext context, int id) async {
    setProcessing(true);
    showDialog(
      context: context,
      builder: (context) => CountryFormView(
        onSave: (body) => update(context, body, id),
      ),
    );

    Response response = await _countryService.show(id);
    if (response.statusCode == 200)
      _countryFetchDataContract.onSuccessFetchData(response);
    else
      _countryViewContract.onErrorRequest(response);
  }

  void update(BuildContext context, Map<String, dynamic> body, int id) async {
    setProcessing(true);
    Response response = await _countryService.update(id, body);
    if (response.statusCode == 200)
      _countryViewContract.onEditSuccess(response, context: context);
    else
      _countryViewContract.onErrorRequest(response);
  }

  void delete(BuildContext context, int typeid, String name) {
    showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
        title: BaseText.confirmTitle,
        message: BaseText.deleteConfirmDatatable(field: name),
        onPressed: (_, value) async {
          if (value == ConfirmDialogOption.YES_OPTION) {
            Response response = await _countryService.destroy(typeid);
            if (response.statusCode == 200)
              _countryViewContract.onDeleteSuccess(response, context: context);
            else
              _countryViewContract.onErrorRequest(response);
          } else {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
