import 'dart:convert';

import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:bs_flutter_inputtext/bs_flutter_inputtext.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../constants/base_text.dart';
import '../../../helpers/function.dart';
import '../../../models/session_model.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../presenters/ventes/prospect_presenter.dart';
import '../../../styles/color_palattes.dart';
import '../../../utils/select_api.dart';
import '../../../utils/session_manager.dart';
import '../../../utils/validators.dart';
import '../../../widgets/button/button_role_user.dart';
import '../../../widgets/form_group.dart';
import '../../../widgets/input/custom_input.dart';
import '../../../widgets/input/custom_input_currency.dart';
import '../../../widgets/input/custom_input_number.dart';
import '../../../widgets/selectbox/custom_selectbox.dart';
import '../../masters/menus/_menu_type.dart';
import '_form_controller.dart';
import '_text.dart';

final _navigation = Get.find<NavigationPresenter>();

class ProspectSource extends GetxController {
  final _presenter = Get.find<ProspectPresenter>();
  bool isProcessing = false;

  var quantity = 0.0.obs;
  var price = 0.0.obs;

  var selectedDateStart = ''.obs;
  var selectedDateEnd = ''.obs;
  var selectedDateExpect = ''.obs;
  var usd = false.obs;
  var totals = [].obs;
  var subtotal = 0.0.obs;

  List<String> total() {
    return List<String>.from(inputAmounts.map((controller) {
      int index = inputAmounts.indexOf(controller);
      subtotal.value += parseDouble(inputAmounts[index].text);
    }));
  }

  MenuTypeOptionsController prospectStageController =
      MenuTypeOptionsController();

  BsSelectBoxController selectCurrency = BsSelectBoxController(options: [
    BsSelectBoxOption(value: '1', text: Text('ID Rupiah')),
    BsSelectBoxOption(value: '2', text: Text('US Dollar'))
  ]);
  // BsSelectBoxController selectPipeline = BsSelectBoxController(options: [
  //   BsSelectBoxOption(value: '{1}', text: Text('Pipeline')),
  //   BsSelectBoxOption(value: '{2}', text: Text('Dougnut'))
  // ]);
  BsSelectBoxController selectOwner = BsSelectBoxController();
  BsSelectBoxController selectCustomer = BsSelectBoxController();
  BsSelectBoxController selectStatus = BsSelectBoxController();
  BsSelectBoxController selectType = BsSelectBoxController();

  TextEditingController inputCompanyName = TextEditingController();
  TextEditingController inputName = TextEditingController();
  TextEditingController inputValue = TextEditingController();
  // TextEditingController inputEmail = TextEditingController();
  // TextEditingController inputPhone = TextEditingController();
  TextEditingController inputDesc = TextEditingController();

  List<BsSelectBoxController> selectsTax = List<BsSelectBoxController>.filled(
      1, BsSelectBoxController(),
      growable: true);
  List<BsSelectBoxController> selectsItem = List<BsSelectBoxController>.filled(
      1, BsSelectBoxController(),
      growable: true);

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

  List<TextEditingController> inputPrices = List<TextEditingController>.filled(
      1, TextEditingController(),
      growable: true);
  List<TextEditingController> inputQuantities =
      List<TextEditingController>.filled(1, TextEditingController(),
          growable: true);
  List<TextEditingController> inputAmounts = List<TextEditingController>.filled(
      1, TextEditingController(),
      growable: true);
  List<TextEditingController> inputDiscounts =
      List<TextEditingController>.filled(1, TextEditingController(),
          growable: true);
  List<TextEditingController> inputTaxes = List<TextEditingController>.filled(
      1, TextEditingController(),
      growable: true);

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
      return {
        'item': selectsItem[index].getSelectedAsString(),
        'price': inputPrices[index].text.replaceAll(',', ''),
        'quantity': inputQuantities[index].text,
        'discount': inputDiscounts[index].text,
        'amount':
            inputAmounts[index].text.replaceAll(',00', '').replaceAll('.', ''),
        'tax': inputTaxes[index].text.replaceAll(',', ''),
        'taxtype': selectsTax[index].getSelectedAsString()
      };
    }));
  }

  Future<int> bpid() async {
    int provid =
        await _presenter.getBpId(selectOwner.getSelectedAsString().toString());
    return provid;
  }

  Future<Map<String, dynamic>> toJson() async {
    int provid =
        await _presenter.getBpId(selectOwner.getSelectedAsString().toString());
    SessionModel session = await SessionManager.current();
    return {
      'prospectname': inputCompanyName.text,
      'prospectstartdate': selectedDateStart.value,
      'prospectenddate': selectedDateEnd.value,
      'prospectvalue': inputValue.text.replaceAll(',', ''),
      'prospectowner': selectOwner.getSelectedAsString(),
      'prospectstageid': prospectStageController.getSelectedToString(),
      'prospectstatusid': selectStatus.getSelectedAsString(),
      'prospecttypeid': selectType.getSelectedAsString(),
      'prospectexpclosedate': selectedDateExpect.value,
      'prospectbpid': provid.toString(),
      'prospectdescription': inputDesc.text,
      'prospectcustid': selectCustomer.getSelectedAsString(),
      'prospectrefid': '1',
      'createdby': session.userid,
      'updatedby': session.userid,
      'isactive': true,
      'products': jsonEncode(jsonProducts()),
    };
  }
}

class ProspectForm {
  final ctrl = Get.put(ProspectFormController());
  final ProspectSource source;
  // final source = Get.put(ProspectSource());

  final currencyFormatter = NumberFormat('#,##0.00', 'ID');

  ProspectForm(this.source);

  Widget inputContact() {
    return FormGroup(
      label: Text(ProspectText.labelCustomer),
      child: CustomSelectBox(
        searchable: true,
        disabled: source.isProcessing,
        controller: source.selectCustomer,
        hintText: BaseText.hiintSelect(field: ProspectText.labelCustomer),
        serverSide: (params) => selectApiBpCustomer(params),
        validators: [Validators.selectRequired(ProspectText.labelCustomer)],
      ),
    );
  }

  Widget inputOrganization(context) {
    return FormGroup(
      child: BsRow(
        children: [
          BsCol(
            sizes: ColScreen(lg: Col.col_6),
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
          BsCol(
            margin: EdgeInsets.only(left: 10),
            sizes: ColScreen(lg: Col.col_6),
            child: FormGroup(
              label: Obx(() => Text(ProspectText.labelEndDate,
                  style: TextStyle(
                      color: _navigation.darkTheme.value
                          ? Colors.white
                          : Colors.black))),
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
                    _selectEndDates(context);
                  },
                  label: Obx(() => Text(source.selectedDateEnd.isEmpty
                      ? "Choose the End Date"
                      : '${source.selectedDateEnd}'))),
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
                  disabled: ctrl.isProduct.value,
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
                          onTap: (() => ctrl.isProduct.toggle()),
                          child: Text(
                            ctrl.isProduct.value
                                ? ctrl.addProduct
                                : ctrl.dontAddProduct,
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
      child: MenuTypeOptions(
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
    return FormGroup(
      label: Text(ProspectText.labelOwner),
      child: CustomSelectBox(
        searchable: true,
        disabled: source.isProcessing,
        controller: source.selectOwner,
        hintText: BaseText.hiintSelect(field: ProspectText.labelOwner),
        serverSide: (params) => selectApiProspectOwner(params),
        validators: [Validators.selectRequired(ProspectText.labelOwner)],
      ),
    );
  }

  Widget selectType() {
    return FormGroup(
      label: Text(ProspectText.labelType),
      child: CustomSelectBox(
        searchable: false,
        disabled: source.isProcessing,
        controller: source.selectType,
        hintText: BaseText.hiintSelect(field: ProspectText.labelType),
        serverSide: (params) => selectApiProspectTypes(params),
        validators: [Validators.selectRequired(ProspectText.labelType)],
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
        maxLines: 5,
        minLines: 3,
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
    return Obx(() => Column(
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
                          child: CustomSelectBox(
                            searchable: true,
                            disabled: source.isProcessing,
                            controller: selectItem,
                            hintText: BaseText.hiintSelect(
                                field: ProspectText.labelItem),
                            // serverSide: (params) => selectApiProductWithBp(
                            //     params, source.bpid.toString()),
                            serverSide: (params) => selectApiProduct(params),
                            validators: [
                              Validators.selectRequired(ProspectText.labelItem)
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
                              } else if (inputPrice != '') {
                                var amount =
                                    source.quantity.value * source.price.value;
                                // inputAmount.text = amount.toString();
                                inputAmount.text =
                                    currencyFormatter.format(amount);
                                // source.subtotal.value += parseDouble(amount);
                              }
                            },
                            disabled: ctrl.isProduct.value,
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
                              } else if (inputQuantity != '') {
                                var amount =
                                    source.price.value * source.quantity.value;
                                // inputAmount.text = amount.toString();
                                inputAmount.text =
                                    currencyFormatter.format(amount);
                                // source.subtotal.value += amount;
                              }
                            },
                            disabled: ctrl.isProduct.value,
                            controller: inputPrice,
                            hintText: BaseText.hintText(
                                field: ProspectText.labelPrice),
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
                              inputAmount.text =
                                  currencyFormatter.format(value);
                            },
                            readOnly: true,
                            disabled: ctrl.isProduct.value,
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
                      BsCol(
                        margin: EdgeInsets.only(left: 5),
                        sizes: ColScreen(md: Col.col_2),
                        child: FormGroup(
                          label: Text(ProspectText.labelDiscount),
                          child: CustomInput(
                            disabled: ctrl.isProduct.value,
                            controller: inputDiscount,
                            hintText: BaseText.hintText(
                                field: ProspectText.labelDiscount),
                            validators: [
                              Validators.maxLength(
                                  ProspectText.labelDiscount, 3),
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
                        ),
                      ),
                      BsCol(
                        margin: EdgeInsets.only(left: 5),
                        sizes: ColScreen(md: Col.col_2),
                        child: FormGroup(
                          label: Text(ProspectText.labelTax),
                          child: CustomInput(
                            disabled: ctrl.isProduct.value,
                            controller: inputTax,
                            hintText:
                                BaseText.hintText(field: ProspectText.labelTax),
                            validators: [
                              Validators.maxLength(ProspectText.labelTax, 3),
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
                        ),
                      ),
                      BsCol(
                        margin: EdgeInsets.only(left: 5),
                        sizes: ColScreen(md: Col.col_3),
                        child: FormGroup(
                          label: Text(ProspectText.labelTaxType),
                          child: CustomSelectBox(
                            searchable: false,
                            disabled: ctrl.isProduct.value,
                            controller: selectTax,
                            hintText: BaseText.hiintSelect(
                                field: ProspectText.labelTaxType),
                            serverSide: (params) => selectApiTaxTypes(params),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                BsCol(
                  sizes: ColScreen(sm: Col.col_1),
                  child: BsRow(children: [
                    BsCol(
                      margin: EdgeInsets.only(left: 5, top: 3),
                      sizes: ColScreen(lg: Col.col_12),
                      child: FormGroup(
                        label: Text(''),
                        child: ButtonMultipleCancel(
                            disabled:
                                source.selectsItem.length > 1 ? false : true,
                            margin: EdgeInsets.only(left: 10),
                            onPressed: () => onRemoveItem(index)),
                      ),
                    )
                  ]),
                )
              ],
            );
          }).toList(),
        ));
  }

  Widget total() {
    return Container(
        margin: EdgeInsets.only(right: 20),
        child: Obx(() {
          source.total;
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
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (selectedStart != null && selectedStart != source.selectedDateStart) {
      source.selectedDateStart.value =
          '${selectedStart.year}-${selectedStart.month}-${selectedStart.day}';
    }
  }

  _selectEndDates(BuildContext context) async {
    final DateTime? selectedEnd = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (selectedEnd != null && selectedEnd != source.selectedDateEnd) {
      source.selectedDateEnd.value =
          '${selectedEnd.year}-${selectedEnd.month}-${selectedEnd.day}';
    }
  }

  _selectExpectDates(BuildContext context) async {
    final DateTime? selectedExpected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (selectedExpected != null &&
        selectedExpected != source.selectedDateExpect) {
      source.selectedDateExpect.value =
          '${selectedExpected.year}-${selectedExpected.month}-${selectedExpected.day}';
    }
  }
}
