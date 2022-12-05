import 'package:boilerplate/models/masters/security_group_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../constants/base_text.dart';
import '../../../models/session_model.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../utils/session_manager.dart';
import '../../../utils/validators.dart';
import '../../../widgets/input/custom_input.dart';
import '../../../widgets/form_group.dart';

import '_text.dart';

final _navigation = Get.find<NavigationPresenter>();

class SecurityGroupSource {
  bool isProcessing = false;

  SecurityGroupModel? parent;

  var createdby = ''.obs;
  var createddate = ''.obs;
  var updatedby = ''.obs;
  var updateddate = ''.obs;
  var isactive = true.obs;

  TextEditingController inputName = TextEditingController();
  TextEditingController inputCode = TextEditingController();
  Future<Map<String, dynamic>> toJson() async {
    SessionModel session = await SessionManager.current();
    return {
      'sgname': inputName.text,
      'sgcode': inputCode.text,
      'sgbpid': GetStorage().read('mybpid'),
      'sgmasterid': parent?.sgid,
      'createdby': session.userid,
      'updatedby': session.userid,
      'isactive': isactive.value,
    };
  }
}

class SecurityGroupForm {
  final SecurityGroupSource source;

  SecurityGroupForm(this.source);

  Widget inputName() {
    return FormGroup(
      label: Obx(() => Text(SecurityGroupsText.labelName, style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputName,
        hintText: BaseText.hintText(field: SecurityGroupsText.labelName),
        validators: [
          Validators.inputRequired(SecurityGroupsText.labelName),
          Validators.maxLength(SecurityGroupsText.labelName, 100),
        ],
      ),
    );
  }

  Widget inputCode() {
    return FormGroup(
      label: Obx(() => Text(SecurityGroupsText.labelCode, style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputCode,
        hintText: BaseText.hintText(field: SecurityGroupsText.labelCode),
        validators: [
          Validators.maxLength(SecurityGroupsText.labelCode, 10),
        ],
      ),
    );
  }

  Widget inputParent() {
    return source.parent != null
        ? FormGroup(
            label: Obx(() => Text(SecurityGroupsText.labelParent, style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black))),
            child: CustomInput(
              disabled: true,
              controller: TextEditingController(text: this.source.parent?.sgname),
              hintText: BaseText.hintText(field: SecurityGroupsText.labelParent),
            ),
          )
        : Container();
  }
}
