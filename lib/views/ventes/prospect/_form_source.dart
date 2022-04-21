import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/base_text.dart';
import '../../../models/session_model.dart';
import '../../../utils/session_manager.dart';
import '../../../utils/validators.dart';
import '../../../widgets/button/button_role_user.dart';
import '../../../widgets/form_group.dart';
import '../../../widgets/input/custom_input.dart';
import '../../../widgets/selectbox/custom_selectbox.dart';
import '_form_controller.dart';
import '_text.dart';

class ProspectSource {
  bool isProcessing = false;

  BsSelectBoxController selectCurrency = BsSelectBoxController(options: [
    BsSelectBoxOption(value: '{1}', text: Text('ID Rupiah')),
    BsSelectBoxOption(value: '{2}', text: Text('US Dollar'))
  ]);
  BsSelectBoxController selectPipeline = BsSelectBoxController(options: [
    BsSelectBoxOption(value: '{1}', text: Text('Pipeline')),
    BsSelectBoxOption(value: '{2}', text: Text('Dougnut'))
  ]);
  BsSelectBoxController selectVisible = BsSelectBoxController(options: [
    BsSelectBoxOption(value: '{1}', text: Text("Owner's visibility group")),
    BsSelectBoxOption(value: '{2}', text: Text('Employees'))
  ]);

  TextEditingController inputCompanyName = TextEditingController();
  TextEditingController inputName = TextEditingController();
  TextEditingController inputValue = TextEditingController();
  TextEditingController inputEmail = TextEditingController();
  TextEditingController inputPhone = TextEditingController();

  List<BsSelectBoxController> selectsPrivationEmail =
      List<BsSelectBoxController>.filled(
          1,
          BsSelectBoxController(options: [
            BsSelectBoxOption(value: '{1}', text: Text("Work")),
            BsSelectBoxOption(value: '{2}', text: Text('Private'))
          ]),
          growable: true);
  List<BsSelectBoxController> selectsPrivationPhone =
      List<BsSelectBoxController>.filled(
          1,
          BsSelectBoxController(options: [
            BsSelectBoxOption(value: '{1}', text: Text("Work")),
            BsSelectBoxOption(value: '{2}', text: Text('Private'))
          ]),
          growable: true);

  List<TextEditingController> inputEmails = List<TextEditingController>.filled(
      1, TextEditingController(),
      growable: true);
  List<TextEditingController> inputPhones = List<TextEditingController>.filled(
      1, TextEditingController(),
      growable: true);

  List<TextEditingController> inputItems = List<TextEditingController>.filled(
      1, TextEditingController(),
      growable: true);
  List<TextEditingController> inputPrices = List<TextEditingController>.filled(
      1, TextEditingController(),
      growable: true);
  List<TextEditingController> inputQuantities =
      List<TextEditingController>.filled(1, TextEditingController(),
          growable: true);
  List<TextEditingController> inputAmounts = List<TextEditingController>.filled(
      1, TextEditingController(),
      growable: true);

  List<Map<String, dynamic>> jsonEmails() {
    return List<Map<String, dynamic>>.from(inputEmails.map((controller) {
      int index = inputEmails.indexOf(controller);
      return {'email': inputEmails[index].text};
    }));
  }

  List<Map<String, dynamic>> jsonPhones() {
    return List<Map<String, dynamic>>.from(inputPhones.map((controller) {
      int index = inputPhones.indexOf(controller);
      return {'phone': inputPhones[index].text};
    }));
  }

  List<Map<String, dynamic>> jsonProducts() {
    return List<Map<String, dynamic>>.from(inputItems.map((controller) {
      int index = inputItems.indexOf(controller);
      return {
        'item': inputItems[index].text,
        'price': inputPrices[index].text,
        'quantity': inputQuantities[index].text,
        'amount': inputAmounts[index].text
      };
    }));
  }

  Future<Map<String, dynamic>> toJson() async {
    SessionModel session = await SessionManager.current();
    return {
      'bpname': inputCompanyName.text,
      'bppicname': inputName.text,
      'createdby': session.userid,
      'updatedby': session.userid,
      'isactive': true,
    };
  }
}

class ProspectForm {
  final c = Get.put(ProspectFormController());
  final ProspectSource source;

  ProspectForm(this.source);

  Widget inputContact() {
    return FormGroup(
      label: Text(ProspectText.labelOrganization),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputName,
        hintText: BaseText.hintText(),
        validators: [
          Validators.maxLength(ProspectText.labelName, 100),
        ],
      ),
    );
  }

  Widget inputOrganization() {
    return FormGroup(
      label: Text(ProspectText.labelName),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputName,
        hintText: BaseText.hintText(),
        validators: [
          Validators.maxLength(ProspectText.labelName, 100),
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
        hintText: BaseText.hintText(),
        validators: [
          Validators.inputRequired(ProspectText.labelName),
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
                sizes: ColScreen(md: Col.col_6),
                child: CustomInput(
                  disabled: c.isProduct.value,
                  controller: source.inputValue,
                  hintText: BaseText.hintText(),
                  validators: [
                    Validators.inputEmail(),
                  ],
                ),
              ),
              BsCol(
                margin: EdgeInsets.only(left: 5),
                sizes: ColScreen(md: Col.col_6),
                child: CustomSelectBox(
                  searchable: false,
                  disabled: c.isProduct.value,
                  controller: source.selectCurrency,
                  hintText: BaseText.hiintSelect(),
                ),
              ),
              BsCol(
                margin: EdgeInsets.only(left: 5),
                sizes: ColScreen(md: Col.col_12),
                child: Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                          onTap: (() => c.isProduct.toggle()),
                          child: Text(
                            c.isProduct.value ? c.addProduct : c.dontAddProduct,
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

  Widget inputPipeline() {
    return FormGroup(
      label: Text(ProspectText.labelPipeline),
      child: CustomSelectBox(
        searchable: false,
        disabled: source.isProcessing,
        controller: source.selectPipeline,
        hintText: BaseText.hiintSelect(),
      ),
    );
  }

  Widget inputPipelineStage() {
    return FormGroup(
      label: Text(ProspectText.labelPipelineStage),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputEmail,
        hintText: BaseText.hintText(),
        validators: [
          Validators.inputEmail(),
        ],
      ),
    );
  }

  Widget inputExpected() {
    return FormGroup(
      label: Text(ProspectText.labelExpected),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputEmail,
        hintText: BaseText.hintText(),
        validators: [
          Validators.inputEmail(),
        ],
      ),
    );
  }

  Widget inputVisible() {
    return FormGroup(
      label: Text(ProspectText.labelVisible),
      child: CustomSelectBox(
        searchable: false,
        disabled: source.isProcessing,
        controller: source.selectVisible,
        hintText: BaseText.hiintSelect(),
      ),
    );
  }

  Widget inputEmail({required ValueChanged<int> onRemoveEmail}) {
    return FormGroup(
        label: Text(ProspectText.labelEmail),
        child: Column(
          children: source.inputEmails.map((controller) {
            int index = source.inputEmails.indexOf(controller);
            var inputEmail = source.inputEmails[index];
            var selectPrivationEmail = source.selectsPrivationEmail[index];
            return BsRow(
              children: [
                BsCol(
                  margin: EdgeInsets.all(5),
                  sizes: ColScreen(md: Col.col_3),
                  child: CustomInput(
                    disabled: source.isProcessing,
                    controller: inputEmail,
                    hintText: BaseText.hintText(),
                    validators: [
                      Validators.inputEmail(),
                    ],
                  ),
                ),
                BsCol(
                  margin: EdgeInsets.all(5),
                  sizes: ColScreen(md: Col.col_3),
                  child: CustomSelectBox(
                    searchable: false,
                    disabled: source.isProcessing,
                    controller: selectPrivationEmail,
                    hintText: BaseText.hiintSelect(),
                  ),
                ),
                BsCol(
                  margin: EdgeInsets.only(left: 5, top: 3),
                  sizes: ColScreen(lg: Col.col_1),
                  child: FormGroup(
                    child: ButtonMultipleCancel(
                        disabled: source.inputEmails.length > 1 ? false : true,
                        margin: EdgeInsets.only(left: 10),
                        onPressed: () => onRemoveEmail(index)),
                  ),
                ),
              ],
            );
          }).toList(),
        ));
  }

  Widget inputPhone({required ValueChanged<int> onRemovePhone}) {
    return FormGroup(
        label: Text(ProspectText.labelPhone),
        child: Column(
          children: source.inputPhones.map((controller) {
            int index = source.inputPhones.indexOf(controller);
            var inputPhone = source.inputPhones[index];
            var selectPrivationPhone = source.selectsPrivationPhone[index];
            return BsRow(
              children: [
                BsCol(
                  margin: EdgeInsets.all(5),
                  sizes: ColScreen(md: Col.col_3),
                  child: CustomInput(
                    disabled: source.isProcessing,
                    controller: inputPhone,
                    hintText: BaseText.hintText(),
                    validators: [],
                  ),
                ),
                BsCol(
                  margin: EdgeInsets.all(5),
                  sizes: ColScreen(md: Col.col_3),
                  child: CustomSelectBox(
                    searchable: false,
                    disabled: source.isProcessing,
                    controller: selectPrivationPhone,
                    hintText: BaseText.hiintSelect(),
                  ),
                ),
                BsCol(
                  margin: EdgeInsets.only(left: 5, top: 3),
                  sizes: ColScreen(lg: Col.col_1),
                  child: FormGroup(
                    child: ButtonMultipleCancel(
                        disabled: source.inputPhones.length > 1 ? false : true,
                        margin: EdgeInsets.only(left: 10),
                        onPressed: () => onRemovePhone(index)),
                  ),
                ),
              ],
            );
          }).toList(),
        ));
  }

  Widget inputProduct({required ValueChanged<int> onRemoveItem}) {
    return Column(
      children: source.inputItems.map((controller) {
        int index = source.inputItems.indexOf(controller);
        var inputItem = source.inputItems[index];
        var inputPrice = source.inputPrices[index];
        var inputQuantity = source.inputQuantities[index];
        var inputAmount = source.inputAmounts[index];
        return BsRow(
          children: [
            BsCol(
              margin: EdgeInsets.only(right: 5),
              sizes: ColScreen(md: Col.col_5),
              child: FormGroup(
                label: Text(ProspectText.labelItem),
                child: CustomInput(
                  disabled: source.isProcessing,
                  controller: inputItem,
                  hintText: BaseText.hintText(),
                  validators: [
                    Validators.inputEmail(),
                  ],
                ),
              ),
            ),
            BsCol(
              margin: EdgeInsets.only(left: 5),
              sizes: ColScreen(md: Col.col_2),
              child: FormGroup(
                label: Text(ProspectText.labelPrice),
                child: CustomInput(
                  disabled: source.isProcessing,
                  controller: inputPrice,
                  hintText: BaseText.hintText(),
                  validators: [
                    Validators.inputEmail(),
                  ],
                ),
              ),
            ),
            BsCol(
              margin: EdgeInsets.only(left: 5),
              sizes: ColScreen(md: Col.col_2),
              child: FormGroup(
                label: Text(ProspectText.labelQuantity),
                child: CustomInput(
                  disabled: source.isProcessing,
                  controller: inputQuantity,
                  hintText: BaseText.hintText(),
                  validators: [
                    Validators.inputEmail(),
                  ],
                ),
              ),
            ),
            BsCol(
              margin: EdgeInsets.only(left: 5),
              sizes: ColScreen(md: Col.col_2),
              child: FormGroup(
                label: Text(ProspectText.labelAmount),
                child: CustomInput(
                  disabled: source.isProcessing,
                  controller: inputAmount,
                  hintText: BaseText.hintText(),
                  validators: [
                    Validators.inputEmail(),
                  ],
                ),
              ),
            ),
            BsCol(
              margin: EdgeInsets.only(left: 5, top: 3),
              sizes: ColScreen(lg: Col.col_1),
              child: FormGroup(
                label: Text(''),
                child: ButtonMultipleCancel(
                    disabled: source.inputItems.length > 1 ? false : true,
                    margin: EdgeInsets.only(left: 10),
                    onPressed: () => onRemoveItem(index)),
              ),
            )
          ],
        );
      }).toList(),
    );
  }

  Widget total() {
    return Container(
      margin: EdgeInsets.only(right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text('Total'),
          SizedBox(width: 100),
          Text('0'),
        ],
      ),
    );
  }
}
