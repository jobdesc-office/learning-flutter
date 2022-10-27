import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/base_text.dart';
import '../../../../models/session_model.dart';
import '../../../../presenters/navigation_presenter.dart';
import '../../../../utils/session_manager.dart';
import '../../../../utils/validators.dart';
import '../../../../widgets/form_group.dart';
import '../../../../widgets/input/custom_input_currency.dart';
import '_text.dart';

final _navigation = Get.find<NavigationPresenter>();

class ProspectChangeValueSource extends GetxController {
  bool isProcessing = false;

  var selectedDateExpect = ''.obs;
  var id = 0.obs;

  TextEditingController inputValue = TextEditingController();

  Future<Map<String, dynamic>> toJson() async {
    SessionModel session = await SessionManager.current();
    // StbptypeModel stage = await _prospectPresenter.completePipeline();

    return {
      'prospectvalue': inputValue.text.replaceAll(',', ''),
      'createdby': session.userid,
      'updatedby': session.userid,
    };
  }
}

class ProspectLostForm {
  final ProspectChangeValueSource source;

  ProspectLostForm(this.source);

  Widget inputValue() {
    return FormGroup(
      label: Text(ProspectChangeValueText.labelValue,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black)),
      child: CustomInputCurrency(
        autofocus: true,
        disabled: source.isProcessing,
        controller: source.inputValue,
        hintText: BaseText.hintText(field: ProspectChangeValueText.labelValue),
        validators: [
          Validators.inputRequired(ProspectChangeValueText.labelValue)
        ],
      ),
    );
  }
}
