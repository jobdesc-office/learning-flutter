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

class SubdistrictSource {
  bool isProcessing = false;

  TextEditingController inputName = TextEditingController();

  BsSelectBoxController choosedCity = BsSelectBoxController();

  Future<Map<String, dynamic>> toJson() async {
    SessionModel session = await SessionManager.current();
    return {
      'subdistrictcityid': choosedCity.getSelectedAsString(),
      'subdistrictname': inputName.text,
      'createdby': session.userid,
      'updatedby': session.userid,
    };
  }
}

class SubdistrictForm {
  final SubdistrictSource source;

  SubdistrictForm(this.source);

  Widget inputName() {
    return FormGroup(
      label: Obx(() => Text(SubdistrictText.labelName,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputName,
        hintText: BaseText.hintText(),
        validators: [
          Validators.inputRequired(SubdistrictText.labelName),
          Validators.maxLength(SubdistrictText.labelName, 100),
        ],
      ),
    );
  }

  Widget selectCity() {
    return FormGroup(
      label: Obx(() => Text(SubdistrictText.labelCity,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomSelectBox(
        searchable: true,
        disabled: source.isProcessing,
        controller: source.choosedCity,
        hintText: BaseText.hiintSelect(),
        serverSide: (params) => selectCities(params),
      ),
    );
  }
}
