import 'package:boilerplate/views/masters/users/_text.dart';
import 'package:bs_flutter_inputtext/bs_flutter_inputtext.dart';
import 'package:flutter/material.dart';

import '../../../constants/base_text.dart';
import '../../../models/session_model.dart';
import '../../../utils/session_manager.dart';
import '../../../utils/validators.dart';
import '../../../widgets/form_group.dart';
import '../../../widgets/input/custom_input.dart';
import '_businesspartner_type.dart';
import '_text.dart';

class BusinessPartnerSource{bool isProcessing = false;

  BusinessPartnerTypeOptionsController businessPartnerTypeController = BusinessPartnerTypeOptionsController();

  TextEditingController inputCompanyName = TextEditingController();
  TextEditingController inputName = TextEditingController();
  TextEditingController inputEmail = TextEditingController();
  TextEditingController inputPhone = TextEditingController();


  Future<Map<String, dynamic>> toJson() async {
    SessionModel session = await SessionManager.current();
    return {
      'bptypeid': businessPartnerTypeController.getSelectedToString(),
      'bpname': inputCompanyName.text,
      'bppicname': inputName.text,
      'bpemail': inputEmail.text,
      'bpphone': inputPhone.text,
      'createdby': session.userid,
      'updatedby': session.userid,
      'isactive': true,
    };
  }
}

class BusinessPartnerForm {
  final BusinessPartnerSource source;

  BusinessPartnerForm(this.source);


  Widget businessPartnerType() {
    return FormGroup(
      label: Text(BusinessPartnerText.labelType),
      child: BusinessPartnerTypeOptions(
        controller: source.businessPartnerTypeController,
      ),
    );
  }

  Widget inputCompanyName() {
    return FormGroup(
      label: Text(BusinessPartnerText.labelCompany),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputCompanyName,
        hintText: BaseText.hintText(),
        validators: [
          Validators.inputRequired(BusinessPartnerText.labelName),
        ],
      ),
    );
  }

  Widget inputName() {
    return FormGroup(
      label: Text(BusinessPartnerText.labelName),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputName,
        hintText: BaseText.hintText(),
        validators: [
          Validators.maxLength(BusinessPartnerText.labelName, 100),
        ],
      ),
    );
  }

  Widget inputEmail() {
    return FormGroup(
      label: Text(BusinessPartnerText.labelEmail),
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

  Widget inputPhone() {
    return FormGroup(
      label: Text(BusinessPartnerText.labelPhone),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputPhone,
        hintText: BaseText.hintText(),
        validators: [
          Validators.maxLength(BusinessPartnerText.labelPhone, 100),
        ],
      ),
    );
  }
}
