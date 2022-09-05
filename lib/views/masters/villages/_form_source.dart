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

class VillageSource {
  bool isProcessing = false;

  var createdby = ''.obs;
  var createddate = ''.obs;
  var updatedby = ''.obs;
  var updateddate = ''.obs;
  var isactive = true.obs;

  TextEditingController inputName = TextEditingController();

  BsSelectBoxController choosedSubdistrict = BsSelectBoxController();

  Future<Map<String, dynamic>> toJson() async {
    SessionModel session = await SessionManager.current();
    return {
      'villagesubdistrictid': choosedSubdistrict.getSelectedAsString(),
      'villagename': inputName.text,
      'createdby': session.userid,
      'updatedby': session.userid,
      'isactive': isactive.value,
    };
  }
}

class VillageForm {
  final VillageSource source;

  VillageForm(this.source);

  Widget inputName() {
    return FormGroup(
      label: Obx(() => Text(VillageText.labelName,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputName,
        hintText: BaseText.hintText(field: VillageText.labelName),
        validators: [
          Validators.inputRequired(VillageText.labelName),
          Validators.maxLength(VillageText.labelName, 150),
        ],
      ),
    );
  }

  Widget selectSubdistrict() {
    return FormGroup(
      label: Obx(() => Text(VillageText.labelSubdistrict,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomSelectBox(
        searchable: true,
        disabled: source.isProcessing,
        controller: source.choosedSubdistrict,
        hintText: BaseText.hiintSelect(field: VillageText.labelSubdistrict),
        serverSide: (params) => selectSubdistricts(params),
        validators: [
          Validators.selectRequired(VillageText.labelSubdistrict),
        ],
      ),
    );
  }
}
