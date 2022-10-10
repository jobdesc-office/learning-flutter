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

class InformationSource {
  bool isProcessing = false;

  var createdby = ''.obs;
  var createddate = ''.obs;
  var updatedby = ''.obs;
  var updateddate = ''.obs;
  var isactive = true.obs;

  TextEditingController inputName = TextEditingController();
  TextEditingController inputDesc = TextEditingController();

  BsSelectBoxController selectProvince = BsSelectBoxController();

  Future<Map<String, dynamic>> toJson() async {
    SessionModel session = await SessionManager.current();
    return {
      'infoname': inputName.text,
      'infodesc': inputDesc.text,
      'createdby': session.userid,
      'updatedby': session.userid,
      'isactive': isactive.value,
    };
  }
}

class InformationForm {
  final InformationSource source;

  InformationForm(this.source);

  Widget inputName() {
    return FormGroup(
      label: Obx(() => Text(InformationText.labelName,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: true,
        controller: source.inputName,
        hintText: BaseText.hintText(field: InformationText.labelName),
        validators: [
          Validators.inputRequired(InformationText.labelName),
          Validators.maxLength(InformationText.labelName, 150),
        ],
      ),
    );
  }

  Widget inputDesc() {
    return FormGroup(
      label: Obx(() => Text(InformationText.labelDesc,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputDesc,
        hintText: BaseText.hintText(field: InformationText.labelDesc),
        validators: [
          Validators.inputRequired(InformationText.labelDesc),
        ],
        maxLines: 20,
      ),
    );
  }
}
