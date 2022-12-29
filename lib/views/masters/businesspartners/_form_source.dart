import 'package:boilerplate/models/masters/bpquota_model.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../constants/base_text.dart';
import '../../../models/session_model.dart';
import '../../../presenters/masters/typechildren_presenter.dart';
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

  Rx<BpQuotaModel?> quota = Rx(null);

  BusinessPartnerTypeOptionsController businessPartnerTypeController = BusinessPartnerTypeOptionsController();

  TextEditingController inputCompanyName = TextEditingController();
  TextEditingController inputName = TextEditingController();
  TextEditingController inputEmail = TextEditingController();
  TextEditingController inputPhone = TextEditingController();

  TextEditingController inputUserWeb = TextEditingController(text: "100");
  TextEditingController inputUserMobile = TextEditingController(text: "100");
  TextEditingController inputCustomer = TextEditingController(text: "100");
  TextEditingController inputContact = TextEditingController(text: "100");
  TextEditingController inputProduct = TextEditingController(text: "100");
  TextEditingController inputProspect = TextEditingController(text: "100");
  TextEditingController inputDailyActivity = TextEditingController(text: "100");
  TextEditingController inputProspectActivity = TextEditingController(text: "100");

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
      'sbqwebuserquota': inputUserWeb.text,
      'sbqmobuserquota': inputUserMobile.text,
      'sbqcstmquota': inputCustomer.text,
      'sbqcntcquota': inputContact.text,
      'sbqprodquota': inputProduct.text,
      'sbqprosquota': inputProspect.text,
      'sbqdayactquota': inputDailyActivity.text,
      'sbqprosactquota': inputProspectActivity.text,
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

  Widget businessPartnerType(context) {
    return FormGroup(
      label: Obx(() => Text(BusinessPartnerText.labelType, style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomSelectBox(
          searchable: true,
          disabled: source.isProcessing,
          controller: source.selectType,
          hintText: BaseText.hiintSelect(field: BusinessPartnerText.labelType),
          serverSide: (params) => selectApiBpType(params),
          validators: [
            Validators.selectRequired(BusinessPartnerText.labelType),
          ],
          onChange: (val) async {
            final typePresenter = Get.find<TypesChildrenPresenter>();
            if (val.getValueAsString() == 'add') {
              SessionModel session = await SessionManager.current();
              typePresenter.save(context, {
                'typename': val.getOtherValue()['name'],
                'typemasterid': val.getOtherValue()['masterid'],
                'createdby': session.userid,
                'updatedby': session.userid,
                'isactive': true,
              });
            }
          }),
    );
  }

  Widget inputCompanyName() {
    return FormGroup(
      label: Obx(() => Text(BusinessPartnerText.labelCompany, style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black))),
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
      label: Obx(() => Text(BusinessPartnerText.labelName, style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black))),
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
      label: Obx(() => Text(BusinessPartnerText.labelEmail, style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black))),
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
      label: Obx(() => Text(BusinessPartnerText.labelPhone, style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black))),
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

  Widget inputUserWeb() {
    return FormGroup(
      label: Obx(() => Text("${BusinessPartnerText.labelUserWeb} (Currently used: ${source.quota.value?.sbqwebuserquotaused ?? 0})",
          style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputUserWeb,
        keyboardType: TextInputType.number,
        hintText: BaseText.hintText(field: BusinessPartnerText.labelUserWeb),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        validators: [
          Validators.inputRequired(BusinessPartnerText.labelUserMobile),
        ],
      ),
    );
  }

  Widget inputUserMobile() {
    return FormGroup(
      label: Obx(() => Text("${BusinessPartnerText.labelUserMobile} (Currently used: ${source.quota.value?.sbqmobuserquotaused ?? 0})",
          style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputUserMobile,
        keyboardType: TextInputType.number,
        hintText: BaseText.hintText(field: BusinessPartnerText.labelUserMobile),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        validators: [
          Validators.inputRequired(BusinessPartnerText.labelUserMobile),
        ],
      ),
    );
  }

  Widget inputCustomer() {
    return FormGroup(
      label: Obx(() => Text("${BusinessPartnerText.labelCustomer} (Currently used: ${source.quota.value?.sbqcstmquotaused ?? 0})",
          style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputCustomer,
        keyboardType: TextInputType.number,
        hintText: BaseText.hintText(field: BusinessPartnerText.labelCustomer),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        validators: [
          Validators.inputRequired(BusinessPartnerText.labelUserMobile),
        ],
      ),
    );
  }

  Widget inputContact() {
    return FormGroup(
      label: Obx(() => Text("${BusinessPartnerText.labelContact} (Currently used: ${source.quota.value?.sbqcntcquotaused ?? 0})",
          style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputContact,
        keyboardType: TextInputType.number,
        hintText: BaseText.hintText(field: BusinessPartnerText.labelContact),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        validators: [
          Validators.inputRequired(BusinessPartnerText.labelUserMobile),
        ],
      ),
    );
  }

  Widget inputProduct() {
    return FormGroup(
      label: Obx(() => Text("${BusinessPartnerText.labelProduct} (Currently used: ${source.quota.value?.sbqprodquotaused ?? 0})",
          style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputProduct,
        keyboardType: TextInputType.number,
        hintText: BaseText.hintText(field: BusinessPartnerText.labelProduct),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        validators: [
          Validators.inputRequired(BusinessPartnerText.labelUserMobile),
        ],
      ),
    );
  }

  Widget inputProspect() {
    return FormGroup(
      label: Obx(() => Text("${BusinessPartnerText.labelProspect} (Currently used: ${source.quota.value?.sbqprosquotaused ?? 0})",
          style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputProspect,
        keyboardType: TextInputType.number,
        hintText: BaseText.hintText(field: BusinessPartnerText.labelProspect),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        validators: [
          Validators.inputRequired(BusinessPartnerText.labelUserMobile),
        ],
      ),
    );
  }

  Widget inputDailyActivity() {
    return FormGroup(
      label: Obx(() => Text("${BusinessPartnerText.labelDailyActivity} (Currently used: ${source.quota.value?.sbqdayactquotaused ?? 0})",
          style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputDailyActivity,
        hintText: BaseText.hintText(field: BusinessPartnerText.labelDailyActivity),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        validators: [
          Validators.inputRequired(BusinessPartnerText.labelUserMobile),
        ],
      ),
    );
  }

  Widget inputProspectActivity() {
    return FormGroup(
      label: Obx(() => Text("${BusinessPartnerText.labelProspectActivity} (Currently used: ${source.quota.value?.sbqprosactquotaused ?? 0})",
          style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputProspectActivity,
        keyboardType: TextInputType.number,
        hintText: BaseText.hintText(field: BusinessPartnerText.labelProspectActivity),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        validators: [
          Validators.inputRequired(BusinessPartnerText.labelUserMobile),
        ],
      ),
    );
  }
}
