import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';

import '../../../constants/base_text.dart';
import '../../../models/session_model.dart';
import '../../../utils/select_api.dart';
import '../../../utils/session_manager.dart';
import '../../../utils/validators.dart';
import '../../../widgets/input/custom_input.dart';
import '../../../widgets/input/custom_input_number.dart';
import '../../../widgets/selectbox/custom_selectbox.dart';
import '../../../widgets/form_group.dart';

import '_text.dart';

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
      label: Text(TypeParentsText.labelName),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputName,
        hintText: BaseText.hintText(),
        validators: [
          Validators.inputRequired(TypeParentsText.labelName),
          Validators.maxLength(TypeParentsText.labelName, 100),
        ],
      ),
    );
  }

  Widget inputCode() {
    return FormGroup(
      label: Text(TypeParentsText.labelCode),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputCode,
        hintText: BaseText.hintText(),
      ),
    );
  }

  Widget inputSeq() {
    return FormGroup(
      label: Text(TypeParentsText.labelSeq),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputSeq,
        hintText: BaseText.hintText(),
        validators: [
          Validators.inputRequired(TypeParentsText.labelSeq),
          Validators.maxLength(TypeParentsText.labelSeq, 100),
        ],
      ),
    );
  }

  Widget inputDesc() {
    return FormGroup(
      label: Text(TypeParentsText.labelDesc),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputDesc,
        hintText: BaseText.hintText(),
        validators: [],
      ),
    );
  }
}
