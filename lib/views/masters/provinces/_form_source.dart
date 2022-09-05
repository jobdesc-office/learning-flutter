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

class ProvinceSource {
  bool isProcessing = false;

  var createdby = ''.obs;
  var createddate = ''.obs;
  var updatedby = ''.obs;
  var updateddate = ''.obs;
  var isactive = true.obs;

  TextEditingController inputName = TextEditingController();

  BsSelectBoxController selectCountry = BsSelectBoxController();

  Future<Map<String, dynamic>> toJson() async {
    SessionModel session = await SessionManager.current();
    return {
      'provcountryid': selectCountry.getSelectedAsString(),
      'provname': inputName.text,
      'createdby': session.userid,
      'updatedby': session.userid,
      'isactive': isactive.value,
    };
  }
}

class ProvinceForm {
  final ProvinceSource source;

  ProvinceForm(this.source);

  Widget inputName() {
    return FormGroup(
      label: Obx(() => Text(ProvinceText.labelName,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputName,
        hintText: BaseText.hintText(field: ProvinceText.labelName),
        validators: [
          Validators.inputRequired(ProvinceText.labelName),
          Validators.maxLength(ProvinceText.labelName, 150),
        ],
      ),
    );
  }

  Widget selectCountry() {
    return FormGroup(
      label: Obx(() => Text(ProvinceText.labelCountry,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomSelectBox(
        searchable: true,
        disabled: source.isProcessing,
        controller: source.selectCountry,
        hintText: BaseText.hiintSelect(field: ProvinceText.labelCountry),
        serverSide: (params) => selectCountries(params),
        validators: [
          Validators.selectRequired(ProvinceText.labelCountry),
        ],
      ),
    );
  }
}
