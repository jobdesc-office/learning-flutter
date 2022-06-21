import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/base_text.dart';
import '../../contracts/base/details_view_contract.dart';
import '../../contracts/base/edit_view_contract.dart';
import '../../contracts/base/index_view_contract.dart';
import '../../contracts/master/customerAddress_contract.dart';
import '../../services/masters/city_service.dart';
import '../../services/masters/customer_service.dart';
import '../../services/masters/province_service.dart';
import '../../services/masters/subdistrict_service.dart';
import '../../utils/connect_internet_api.dart';
import '../../utils/custom_get_controller.dart';
import '../../views/masters/customers/customer_details.dart';
import '../../views/masters/customers/customer_form.dart';
import '../../widgets/confirm_dialog.dart';

class CustomerPresenter extends CustomGetXController {
  final _customerService = Get.find<CustomerService>();
  final _provinceService = Get.find<ProvinceService>();
  final _cityService = Get.find<CityService>();
  final _subdistrictService = Get.find<SubdistrictService>();

  late IndexViewContract _customerViewContract;
  set customerViewContract(IndexViewContract customerViewContract) {
    _customerViewContract = customerViewContract;
  }

  late EditViewContract _customerFetchDataContract;
  set customerFetchDataContract(EditViewContract customerFetchDataContract) {
    _customerFetchDataContract = customerFetchDataContract;
  }

  late DetailViewContract _customerDataDetailsContract;
  set customerDataDetailsContract(
      DetailViewContract customerDataDetailsContract) {
    _customerDataDetailsContract = customerDataDetailsContract;
  }

  late CustomerAddressContract _loadAddressContract;
  set customerAddresContract(CustomerAddressContract loadAddressContract) {
    _loadAddressContract = loadAddressContract;
  }

  void address(String latitudelongitude) async {
    Response response = await ConnectInternetAPI().address(latitudelongitude);
    if (response.statusCode == 200)
      _loadAddressContract.onLoadAddressSuccess(response);
    else
      _customerViewContract.onErrorRequest(response);
  }

  Future datatables(BuildContext context, Map<String, String> params) async {
    Response response = await _customerService.datatables(params);
    if (response.statusCode == 200)
      _customerViewContract.onLoadDatatables(context, response);
    else
      _customerViewContract.onErrorRequest(response);
  }

  Future cstm(int id) async {
    Response response = await _customerService.show(id);
    return response.body['cstmname'];
  }

  void details(BuildContext context, int userid) async {
    setProcessing(true);
    showDialog(
      context: context,
      builder: (context) => CustomerDetails(),
    );

    Response response = await _customerService.show(userid);
    if (response.statusCode == 200)
      _customerDataDetailsContract.onSuccessFetchData(response);
    else
      _customerViewContract.onErrorRequest(response);
  }

  Future getProvinceId(Map<String, dynamic> params) async {
    Response response = await _provinceService.byName(params);
    if (response.statusCode == 200) {
      return response.body['provid'];
    }
    return null;
  }

  Future getCityId(Map<String, dynamic> params) async {
    Response response = await _cityService.byName(params);
    if (response.statusCode == 200) {
      return response.body['cityid'];
    }
    return null;
  }

  Future getSubdistrictId(Map<String, dynamic> params) async {
    Response response = await _subdistrictService.byName(params);
    if (response.statusCode == 200) {
      return response.body['subdistrictid'];
    }
    return null;
  }

  void add(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => CustomerFormView(
        onSave: (body) => save(context, body),
      ),
    );
  }

  void save(BuildContext context, Map<String, dynamic> body) async {
    Response response = await _customerService.store(body);
    if (response.statusCode == 200)
      _customerViewContract.onCreateSuccess(response, context: context);
    else
      _customerViewContract.onErrorRequest(response);
  }

  void edit(BuildContext context, int id) async {
    setProcessing(true);
    showDialog(
      context: context,
      builder: (context) => CustomerFormView(
        onSave: (body) => update(context, body, id),
      ),
    );

    Response response = await _customerService.show(id);
    if (response.statusCode == 200)
      _customerFetchDataContract.onSuccessFetchData(response);
    else
      _customerViewContract.onErrorRequest(response);
  }

  void update(BuildContext context, Map<String, dynamic> body, int id) async {
    setProcessing(true);
    Response response = await _customerService.update(id, body);
    if (response.statusCode == 200)
      _customerViewContract.onEditSuccess(response, context: context);
    else
      _customerViewContract.onErrorRequest(response);
  }

  void delete(BuildContext context, int typeid, String name) {
    showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
        title: BaseText.confirmTitle,
        message: BaseText.deleteConfirmDatatable(field: name),
        onPressed: (_, value) async {
          if (value == ConfirmDialogOption.YES_OPTION) {
            Response response = await _customerService.destroy(typeid);
            if (response.statusCode == 200)
              _customerViewContract.onDeleteSuccess(response, context: context);
            else
              _customerViewContract.onErrorRequest(response);
          } else {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
