import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/base_text.dart';
import '../../../models/session_model.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../utils/select_api.dart';
import '../../../utils/session_manager.dart';
import '../../../utils/validators.dart';
import '../../../widgets/form_group.dart';
import '../../../widgets/input/custom_input.dart';
import '../../../widgets/selectbox/custom_selectbox.dart';
import '_businesspartner_type.dart';
import '_text.dart';

final _navigation = Get.find<NavigationPresenter>();

class BusinessPartnerSource {
  bool isProcessing = false;

  var createdby = ''.obs;
  var createddate = ''.obs;
  var updatedby = ''.obs;
  var updateddate = ''.obs;
  var isactive = true.obs;

  BusinessPartnerTypeOptionsController businessPartnerTypeController =
      BusinessPartnerTypeOptionsController();

  TextEditingController inputCompanyName = TextEditingController();
  TextEditingController inputName = TextEditingController();
  TextEditingController inputEmail = TextEditingController();
  TextEditingController inputPhone = TextEditingController();

  BsSelectBoxController selectType = BsSelectBoxController();

  Future<Map<String, dynamic>> toJson() async {
    SessionModel session = await SessionManager.current();
    return {
      'bptypeid': selectType.getSelectedAsString(),
      'bpname': inputCompanyName.text,
      'bppicname': inputName.text,
      'bpemail': inputEmail.text,
      'bpphone': inputPhone.text,
      'createdby': session.userid,
      'updatedby': session.userid,
      'isactive': isactive.value,
    };
  }
}

class BusinessPartnerForm {
  final BusinessPartnerSource source;

  BusinessPartnerForm(this.source);

  // Widget businessPartnerType() {
  //   return FormGroup(
  //     label: Obx(() => Text(BusinessPartnerText.labelType,
  //         style: TextStyle(
  //             color:
  //                 _navigation.darkTheme.value ? Colors.white : Colors.black))),
  //     child: BusinessPartnerTypeOptions(
  //       controller: source.businessPartnerTypeController,
  //     ),
  //   );
  // }

  Widget businessPartnerType() {
    return FormGroup(
      label: Obx(() => Text(BusinessPartnerText.labelType,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomSelectBox(
        searchable: false,
        disabled: source.isProcessing,
        controller: source.selectType,
        hintText: BaseText.hiintSelect(field: BusinessPartnerText.labelType),
        serverSide: (params) => selectApiBpType(params),
        validators: [
          Validators.selectRequired(BusinessPartnerText.labelType),
        ],
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
          Validators.inputRequired(BusinessPartnerText.labelCompany),
          Validators.maxLength(BusinessPartnerText.labelCompany, 100),
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
          Validators.maxLength(BusinessPartnerText.labelName, 255),
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
          Validators.maxLength(BusinessPartnerText.labelEmail, 255),
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
          Validators.maxLength(BusinessPartnerText.labelPhone, 20),
        ],
      ),
    );
  }
}
