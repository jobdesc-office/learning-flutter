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

class CitySource {
  bool isProcessing = false;

  TextEditingController inputName = TextEditingController();

  BsSelectBoxController selectProvince = BsSelectBoxController();

  Future<Map<String, dynamic>> toJson() async {
    SessionModel session = await SessionManager.current();
    return {
      'cityprovid': selectProvince.getSelectedAsString(),
      'cityname': inputName.text,
      'createdby': session.userid,
      'updatedby': session.userid,
    };
  }
}

class CityForm {
  final CitySource source;

  CityForm(this.source);

  Widget inputName() {
    return FormGroup(
      label: Obx(() => Text(CityText.labelName,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputName,
        hintText: BaseText.hintText(field: CityText.labelName),
        validators: [
          Validators.inputRequired(CityText.labelName),
          Validators.maxLength(CityText.labelName, 150),
        ],
      ),
    );
  }

  Widget selectProvince() {
    return FormGroup(
      label: Obx(() => Text(CityText.labelProvince,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomSelectBox(
        searchable: true,
        disabled: source.isProcessing,
        controller: source.selectProvince,
        hintText: BaseText.hiintSelect(field: CityText.labelProvince),
        serverSide: (params) => selectProvinces(params),
        validators: [
          Validators.selectRequired(CityText.labelProvince),
        ],
      ),
    );
  }
}
