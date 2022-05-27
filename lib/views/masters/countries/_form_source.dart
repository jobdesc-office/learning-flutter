import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/base_text.dart';
import '../../../models/session_model.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../utils/session_manager.dart';
import '../../../utils/validators.dart';
import '../../../widgets/input/custom_input.dart';
import '../../../widgets/input/custom_input_number.dart';
import '../../../widgets/selectbox/custom_selectbox.dart';
import '../../../widgets/form_group.dart';

import '_text.dart';

final _navigation = Get.find<NavigationPresenter>();

class CountrySource {
  bool isProcessing = false;

  TextEditingController inputName = TextEditingController();

  Future<Map<String, dynamic>> toJson() async {
    SessionModel session = await SessionManager.current();
    return {
      'countryname': inputName.text,
      'createdby': session.userid,
      'updatedby': session.userid,
    };
  }
}

class CountryForm {
  final CountrySource source;

  CountryForm(this.source);

  Widget inputName() {
    return FormGroup(
      label: Obx(() => Text(CountryText.labelName,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputName,
        hintText: BaseText.hintText(field: CountryText.labelName),
        validators: [
          Validators.inputRequired(CountryText.labelName),
          Validators.maxLength(CountryText.labelName, 100),
        ],
      ),
    );
  }
}
