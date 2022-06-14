import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/base_text.dart';
import '../../../models/session_model.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../utils/session_manager.dart';
import '../../../utils/validators.dart';
import '../../../widgets/input/custom_input.dart';
import '../../../widgets/form_group.dart';
import '../../../utils/select_api.dart';
import '../../../widgets/selectbox/custom_selectbox.dart';
import '_text.dart';

final _navigation = Get.find<NavigationPresenter>();

class TypeChildrenSource {
  bool isProcessing = false;

  TextEditingController inputName = TextEditingController();
  TextEditingController inputCode = TextEditingController();
  TextEditingController inputSeq = TextEditingController();
  TextEditingController inputDesc = TextEditingController();

  BsSelectBoxController selectParent = BsSelectBoxController();

  Future<Map<String, dynamic>> toJson() async {
    SessionModel session = await SessionManager.current();
    return {
      'typename': inputName.text,
      'typeseq': inputSeq.text,
      'typecd': inputCode.text,
      'typedesc': inputDesc.text,
      'typemasterid': selectParent.getSelectedAsString(),
      'createdby': session.userid,
      'updatedby': session.userid,
      'isactive': true,
    };
  }
}

class TypeChildrenForm {
  final TypeChildrenSource source;

  TypeChildrenForm(this.source);

  Widget inputName() {
    return FormGroup(
      label: Obx(() => Text(TypeChildrenText.labelName,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputName,
        hintText: BaseText.hintText(field: TypeChildrenText.labelName),
        validators: [
          Validators.inputRequired(TypeChildrenText.labelName),
          Validators.maxLength(TypeChildrenText.labelName, 100),
        ],
      ),
    );
  }

  Widget inputCode() {
    return FormGroup(
      label: Obx(() => Text(TypeChildrenText.labelCode,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputCode,
        hintText: BaseText.hintText(field: TypeChildrenText.labelCode),
        validators: [
          Validators.maxLength(TypeChildrenText.labelCode, 10),
        ],
      ),
    );
  }

  Widget selectParent() {
    return FormGroup(
      label: Obx(() => Text(TypeChildrenText.labelParent,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomSelectBox(
        searchable: true,
        disabled: source.isProcessing,
        controller: source.selectParent,
        hintText: BaseText.hiintSelect(field: TypeChildrenText.labelParent),
        serverSide: (params) => selectApiTypeParents(params),
        validators: [
          Validators.selectRequired(TypeChildrenText.labelParent),
        ],
      ),
    );
  }

  Widget inputSeq() {
    return FormGroup(
      label: Obx(() => Text(TypeChildrenText.labelSeq,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputSeq,
        hintText: BaseText.hintText(field: TypeChildrenText.labelSeq),
      ),
    );
  }

  Widget inputDesc() {
    return FormGroup(
      label: Obx(() => Text(TypeChildrenText.labelDesc,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputDesc,
        hintText: BaseText.hintText(field: TypeChildrenText.labelDesc),
      ),
    );
  }
}
