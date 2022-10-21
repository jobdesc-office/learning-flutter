import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../constants/base_text.dart';
import '../../../../models/session_model.dart';
import '../../../../presenters/navigation_presenter.dart';
import '../../../../utils/select_api.dart';
import '../../../../utils/session_manager.dart';
import '../../../../utils/validators.dart';
import '../../../../widgets/form_group.dart';
import '../../../../widgets/input/custom_input.dart';
import '../../../../widgets/selectbox/custom_selectbox.dart';
import '../_detail_source.dart';
import '_text.dart';

final _navigation = Get.find<NavigationPresenter>();
final source = Get.put(ProspectDetailsSource());

class ProspectCustomFieldSource extends GetxController {
  reset() {
    format.value = '';
    inputValue.text = '';
    selectCustomfield.clear();
    selectOption.clear();
  }

  bool isProcessing = false;

  var format = ''.obs;

  BsSelectBoxController selectCustomfield = BsSelectBoxController();
  BsSelectBoxController selectOption = BsSelectBoxController();

  TextEditingController inputValue = TextEditingController();

  Future<Map<String, dynamic>> toJson() async {
    SessionModel session = await SessionManager.current();
    return {
      'prospectid': source.prospectid.value,
      'prospectcustfid': selectCustomfield.getSelectedAsString(),
      'prospectcfvalue': inputValue.text,
      'optchoosed':
          source.isSelect.value ? selectOption.getSelectedAsString() : null,
      'createdby': session.userid,
      'updatedby': session.userid,
    };
  }
}

class ProspectCustomFieldForm {
  final ProspectCustomFieldSource source;

  ProspectCustomFieldForm(this.source);

  Widget selectCf() {
    return FormGroup(
      label: Obx(() => Text(ProspectCustomFieldText.labelCustomField,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomSelectBox(
        searchable: true,
        disabled: true,
        controller: source.selectCustomfield,
        hintText: BaseText.hiintSelect(
            field: ProspectCustomFieldText.labelCustomField),
        serverSide: (params) => selectApiCustomField(params),
        validators: [
          Validators.selectRequired(ProspectCustomFieldText.labelCustomField),
        ],
        onChange: (value) {
          source.format.value = value.getOtherValue().custftype.typename;
        },
      ),
    );
  }

  Widget inputValue() {
    return FormGroup(
      label: Text(ProspectCustomFieldText.labelValue,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black)),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputValue,
        inputFormatters: [
          if (source.format.value == 'Number' || source.format.value == 'Phone')
            FilteringTextInputFormatter.digitsOnly,
          if (source.format.value == 'Price' || source.format.value == 'Number')
            CurrencyTextInputFormatter(
              decimalDigits: 0,
              symbol: '',
            )
        ],
        hintText: BaseText.hintText(field: ProspectCustomFieldText.labelValue),
        validators: [
          Validators.inputRequired(ProspectCustomFieldText.labelValue),
          if (source.format.value == 'Email') Validators.inputEmail()
        ],
      ),
    );
  }

  Widget selectOpt() {
    return FormGroup(
      label: Obx(() => Text(ProspectCustomFieldText.labelOption,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomSelectBox(
        searchable: true,
        disabled: source.isProcessing,
        controller: source.selectOption,
        hintText:
            BaseText.hiintSelect(field: ProspectCustomFieldText.labelOption),
        validators: [
          Validators.selectRequired(ProspectCustomFieldText.labelOption),
        ],
      ),
    );
  }
}
