import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';

import '../../../constants/base_text.dart';
import '../../../models/session_model.dart';
import '../../../utils/session_manager.dart';
import '../../../utils/validators.dart';
import '../../../widgets/input/custom_input.dart';
import '../../../widgets/form_group.dart';
import '../../../utils/select_api.dart';
import '../../../widgets/selectbox/custom_selectbox.dart';
import '_text.dart';

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
      'typedesc': inputDesc.text,
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
      label: Text(TypeChildrenText.labelName),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputName,
        hintText: BaseText.hintText(),
        validators: [
          Validators.inputRequired(TypeChildrenText.labelName),
          Validators.maxLength(TypeChildrenText.labelName, 100),
        ],
      ),
    );
  }

  Widget inputCode() {
    return FormGroup(
      label: Text(TypeChildrenText.labelCode),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputCode,
        hintText: BaseText.hintText(),
      ),
    );
  }

  Widget selectParent() {
    return FormGroup(
      label: Text(TypeChildrenText.labelParent),
      child: CustomSelectBox(
        searchable: true,
        disabled: source.isProcessing,
        controller: source.selectParent,
        hintText: BaseText.hiintSelect(),
        serverSide: (params) => selectApiTypeParents(params),
      ),
    );
  }

  Widget inputSeq() {
    return FormGroup(
      label: Text(TypeChildrenText.labelSeq),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputSeq,
        hintText: BaseText.hintText(),
        validators: [
          Validators.inputRequired(TypeChildrenText.labelSeq),
          Validators.maxLength(TypeChildrenText.labelSeq, 100),
        ],
      ),
    );
  }

  Widget inputDesc() {
    return FormGroup(
      label: Text(TypeChildrenText.labelDesc),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputDesc,
        hintText: BaseText.hintText(),
        validators: [],
      ),
    );
  }
}
