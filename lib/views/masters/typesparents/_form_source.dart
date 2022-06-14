import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/base_text.dart';
import '../../../models/session_model.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../utils/session_manager.dart';
import '../../../utils/validators.dart';
import '../../../widgets/input/custom_input.dart';
import '../../../widgets/form_group.dart';

import '_text.dart';

final _navigation = Get.find<NavigationPresenter>();

class TypeParentSource {
  bool isProcessing = false;

  TextEditingController inputName = TextEditingController();
  TextEditingController inputCode = TextEditingController();
  TextEditingController inputSeq = TextEditingController();
  TextEditingController inputDesc = TextEditingController();
  Future<Map<String, dynamic>> toJson() async {
    SessionModel session = await SessionManager.current();
    return {
      'typename': inputName.text,
      'typecd': inputCode.text,
      'typeseq': inputSeq.text,
      'typedesc': inputDesc.text,
      'createdby': session.userid,
      'updatedby': session.userid,
      'isactive': true,
    };
  }
}

class TypeParentForm {
  final TypeParentSource source;

  TypeParentForm(this.source);

  Widget inputName() {
    return FormGroup(
      label: Obx(() => Text(TypeParentsText.labelName,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputName,
        hintText: BaseText.hintText(field: TypeParentsText.labelName),
        validators: [
          Validators.inputRequired(TypeParentsText.labelName),
          Validators.maxLength(TypeParentsText.labelName, 100),
        ],
      ),
    );
  }

  Widget inputCode() {
    return FormGroup(
      label: Obx(() => Text(TypeParentsText.labelCode,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputCode,
        hintText: BaseText.hintText(field: TypeParentsText.labelCode),
        validators: [
          Validators.maxLength(TypeParentsText.labelCode, 10),
        ],
      ),
    );
  }

  Widget inputSeq() {
    return FormGroup(
      label: Obx(() => Text(TypeParentsText.labelSeq,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputSeq,
        hintText: BaseText.hintText(field: TypeParentsText.labelSeq),
      ),
    );
  }

  Widget inputDesc() {
    return FormGroup(
      label: Obx(() => Text(TypeParentsText.labelDesc,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputDesc,
        hintText: BaseText.hintText(field: TypeParentsText.labelDesc),
      ),
    );
  }
}
