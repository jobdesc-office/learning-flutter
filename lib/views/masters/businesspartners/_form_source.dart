import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/base_text.dart';
import '../../../models/session_model.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../utils/session_manager.dart';
import '../../../utils/validators.dart';
import '../../../widgets/form_group.dart';
import '../../../widgets/input/custom_input.dart';
import '_businesspartner_type.dart';
import '_text.dart';

final _navigation = Get.find<NavigationPresenter>();

class BusinessPartnerSource {
  bool isProcessing = false;

  BusinessPartnerTypeOptionsController businessPartnerTypeController =
      BusinessPartnerTypeOptionsController();

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
      label: Obx(() => Text(BusinessPartnerText.labelType,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: BusinessPartnerTypeOptions(
        controller: source.businessPartnerTypeController,
      ),
    );
  }

  Widget inputCompanyName() {
    return FormGroup(
      label: Obx(() => Text(BusinessPartnerText.labelCompany,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputCompanyName,
        hintText: BaseText.hintText(field: BusinessPartnerText.labelCompany),
        validators: [
          Validators.inputRequired(BusinessPartnerText.labelName),
        ],
      ),
    );
  }

  Widget inputName() {
    return FormGroup(
      label: Obx(() => Text(BusinessPartnerText.labelName,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputName,
        hintText: BaseText.hintText(field: BusinessPartnerText.labelName),
        validators: [
          Validators.maxLength(BusinessPartnerText.labelName, 100),
        ],
      ),
    );
  }

  Widget inputEmail() {
    return FormGroup(
      label: Obx(() => Text(BusinessPartnerText.labelEmail,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputEmail,
        hintText: BaseText.hintText(field: BusinessPartnerText.labelEmail),
        validators: [
          Validators.inputEmail(),
        ],
      ),
    );
  }

  Widget inputPhone() {
    return FormGroup(
      label: Obx(() => Text(BusinessPartnerText.labelPhone,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputPhone,
        hintText: BaseText.hintText(field: BusinessPartnerText.labelPhone),
        validators: [
          Validators.maxLength(BusinessPartnerText.labelPhone, 100),
        ],
      ),
    );
  }
}
