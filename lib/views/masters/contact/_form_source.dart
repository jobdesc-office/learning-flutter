import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/base_text.dart';
import '../../../models/session_model.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../utils/session_manager.dart';
import '../../../utils/select_api.dart';
import '../../../utils/validators.dart';
import '../../../widgets/input/custom_input.dart';
import '../../../widgets/selectbox/custom_selectbox.dart';
import '../../../widgets/form_group.dart';

import '_text.dart';

final _navigation = Get.find<NavigationPresenter>();

class ContactSource {
  bool isProcessing = false;

  var createdby = ''.obs;
  var createddate = ''.obs;
  var updatedby = ''.obs;
  var updateddate = ''.obs;
  var isactive = true.obs;

  TextEditingController inputName = TextEditingController();
  TextEditingController inputValue = TextEditingController();

  BsSelectBoxController selectCustomer = BsSelectBoxController();
  BsSelectBoxController selectType = BsSelectBoxController();

  Future<Map<String, dynamic>> toJson() async {
    SessionModel session = await SessionManager.current();
    return {
      'contactname': inputName.text,
      'contactcustomerid': selectCustomer.getSelectedAsString(),
      'contacttypeid': selectType.getSelectedAsString(),
      'contactvalueid': inputValue.text,
      'createdby': session.userid,
      'updatedby': session.userid,
      'isactive': isactive.value,
    };
  }
}

class ContactForm {
  final ContactSource source;

  ContactForm(this.source);

  Widget inputName() {
    return FormGroup(
      label: Obx(() => Text(ContactText.labelName,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputName,
        hintText: BaseText.hintText(field: ContactText.labelName),
        validators: [
          Validators.inputRequired(ContactText.labelName),
          Validators.maxLength(ContactText.labelName, 255)
        ],
      ),
    );
  }

  Widget selectCustomer() {
    return FormGroup(
      label: Obx(() => Text(ContactText.labelCustomer,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomSelectBox(
        searchable: true,
        disabled: source.isProcessing,
        controller: source.selectCustomer,
        hintText: BaseText.hiintSelect(field: ContactText.labelCustomer),
        serverSide: (params) => selectApiCustomer(params),
        validators: [
          Validators.selectRequired(ContactText.labelCustomer),
        ],
      ),
    );
  }

  Widget selectType() {
    return FormGroup(
      label: Obx(() => Text(ContactText.labelType,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomSelectBox(
        searchable: false,
        disabled: source.isProcessing,
        controller: source.selectType,
        hintText: BaseText.hiintSelect(field: ContactText.labelType),
        serverSide: (params) => selectApiContactTypes(params),
        validators: [
          Validators.selectRequired(ContactText.labelType),
        ],
      ),
    );
  }

  Widget inputValue() {
    return FormGroup(
      label: Obx(() => Text(ContactText.labelValue,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        minLines: 3,
        maxLines: 5,
        disabled: source.isProcessing,
        controller: source.inputValue,
        hintText: BaseText.hintText(field: ContactText.labelValue),
      ),
    );
  }
}
