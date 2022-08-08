import 'package:bs_flutter_inputtext/bs_flutter_inputtext.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../constants/base_text.dart';
import '../../../../helpers/function.dart';
import '../../../../models/session_model.dart';
import '../../../../presenters/auth_presenter.dart';
import '../../../../utils/select_api.dart';
import '../../../../utils/session_manager.dart';
import '../../../../utils/validators.dart';
import '../../../../widgets/form_group.dart';
import '../../../../widgets/input/custom_input.dart';
import '../../../../widgets/input/custom_input_currency.dart';
import '../../../../widgets/selectbox/custom_selectbox.dart';
import '../_text.dart';
import '../product/product_form.dart';

class ProspectProductSource extends GetxController {
  bool isProcessing = false;

  var selectedDateExpect = ''.obs;
  var id = 0.obs;

  var quantity = 0.0.obs;
  var price = 0.0.obs;

  var usd = false.obs;
  var totals = [].obs;
  var subtotal = 0.0.obs;

  BsSelectBoxController selectTax = BsSelectBoxController();
  BsSelectBoxController selectItem = BsSelectBoxController();

  TextEditingController inputQuantity = TextEditingController();
  TextEditingController inputAmount = TextEditingController();
  TextEditingController inputPrice = TextEditingController();
  TextEditingController inputDiscount = TextEditingController();
  TextEditingController inputTax = TextEditingController();

  Future<Map<String, dynamic>> toJson() async {
    SessionModel session = await SessionManager.current();
    return {
      'prosproductprospectid': id.value,
      'prosproductproductid': selectItem.getSelectedAsString(),
      'prosproductprice': inputPrice.text.replaceAll(',', ''),
      'prosproductqty': inputQuantity.text,
      'prosproducttax': inputTax.text,
      'prosproductdiscount': inputDiscount.text,
      'prosproductamount':
          inputAmount.text.replaceAll('.', '').replaceAll(',00', ''),
      'prosproducttaxtypeid': selectTax.getSelectedAsString(),
      'createdby': session.userid,
      'updatedby': session.userid,
    };
  }
}

class ProspectProductForm {
  final ProspectProductSource source;
  final _auth = Get.put(AuthPresenter());
  final currencyFormatter = NumberFormat('#,##0.00', 'ID');

  ProspectProductForm(this.source);

  Widget selectProduct() {
    return FormGroup(
      label: Text(ProspectText.labelItem),
      child: Column(
        children: [
          CustomSelectBox(
            searchable: true,
            disabled: source.isProcessing,
            controller: source.selectItem,
            hintText: BaseText.hiintSelect(field: ProspectText.labelItem),
            serverSide: (params) => selectApiProductWithBp(
                params, _auth.bpActiveId.value.toString()),
            // serverSide: (params) => selectApiProduct(params),
            validators: [Validators.selectRequired(ProspectText.labelItem)],
          ),
          Container(
            margin: EdgeInsets.only(top: 3),
            child: InkWell(
              onTap: () => Get.to(PProductFormFormView()),
              child: Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Add More Item',
                    style: TextStyle(color: Colors.blue),
                  )),
            ),
          )
        ],
      ),
    );
  }

  Widget inputQuantity() {
    return FormGroup(
      label: Text(ProspectText.labelQuantity),
      child: Obx(() => CustomInput(
            onChange: (value) {
              source.quantity.value = parseDouble(value);
              if (value == '') {
                source.quantity.value = 0;
                source.inputAmount.text = '';
                source.inputPrice.text = '';
              } else if (source.inputPrice.text != '') {
                var amount = source.quantity.value * source.price.value;
                // inputAmount.text = amount.toString();
                source.inputAmount.text = currencyFormatter
                    .format(amount)
                    .replaceAll(',00', '')
                    .replaceAll('.', ',');
                // source.subtotal.value += parseDouble(amount);
              }
            },
            disabled: source.isProcessing,
            controller: source.inputQuantity,
            hintText: BaseText.hintText(field: ProspectText.labelQuantity),
            validators: [],
          )),
    );
  }

  Widget inputPrices() {
    return FormGroup(
      label: Text(ProspectText.labelPrice),
      child: Obx(() => CustomInputCurrency(
            onChange: (value) {
              source.price.value = parseDouble(value.replaceAll(',', ''));
              if (value == '') {
                source.price.value = 0;
                source.inputAmount.text = '';
                source.inputQuantity.text = '';
              } else if (source.inputQuantity.text != '') {
                var amount = source.price.value * source.quantity.value;
                // inputAmount.text = amount.toString();
                source.inputAmount.text = currencyFormatter
                    .format(amount)
                    .replaceAll(',00', '')
                    .replaceAll('.', ',');
                ;
                // source.subtotal.value += amount;
              }
            },
            disabled: source.isProcessing,
            controller: source.inputPrice,
            hintText: BaseText.hintText(field: ProspectText.labelPrice),
            validators: [],
          )),
    );
  }

  Widget inputAmounts() {
    return FormGroup(
      label: Text(ProspectText.labelAmount),
      child: CustomInput(
        onChange: (value) {
          source.inputAmount.text = currencyFormatter.format(value);
        },
        readOnly: true,
        disabled: source.isProcessing,
        controller: source.inputAmount,
        hintText: 'Type ' +
            ProspectText.labelPrice +
            ' and ' +
            ProspectText.labelQuantity +
            ' First',
        validators: [],
      ),
    );
  }

  Widget inputDiscount() {
    return FormGroup(
      label: Text(ProspectText.labelDiscount),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputDiscount,
        hintText: BaseText.hintText(field: ProspectText.labelDiscount),
        validators: [
          BsInputValidator(validator: ((value) {
            if (value != '') {
              if (parseInt(value) > 100) {
                return 'Discount is Wrong';
              }
              return null;
            } else {
              return null;
            }
          })),
        ],
      ),
    );
  }

  Widget inputTax() {
    return FormGroup(
      label: Text(ProspectText.labelTax),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputTax,
        hintText: BaseText.hintText(field: ProspectText.labelTax),
        validators: [
          BsInputValidator(validator: ((value) {
            if (value != '') {
              if (parseInt(value) > 100) {
                return 'Taxes is Wrong';
              }
              return null;
            } else {
              return null;
            }
          })),
        ],
      ),
    );
  }

  Widget selectTax() {
    return FormGroup(
      label: Text(ProspectText.labelTaxType),
      child: CustomSelectBox(
        searchable: false,
        disabled: source.isProcessing,
        controller: source.selectTax,
        hintText: BaseText.hiintSelect(field: ProspectText.labelTaxType),
        serverSide: (params) => selectApiTaxTypes(params),
      ),
    );
  }
}
