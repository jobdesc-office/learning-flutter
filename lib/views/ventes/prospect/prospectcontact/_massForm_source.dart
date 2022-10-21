import 'dart:convert';

import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../constants/base_text.dart';
import '../../../../models/session_model.dart';
import '../../../../presenters/navigation_presenter.dart';
import '../../../../utils/select_api.dart';
import '../../../../utils/session_manager.dart';
import '../../../../utils/validators.dart';
import '../../../../widgets/button/button_role_user.dart';
import '../../../../widgets/form_group.dart';
import '../../../../widgets/input/custom_input.dart';
import '../../../../widgets/selectbox/custom_selectbox.dart';
import '_text.dart';

final _navigation = Get.find<NavigationPresenter>();

class MassProspectContactSource {
  var isProcessing = false.obs;
  var id = 0.obs;

  TextEditingController inputName = TextEditingController();
  TextEditingController inputValue = TextEditingController();

  BsSelectBoxController selectType = BsSelectBoxController();

  List<BsSelectBoxController> selectsItem = List<BsSelectBoxController>.filled(
      1, BsSelectBoxController(),
      growable: true);

  List<TextEditingController> inputPrices = List<TextEditingController>.filled(
      1, TextEditingController(),
      growable: true);

  List<String> formats = List<String>.filled(1, '', growable: true).obs;

  List<Map<String, dynamic>> jsonProducts() {
    return List<Map<String, dynamic>>.from(selectsItem.map((controller) {
      int index = selectsItem.indexOf(controller);
      return {
        'contacttypeid': selectsItem[index].getSelectedAsString(),
        'contactvalueid': inputPrices[index].text
      };
    }));
  }

  Future<Map<String, dynamic>> toJson() async {
    SessionModel session = await SessionManager.current();
    return {
      'contactname': inputName.text,
      'contactbpcustomerid': id.value,
      'contact': jsonEncode(jsonProducts()),
      'createdby': session.userid,
      'updatedby': session.userid,
    };
  }
}

class MassProspectContactForm {
  final MassProspectContactSource source;

  MassProspectContactForm(this.source);

  Widget inputName() {
    return FormGroup(
      label: Obx(() => Text(ProspectContactText.labelName,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: Column(
        children: [
          CustomInput(
            disabled: source.isProcessing.value,
            controller: source.inputName,
            hintText: BaseText.hintText(field: ProspectContactText.labelName),
            validators: [
              Validators.inputRequired(ProspectContactText.labelName),
              Validators.maxLength(ProspectContactText.labelName, 255)
            ],
          ),
        ],
      ),
    );
  }

  Widget inputProduct({required ValueChanged<int> onRemoveItem}) {
    return Obx(() => Column(
          children: source.selectsItem.map((controller) {
            int index = source.selectsItem.indexOf(controller);
            var selectItem = source.selectsItem[index];
            var inputPrice = source.inputPrices[index];
            return BsRow(
              children: [
                BsCol(
                  margin: EdgeInsets.only(left: 5),
                  sizes: ColScreen(md: Col.col_5),
                  child: FormGroup(
                    label: Text(ProspectContactText.labelType,
                        style: TextStyle(
                            color: _navigation.darkTheme.value
                                ? Colors.white
                                : Colors.black)),
                    child: CustomSelectBox(
                      searchable: false,
                      disabled: source.isProcessing.value,
                      controller: selectItem,
                      hintText: BaseText.hiintSelect(
                          field: ProspectContactText.labelType),
                      serverSide: (params) => selectApiContactTypes(params),
                      onChange: (value) {
                        source.formats[index] =
                            value.getOtherValue()['sbttypename'];
                      },
                    ),
                  ),
                ),
                BsCol(
                  margin: EdgeInsets.only(left: 5),
                  sizes: ColScreen(md: Col.col_6),
                  child: FormGroup(
                    label: Text(ProspectContactText.labelValue,
                        style: TextStyle(
                            color: _navigation.darkTheme.value
                                ? Colors.white
                                : Colors.black)),
                    child: CustomInput(
                      minLines: 1,
                      maxLines: 5,
                      disabled: source.isProcessing.value,
                      controller: inputPrice,
                      hintText: BaseText.hintText(
                          field: ProspectContactText.labelValue),
                      inputFormatters: [
                        if (source.formats[index] == 'Phone')
                          FilteringTextInputFormatter.digitsOnly,
                      ],
                      validators: [
                        if (source.formats[index] == 'Email')
                          Validators.inputEmail()
                      ],
                    ),
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
}
