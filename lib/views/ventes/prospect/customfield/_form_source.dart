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
import '_text.dart';

final _navigation = Get.find<NavigationPresenter>();

class ProspectCustomFieldSource extends GetxController {
  bool isProcessing = false;

  var selectedDateExpect = ''.obs;
  var id = 0.obs;

  BsSelectBoxController selectAssign = BsSelectBoxController();
  BsSelectBoxController selectReport = BsSelectBoxController();

  TextEditingController inputDesc = TextEditingController();

  Future<Map<String, dynamic>> toJson() async {
    SessionModel session = await SessionManager.current();
    return {
      'prospectid': id.value,
      'ProspectCustomFieldto': selectAssign.getSelectedAsString(),
      'prospectreportto': selectReport.getSelectedAsString(),
      'ProspectCustomFielddesc': inputDesc.text,
      'createdby': session.userid,
      'updatedby': session.userid,
    };
  }
}

class ProspectCustomFieldForm {
  final ProspectCustomFieldSource source;

  ProspectCustomFieldForm(this.source);

  Widget selectAssign() {
    return FormGroup(
      label: Obx(() => Text(ProspectCustomFieldText.labelType,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomSelectBox(
        searchable: false,
        disabled: source.isProcessing,
        controller: source.selectAssign,
        hintText:
            BaseText.hiintSelect(field: ProspectCustomFieldText.labelType),
        serverSide: (params) => selectApiProspectOwner(params),
        validators: [
          Validators.selectRequired(ProspectCustomFieldText.labelType),
        ],
      ),
    );
  }

  Widget selectReport() {
    return FormGroup(
      label: Obx(() => Text(ProspectCustomFieldText.labelCategory,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomSelectBox(
        searchable: true,
        disabled: source.isProcessing,
        controller: source.selectReport,
        hintText:
            BaseText.hiintSelect(field: ProspectCustomFieldText.labelCategory),
        serverSide: (params) => selectApiProspectOwner(params),
        validators: [
          Validators.selectRequired(ProspectCustomFieldText.labelCategory),
        ],
      ),
    );
  }

  Widget inputDesc() {
    return FormGroup(
      label: Text(ProspectCustomFieldText.labelDesc),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputDesc,
        hintText: BaseText.hintText(field: ProspectCustomFieldText.labelDesc),
        maxLines: 5,
        minLines: 3,
      ),
    );
  }
}
