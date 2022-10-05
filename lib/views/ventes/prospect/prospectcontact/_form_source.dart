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
import '../../../../widgets/form_group.dart';
import '../../../../widgets/input/custom_input.dart';
import '../../../../widgets/selectbox/custom_selectbox.dart';
import '_text.dart';

final _navigation = Get.find<NavigationPresenter>();

class ProspectContactSource {
  bool isProcessing = false;
  var id = 0.obs;

  var format = ''.obs;

  TextEditingController inputName = TextEditingController();
  TextEditingController inputValue = TextEditingController();

  BsSelectBoxController selectType = BsSelectBoxController();

  Future<Map<String, dynamic>> toJson() async {
    SessionModel session = await SessionManager.current();
    return {
      'contactname': inputName.text,
      'contactbpcustomerid': id.value,
      'contacttypeid': selectType.getSelectedAsString(),
      'contactvalueid': inputValue.text,
      'createdby': session.userid,
      'updatedby': session.userid,
    };
  }
}

class ProspectContactForm {
  final ProspectContactSource source;

  ProspectContactForm(this.source);

  Widget inputName() {
    return FormGroup(
      label: Obx(() => Text(ProspectContactText.labelName,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputName,
        hintText: BaseText.hintText(field: ProspectContactText.labelName),
        validators: [
          Validators.inputRequired(ProspectContactText.labelName),
          Validators.maxLength(ProspectContactText.labelName, 255)
        ],
      ),
    );
  }

  Widget selectType() {
    return FormGroup(
      label: Obx(() => Text(ProspectContactText.labelType,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: Obx(() => CustomSelectBox(
            searchable: false,
            disabled: source.isProcessing,
            controller: source.selectType,
            hintText:
                BaseText.hiintSelect(field: ProspectContactText.labelType),
            serverSide: (params) => selectApiContactTypes(params),
            validators: [
              Validators.selectRequired(ProspectContactText.labelType),
            ],
            onChange: (value) {
              source.format.value = value.getOtherValue()['typename'];
            },
          )),
    );
  }

  Widget inputValue() {
    return FormGroup(
      label: Obx(() => Text(ProspectContactText.labelValue,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: Obx(() => CustomInput(
            minLines: 3,
            maxLines: 5,
            disabled: source.isProcessing,
            controller: source.inputValue,
            hintText: BaseText.hintText(field: ProspectContactText.labelValue),
            inputFormatters: [
              if (source.format.value == 'Phone')
                FilteringTextInputFormatter.digitsOnly,
            ],
            validators: [
              if (source.format.value == 'Email') Validators.inputEmail()
            ],
          )),
    );
  }
}
