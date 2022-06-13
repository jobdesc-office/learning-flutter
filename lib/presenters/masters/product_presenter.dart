import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/base_text.dart';
import '../../contracts/base/details_view_contract.dart';
import '../../contracts/base/edit_view_contract.dart';
import '../../contracts/base/index_view_contract.dart';
import '../../services/masters/product_service.dart';
import '../../utils/custom_get_controller.dart';
import '../../views/masters/product/product_form.dart';
import '../../widgets/confirm_dialog.dart';

class ProductPresenter extends CustomGetXController {
  final _productService = Get.find<ProductService>();

  late IndexViewContract _productViewContract;
  set productViewContract(IndexViewContract productViewContract) {
    _productViewContract = productViewContract;
  }

  late EditViewContract _productFetchDataContract;
  set productFetchDataContract(EditViewContract productFetchDataContract) {
    _productFetchDataContract = productFetchDataContract;
  }

  late DetailViewContract _productDataDetailsContract;
  set productDataDetailsContract(
      DetailViewContract productDataDetailsContract) {
    _productDataDetailsContract = productDataDetailsContract;
  }

  Future datatables(BuildContext context, Map<String, String> params) async {
    Response response = await _productService.datatables(params);
    if (response.statusCode == 200)
      _productViewContract.onLoadDatatables(context, response);
    else
      _productViewContract.onErrorRequest(response);
  }

  // void details(BuildContext context, int userid) async {
  //   setProcessing(true);
  //   showDialog(
  //     context: context,
  //     builder: (context) => ProductDetails(),
  //   );

  //   Response response = await _ProductService.show(userid);
  //   if (response.statusCode == 200)
  //     _ProductDataDetailsContract.onSuccessFetchData(response);
  //   else
  //     _ProductViewContract.onErrorRequest(response);
  // }

  void add(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => ProductFormView(
        onSave: (body) => save(context, body),
      ),
    );
  }

  void save(BuildContext context, Map<String, dynamic> body) async {
    Response response = await _productService.store(body);
    if (response.statusCode == 200)
      _productViewContract.onCreateSuccess(response, context: context);
    else
      _productViewContract.onErrorRequest(response);
  }

  void edit(BuildContext context, int id) async {
    setProcessing(true);
    showDialog(
      context: context,
      builder: (context) => ProductFormView(
        onSave: (body) => update(context, body, id),
      ),
    );

    Response response = await _productService.show(id);
    if (response.statusCode == 200)
      _productFetchDataContract.onSuccessFetchData(response);
    else
      _productViewContract.onErrorRequest(response);
  }

  void update(BuildContext context, Map<String, dynamic> body, int id) async {
    setProcessing(true);
    Response response = await _productService.update(id, body);
    if (response.statusCode == 200)
      _productViewContract.onEditSuccess(response, context: context);
    else
      _productViewContract.onErrorRequest(response);
  }

  void delete(BuildContext context, int typeid, String name) {
    showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
        title: BaseText.confirmTitle,
        message: BaseText.deleteConfirmDatatable(field: name),
        onPressed: (_, value) async {
          if (value == ConfirmDialogOption.YES_OPTION) {
            Response response = await _productService.destroy(typeid);
            if (response.statusCode == 200)
              _productViewContract.onDeleteSuccess(response, context: context);
            else
              _productViewContract.onErrorRequest(response);
          } else {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
