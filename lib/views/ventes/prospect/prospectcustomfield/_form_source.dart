import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/base_text.dart';
import '../../../../models/session_model.dart';
import '../../../../presenters/navigation_presenter.dart';
import '../../../../styles/color_palattes.dart';
import '../../../../utils/select_api.dart';
import '../../../../utils/session_manager.dart';
import '../../../../utils/validators.dart';
import '../../../../widgets/form_group.dart';
import '../../../../widgets/input/custom_input.dart';
import '../../../../widgets/selectbox/custom_selectbox.dart';
import '../_detail_source.dart';
import '_text.dart';

final _navigation = Get.find<NavigationPresenter>();
final source = Get.put(prospectDetailsSource());

class ProspectCustomFieldSource extends GetxController {
  bool isProcessing = false;

  BsSelectBoxController selectCustomfield = BsSelectBoxController();

  TextEditingController inputValue = TextEditingController();

  Future<Map<String, dynamic>> toJson() async {
    SessionModel session = await SessionManager.current();
    return {
      'prospectid': source.prospectid.value,
      'prospectcustfid': selectCustomfield.getSelectedAsString(),
      'prospectcfvalue': inputValue.text,
      'createdby': session.userid,
      'updatedby': session.userid,
    };
  }
}

class ProspectCustomFieldForm {
  final ProspectCustomFieldSource source;

  ProspectCustomFieldForm(this.source);

  Widget selectCf() {
    return FormGroup(
      label: Obx(() => Text(ProspectCustomFieldText.labelCustomField,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomSelectBox(
        searchable: true,
        disabled: source.isProcessing,
        controller: source.selectCustomfield,
        hintText: BaseText.hiintSelect(
            field: ProspectCustomFieldText.labelCustomField),
        serverSide: (params) => selectApiCustomField(params),
        validators: [
          Validators.selectRequired(ProspectCustomFieldText.labelCustomField),
        ],
      ),
    );
  }

  Widget inputValue() {
    return FormGroup(
      label: Text(ProspectCustomFieldText.labelValue,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black)),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputValue,
        hintText: BaseText.hintText(field: ProspectCustomFieldText.labelValue),
        validators: [
          Validators.inputRequired(ProspectCustomFieldText.labelValue)
        ],
      ),
    );
  }
}
