import 'dart:convert';

import 'package:boilerplate/services/settings/customfield_service.dart';
import 'package:boilerplate/views/ventes/prospect/customer/customer_form.dart';
import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:bs_flutter_inputtext/bs_flutter_inputtext.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../constants/base_text.dart';
import '../../../helpers/function.dart';
import '../../../models/session_model.dart';
import '../../../presenters/masters/product_presenter.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../styles/color_palattes.dart';
import '../../../utils/select_api.dart';
import '../../../utils/session_manager.dart';
import '../../../utils/validators.dart';
import '../../../widgets/button/button_role_user.dart';
import '../../../widgets/form_group.dart';
import '../../../widgets/input/custom_input.dart';
import '../../../widgets/input/custom_input_currency.dart';
import '../../../widgets/selectbox/custom_selectbox.dart';
import '../../masters/menus/_menu_sbttype.dart';
import '_text.dart';

final _navigation = Get.find<NavigationPresenter>();
final presenter = Get.find<ProductPresenter>();

class ProspectSource extends GetxController {
  bool isProcessing = false;

  var quantity = 0.0.obs;
  var price = 0.0.obs;

  var selectedDateStart = ''.obs;
  var selectedDateExpect = ''.obs;
  var usd = false.obs;
  var totals = [].obs;
  var subtotal = 0.0.obs;

  final addProduct = 'Add Product';
  final dontAddProduct = "Don't Add Product";

  var isProduct = false.obs;

  var createdby = ''.obs;
  var createddate = ''.obs;
  var updatedby = ''.obs;
  var updateddate = ''.obs;
  var isactive = true.obs;

  reset() {
    selectsTax.clear();
    selectsItem.clear();
    inputPrices.clear();
    inputQuantities.clear();
    inputAmounts.clear();
    inputDiscounts.clear();
    inputTaxes.clear();
  }

  List<String> total() {
    return List<String>.from(inputAmounts.map((controller) {
      int index = inputAmounts.indexOf(controller);
      subtotal.value += parseDouble(inputAmounts[index].text);
    }));
  }

  MenuSbttypeOptionsController prospectStageController =
      MenuSbttypeOptionsController();

  BsSelectBoxController selectCurrency = BsSelectBoxController(options: [
    BsSelectBoxOption(value: '1', text: Text('ID Rupiah')),
    BsSelectBoxOption(value: '2', text: Text('US Dollar'))
  ]);
  // BsSelectBoxController selectPipeline = BsSelectBoxController(options: [
  //   BsSelectBoxOption(value: '{1}', text: Text('Pipeline')),
  //   BsSelectBoxOption(value: '{2}', text: Text('Dougnut'))
  // ]);
  BsSelectBoxController selectBp = BsSelectBoxController();
  BsSelectBoxController selectOwner = BsSelectBoxController();
  BsSelectBoxController selectReference = BsSelectBoxController();
  BsSelectBoxController selectCustLab = BsSelectBoxController();
  BsSelectBoxController selectCustomer = BsSelectBoxController();
  BsSelectBoxController selectStatus = BsSelectBoxController();

  TextEditingController inputCompanyName = TextEditingController();
  TextEditingController inputName = TextEditingController();
  TextEditingController inputValue = TextEditingController();
  // TextEditingController inputEmail = TextEditingController();
  // TextEditingController inputPhone = TextEditingController();
  TextEditingController inputDesc = TextEditingController();

  List<BsSelectBoxController> selectsTax =
      List<BsSelectBoxController>.empty(growable: true);
  List<BsSelectBoxController> selectsItem =
      List<BsSelectBoxController>.empty(growable: true);

  // List<BsSelectBoxController> selectsPrivationEmail =
  //     List<BsSelectBoxController>.filled(
  //         1,
  //         BsSelectBoxController(options: [
  //           BsSelectBoxOption(value: '{1}', text: Text("Work")),
  //           BsSelectBoxOption(value: '{2}', text: Text('Private'))
  //         ]),
  //         growable: true);
  // List<BsSelectBoxController> selectsPrivationPhone =
  //     List<BsSelectBoxController>.filled(
  //         1,
  //         BsSelectBoxController(options: [
  //           BsSelectBoxOption(value: '{1}', text: Text("Work")),
  //           BsSelectBoxOption(value: '{2}', text: Text('Private'))
  //         ]),
  //         growable: true);

  // List<TextEditingController> inputEmails = List<TextEditingController>.filled(
  //     1, TextEditingController(),
  //     growable: true);
  // List<TextEditingController> inputPhones = List<TextEditingController>.filled(
  //     1, TextEditingController(),
  //     growable: true);

  List<TextEditingController> inputPrices =
      List<TextEditingController>.empty(growable: true);
  List<TextEditingController> inputQuantities =
      List<TextEditingController>.empty(growable: true);
  List<TextEditingController> inputAmounts =
      List<TextEditingController>.empty(growable: true);
  List<TextEditingController> inputDiscounts =
      List<TextEditingController>.empty(growable: true);
  List<TextEditingController> inputTaxes =
      List<TextEditingController>.empty(growable: true);

  // List<Map<String, dynamic>> jsonEmails() {
  //   return List<Map<String, dynamic>>.from(inputEmails.map((controller) {
  //     int index = inputEmails.indexOf(controller);
  //     return {'email': inputEmails[index].text};
  //   }));
  // }

  // List<Map<String, dynamic>> jsonPhones() {
  //   return List<Map<String, dynamic>>.from(inputPhones.map((controller) {
  //     int index = inputPhones.indexOf(controller);
  //     return {'phone': inputPhones[index].text};
  //   }));
  // }

  List<Map<String, dynamic>> jsonProducts() {
    return List<Map<String, dynamic>>.from(selectsItem.map((controller) {
      int index = selectsItem.indexOf(controller);
      var discount;
      var tax;
      var taxtype;
      if (inputDiscounts[index].text == '') {
        discount = null;
      } else {
        discount = inputDiscounts[index].text;
      }
      if (inputTaxes[index].text == '') {
        tax = null;
      } else {
        tax = inputTaxes[index].text;
      }
      if (selectsTax[index].getSelectedAsString() == '') {
        taxtype = null;
      } else {
        taxtype = selectsTax[index].getSelectedAsString();
      }
      return {
        'item': selectsItem[index].getSelectedAsString(),
        'price': inputPrices[index].text != ''
            ? inputPrices[index].text.replaceAll('.', '').replaceAll(',', '')
            : null,
        'quantity': inputQuantities[index].text != ''
            ? inputQuantities[index].text
            : null,
        'discount': discount,
        'amount': inputAmounts[index].text != ''
            ? inputAmounts[index].text.replaceAll('.', '').replaceAll(',', '')
            : null,
        'tax': tax,
        'taxtype': taxtype
      };
    }));
  }

  Future<Map<String, dynamic>> toJson() async {
    SessionModel session = await SessionManager.current();
    return {
      'prospectname': inputCompanyName.text,
      'prospectstartdate': selectedDateStart.value,
      'prospectvalue': inputValue.text.replaceAll(',', ''),
      'prospectowner': selectOwner.getSelectedAsString(),
      'prospectstageid': prospectStageController.getSelectedToString(),
      'prospectstatusid': selectStatus.getSelectedAsString(),
      'prospectexpclosedate': selectedDateExpect.value,
      'prospectbpid': box.read('mybpid'),
      'prospectdescription': inputDesc.text,
      'prospectcustid': selectCustomer.getSelectedAsString(),
      'prospectcustlabel': selectCustLab.getSelectedAsString(),
      'prospectrefid': selectReference.getSelectedAsString() != ''
          ? selectReference.getSelectedAsString()
          : null,
      'createdby': session.userid,
      'updatedby': session.userid,
      'isactive': isactive.value,
      'products': jsonEncode(jsonProducts()),
    };
  }
}

class ProspectForm {
  final ProspectSource source;
  // final source = Get.put(ProspectSource());

  final currencyFormatter = NumberFormat('#,##0.00', 'ID');

  ProspectForm(this.source);

  Widget inputOrganization(context) {
    return FormGroup(
      child: BsRow(
        children: [
          BsCol(
            child: FormGroup(
              label: Obx(() => Text(ProspectText.labelStartDate,
                  style: TextStyle(
                      color: _navigation.darkTheme.value
                          ? Colors.white
                          : Colors.black))),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: BsButton(
                  style: BsButtonStyle(
                      color: Color.fromARGB(255, 165, 165, 165),
                      backgroundColor: _navigation.darkTheme.value
                          ? ColorPallates.elseDarkColor
                          : Colors.white,
                      borderColor: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  width: MediaQuery.of(context).size.width,
                  onPressed: () {
                    _selectStartDates(context);
                  },
                  label: Obx(() => Text(source.selectedDateStart.isEmpty
                      ? "Choose the Start Date"
                      : '${source.selectedDateStart}')),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget inputTitle() {
    return FormGroup(
      label: Text(ProspectText.labelTitle),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputCompanyName,
        hintText: BaseText.hintText(field: ProspectText.labelTitle),
        validators: [
          Validators.inputRequired(ProspectText.labelTitle),
        ],
      ),
    );
  }

  Widget inputValue() {
    return FormGroup(
      label: Text(ProspectText.labelValue),
      child: Obx(() => BsRow(
            children: [
              BsCol(
                margin: EdgeInsets.only(right: 5),
                sizes: ColScreen(md: Col.col_12),
                child: CustomInputCurrency(
                  disabled: source.isProduct.value,
                  controller: source.inputValue,
                  hintText: BaseText.hintText(field: ProspectText.labelValue),
                ),
              ),
              // BsCol(
              //   margin: EdgeInsets.only(left: 5),
              //   sizes: ColScreen(md: Col.col_6),
              //   child: CustomSelectBox(
              //     searchable: false,
              //     disabled: controller.isProduct.value,
              //     controller: source.selectCurrency,
              //     hintText: BaseText.hiintSelect(),
              //   ),
              // ),
              BsCol(
                margin: EdgeInsets.only(left: 5),
                sizes: ColScreen(md: Col.col_12),
                child: Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                          onTap: (() {
                            source.reset();
                            source.inputValue.text = '';
                            source.isProduct.toggle();
                          }),
                          child: Text(
                            source.isProduct.value
                                ? source.addProduct
                                : source.dontAddProduct,
                            style: TextStyle(color: Colors.blue.shade300),
                          ))
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }

  // Widget inputPipeline() {
  //   return FormGroup(
  //     label: Text(ProspectText.labelPipeline),
  //     child: CustomSelectBox(
  //       searchable: false,
  //       disabled: source.isProcessing,
  //       controller: source.selectPipeline,
  //       hintText: BaseText.hiintSelect(),
  //     ),
  //   );
  // }

  Widget inputPipelineStage() {
    return FormGroup(
      label: Obx(() => Text(ProspectText.labelPipelineStage,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: MenuSbttypeOptions(
        controller: source.prospectStageController,
      ),
    );
  }

  Widget inputExpected(context) {
    return FormGroup(
      label: Obx(() => Text(ProspectText.labelExpected,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: BsButton(
          style: BsButtonStyle(
              color: Color.fromARGB(255, 165, 165, 165),
              backgroundColor: _navigation.darkTheme.value
                  ? ColorPallates.elseDarkColor
                  : Colors.white,
              borderColor: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(5))),
          width: MediaQuery.of(context).size.width,
          onPressed: () {
            _selectExpectDates(context);
          },
          label: Obx(() => Text(source.selectedDateExpect.isEmpty
              ? "Choose the Expected Date"
              : '${source.selectedDateExpect}')),
        ),
      ),
    );
  }

  Widget selectOwner() {
    return BsRow(
      children: [
        BsCol(
          margin: EdgeInsets.only(right: 5),
          sizes: ColScreen(sm: Col.col_6),
          child: FormGroup(
            label: Text(ProspectText.labelOwner),
            child: CustomSelectBox(
              searchable: true,
              disabled: source.isProcessing,
              controller: source.selectOwner,
              hintText: BaseText.hiintSelect(field: ProspectText.labelOwner),
              serverSide: (params) => selectApiProspectOwner(params),
              validators: [Validators.selectRequired(ProspectText.labelOwner)],
            ),
          ),
        ),
        BsCol(
          margin: EdgeInsets.only(left: 5),
          sizes: ColScreen(sm: Col.col_6),
          child: FormGroup(
            label: Text(ProspectText.labelCustomer),
            child: Column(
              children: [
                CustomSelectBox(
                  searchable: true,
                  disabled: source.isProcessing,
                  controller: source.selectCustomer,
                  hintText:
                      BaseText.hiintSelect(field: ProspectText.labelCustomer),
                  serverSide: (params) => selectApiBpCustomer(params),
                  validators: [
                    Validators.selectRequired(ProspectText.labelCustomer)
                  ],
                ),
                Container(
                  child: InkWell(
                    onTap: () => Get.to(PCustomerFormFormView()),
                    child: Container(
                        margin: EdgeInsets.only(top: 3),
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Add More Customer',
                          style: TextStyle(color: Colors.blue),
                        )),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget selectReference() {
    return FormGroup(
      label: Text(ProspectText.labelReference),
      child: CustomSelectBox(
        searchable: true,
        disabled: source.isProcessing,
        controller: source.selectReference,
        hintText: BaseText.hiintSelect(field: ProspectText.labelReference),
        serverSide: (params) => selectApiProspectReference(params),
      ),
    );
  }

  Widget selectCustLab() {
    return FormGroup(
      label: Text(ProspectText.labelCustLab),
      child: CustomSelectBox(
        searchable: true,
        disabled: source.isProcessing,
        controller: source.selectCustLab,
        hintText: BaseText.hiintSelect(field: ProspectText.labelCustLab),
        serverSide: (params) => selectApiProspectCustLab(params),
      ),
    );
  }

  // Widget inputEmail({required ValueChanged<int> onRemoveEmail}) {
  //   return FormGroup(
  //       label: Text(ProspectText.labelEmail),
  //       child: Column(
  //         children: source.inputEmails.map((controller) {
  //           int index = source.inputEmails.indexOf(controller);
  //           var inputEmail = source.inputEmails[index];
  //           var selectPrivationEmail = source.selectsPrivationEmail[index];
  //           return BsRow(
  //             children: [
  //               BsCol(
  //                 margin: EdgeInsets.all(5),
  //                 sizes: ColScreen(md: Col.col_3),
  //                 child: CustomInput(
  //                   disabled: source.isProcessing,
  //                   controller: inputEmail,
  //                   hintText: BaseText.hintText(),
  //                   validators: [
  //                     Validators.inputEmail(),
  //                   ],
  //                 ),
  //               ),
  //               BsCol(
  //                 margin: EdgeInsets.all(5),
  //                 sizes: ColScreen(md: Col.col_3),
  //                 child: CustomSelectBox(
  //                   searchable: false,
  //                   disabled: source.isProcessing,
  //                   controller: selectPrivationEmail,
  //                   hintText: BaseText.hiintSelect(),
  //                 ),
  //               ),
  //               BsCol(
  //                 margin: EdgeInsets.only(left: 5, top: 3),
  //                 sizes: ColScreen(lg: Col.col_1),
  //                 child: FormGroup(
  //                   child: ButtonMultipleCancel(
  //                       disabled: source.inputEmails.length > 1 ? false : true,
  //                       margin: EdgeInsets.only(left: 10),
  //                       onPressed: () => onRemoveEmail(index)),
  //                 ),
  //               ),
  //             ],
  //           );
  //         }).toList(),
  //       ));
  // }

  // Widget inputPhone({required ValueChanged<int> onRemovePhone}) {
  //   return FormGroup(
  //       label: Text(ProspectText.labelPhone),
  //       child: Column(
  //         children: source.inputPhones.map((controller) {
  //           int index = source.inputPhones.indexOf(controller);
  //           var inputPhone = source.inputPhones[index];
  //           var selectPrivationPhone = source.selectsPrivationPhone[index];
  //           return BsRow(
  //             children: [
  //               BsCol(
  //                 margin: EdgeInsets.all(5),
  //                 sizes: ColScreen(md: Col.col_3),
  //                 child: CustomInput(
  //                   disabled: source.isProcessing,
  //                   controller: inputPhone,
  //                   hintText: BaseText.hintText(),
  //                   validators: [],
  //                 ),
  //               ),
  //               BsCol(
  //                 margin: EdgeInsets.all(5),
  //                 sizes: ColScreen(md: Col.col_3),
  //                 child: CustomSelectBox(
  //                   searchable: false,
  //                   disabled: source.isProcessing,
  //                   controller: selectPrivationPhone,
  //                   hintText: BaseText.hiintSelect(),
  //                 ),
  //               ),
  //               BsCol(
  //                 margin: EdgeInsets.only(left: 5, top: 3),
  //                 sizes: ColScreen(lg: Col.col_1),
  //                 child: FormGroup(
  //                   child: ButtonMultipleCancel(
  //                       disabled: source.inputPhones.length > 1 ? false : true,
  //                       margin: EdgeInsets.only(left: 10),
  //                       onPressed: () => onRemovePhone(index)),
  //                 ),
  //               ),
  //             ],
  //           );
  //         }).toList(),
  //       ));
  // }

  Widget inputDesc() {
    return FormGroup(
      label: Text(ProspectText.labelDesc),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputDesc,
        hintText: BaseText.hintText(field: ProspectText.labelDesc),
        maxLines: 2,
        minLines: 2,
      ),
    );
  }

  Widget inputStatus() {
    return FormGroup(
      label: Text(ProspectText.labelStatus),
      child: CustomSelectBox(
        searchable: false,
        disabled: source.isProcessing,
        controller: source.selectStatus,
        hintText: BaseText.hiintSelect(field: ProspectText.labelStatus),
        serverSide: (params) => selectApiProspectStatus(params),
        validators: [Validators.selectRequired(ProspectText.labelStatus)],
      ),
    );
  }

  Widget inputProduct({required ValueChanged<int> onRemoveItem}) {
    return Column(
      children: source.selectsItem.map((controller) {
        int index = source.selectsItem.indexOf(controller);
        var selectItem = source.selectsItem[index];
        var inputPrice = source.inputPrices[index];
        var inputQuantity = source.inputQuantities[index];
        var inputAmount = source.inputAmounts[index];
        var inputDiscount = source.inputDiscounts[index];
        var inputTax = source.inputTaxes[index];
        var selectTax = source.selectsTax[index];
        return BsRow(
          children: [
            BsCol(
              sizes: ColScreen(sm: Col.col_11),
              child: BsRow(
                children: [
                  BsCol(
                    sizes: ColScreen(md: Col.col_6),
                    child: FormGroup(
                      label: Text(ProspectText.labelItem),
                      child: Column(
                        children: [
                          CustomSelectBox(
                            searchable: true,
                            disabled: source.isProcessing,
                            controller: selectItem,
                            hintText: BaseText.hiintSelect(
                                field: ProspectText.labelItem),
                            serverSide: (params) => selectApiProductWithBp(
                                params, box.read('mybpid').toString()),
                            // serverSide: (params) => selectApiProduct(params),
                            validators: [
                              Validators.selectRequired(ProspectText.labelItem)
                            ],
                            onChange: (val) async {
                              if (val.getValueAsString() == 'add') {
                                SessionModel session =
                                    await SessionManager.current();
                                presenter.saveViaProspect({
                                  'productname': val.getOtherValue()['name'],
                                  'productbpid': val.getOtherValue()['bpid'],
                                  'createdby': session.userid,
                                  'updatedby': session.userid,
                                  'isactive': true,
                                });
                                selectItem.clear();
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  BsCol(
                    margin: EdgeInsets.only(left: 5),
                    sizes: ColScreen(md: Col.col_3),
                    child: FormGroup(
                      label: Text(ProspectText.labelQuantity),
                      child: CustomInput(
                        onChange: (value) {
                          source.quantity.value = parseDouble(value);
                          if (value == '') {
                            source.quantity.value = 0;
                            inputAmount.text = '';
                          } else if (inputPrice.text != '') {
                            var amount =
                                source.quantity.value * source.price.value;
                            // inputAmount.text = amount.toString();
                            inputAmount.text = currencyFormatter
                                .format(amount)
                                .replaceAll(',00', '')
                                .replaceAll('.', ',');
                            // source.subtotal.value += parseDouble(amount);
                          }
                        },
                        disabled: source.isProduct.value,
                        controller: inputQuantity,
                        hintText: BaseText.hintText(
                            field: ProspectText.labelQuantity),
                        validators: [],
                      ),
                    ),
                  ),
                  BsCol(
                    margin: EdgeInsets.only(left: 5),
                    sizes: ColScreen(md: Col.col_3),
                    child: FormGroup(
                      label: Text(ProspectText.labelPrice),
                      child: CustomInputCurrency(
                        onChange: (value) {
                          source.price.value =
                              parseDouble(value.replaceAll(',', ''));
                          if (value == '') {
                            source.price.value = 0;
                            inputAmount.text = '';
                          } else if (inputQuantity.text != '') {
                            var amount =
                                source.price.value * source.quantity.value;
                            // inputAmount.text = amount.toString();
                            inputAmount.text = currencyFormatter
                                .format(amount)
                                .replaceAll(',00', '')
                                .replaceAll('.', ',');
                            // source.subtotal.value += amount;
                          }
                        },
                        disabled: source.isProduct.value,
                        controller: inputPrice,
                        hintText:
                            BaseText.hintText(field: ProspectText.labelPrice),
                        validators: [],
                      ),
                    ),
                  ),
                  BsCol(
                    sizes: ColScreen(md: Col.col_5),
                    child: FormGroup(
                      label: Text(ProspectText.labelAmount),
                      child: CustomInput(
                        onChange: (value) {
                          final currencyFormatter =
                              NumberFormat.currency(locale: 'ID');
                          inputAmount.text = currencyFormatter.format(value);
                        },
                        readOnly: true,
                        disabled: source.isProduct.value,
                        controller: inputAmount,
                        hintText: 'Type ' +
                            ProspectText.labelPrice +
                            ' and ' +
                            ProspectText.labelQuantity +
                            ' First',
                        validators: [],
                      ),
                    ),
                  ),
                  // BsCol(
                  //   margin: EdgeInsets.only(left: 5),
                  //   sizes: ColScreen(md: Col.col_2),
                  //   child: FormGroup(
                  //     label: Text(ProspectText.labelDiscount),
                  //     child: CustomInput(
                  //       disabled: source.isProduct.value,
                  //       controller: inputDiscount,
                  //       hintText: BaseText.hintText(
                  //           field: ProspectText.labelDiscount),
                  //       validators: [
                  //         BsInputValidator(validator: ((value) {
                  //           if (value != '') {
                  //             if (parseInt(value) > 100) {
                  //               return 'Discount is Wrong';
                  //             }
                  //             return null;
                  //           } else {
                  //             return null;
                  //           }
                  //         })),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // BsCol(
                  //   margin: EdgeInsets.only(left: 5),
                  //   sizes: ColScreen(md: Col.col_2),
                  //   child: FormGroup(
                  //     label: Text(ProspectText.labelTax),
                  //     child: CustomInput(
                  //       disabled: source.isProduct.value,
                  //       controller: inputTax,
                  //       hintText:
                  //           BaseText.hintText(field: ProspectText.labelTax),
                  //       validators: [
                  //         BsInputValidator(validator: ((value) {
                  //           if (value != '') {
                  //             if (parseInt(value) > 100) {
                  //               return 'Taxes is Wrong';
                  //             }
                  //             return null;
                  //           } else {
                  //             return null;
                  //           }
                  //         })),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // BsCol(
                  //   margin: EdgeInsets.only(left: 5),
                  //   sizes: ColScreen(md: Col.col_3),
                  //   child: FormGroup(
                  //     label: Text(ProspectText.labelTaxType),
                  //     child: CustomSelectBox(
                  //       searchable: false,
                  //       disabled: source.isProduct.value,
                  //       controller: selectTax,
                  //       hintText: BaseText.hiintSelect(
                  //           field: ProspectText.labelTaxType),
                  //       serverSide: (params) => selectApiTaxTypes(params),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            BsCol(
              sizes: ColScreen(sm: Col.col_1),
              child: BsRow(children: [
                BsCol(
                  margin: EdgeInsets.only(left: 4, top: 3),
                  sizes: ColScreen(lg: Col.col_12),
                  child: FormGroup(
                    label: Text(''),
                    child: ButtonMultipleCancel(
                        disabled: source.selectsItem.length > 1 ? false : true,
                        margin: EdgeInsets.only(left: 10),
                        onPressed: () => onRemoveItem(index)),
                  ),
                )
              ]),
            )
          ],
        );
      }).toList(),
    );
  }

  Widget total() {
    return Container(
        margin: EdgeInsets.only(right: 20),
        child: Obx(() {
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('Total'),
              SizedBox(width: 100),
              Text(source.subtotal.value.toString()),
            ],
          );
        }));
  }

  _selectStartDates(BuildContext context) async {
    final DateTime? selectedStart = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (selectedStart != null) {
      source.selectedDateStart.value =
          '${selectedStart.year}-${selectedStart.month}-${selectedStart.day}';
    }
  }

  _selectExpectDates(BuildContext context) async {
    final DateTime? selectedExpected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (selectedExpected != null) {
      source.selectedDateExpect.value =
          '${selectedExpected.year}-${selectedExpected.month}-${selectedExpected.day}';
    }
  }
}
