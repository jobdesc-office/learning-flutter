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

class ProspectAssignSource extends GetxController {
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
      'prospectassignto': selectAssign.getSelectedAsString(),
      'prospectreportto': selectReport.getSelectedAsString(),
      'prospectassigndesc': inputDesc.text,
      'createdby': session.userid,
      'updatedby': session.userid,
    };
  }
}

class ProspectAssignForm {
  final ProspectAssignSource source;

  ProspectAssignForm(this.source);

  Widget selectAssign() {
    return FormGroup(
      label: Obx(() => Text(ProspectAssignText.labelType,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomSelectBox(
        searchable: false,
        disabled: source.isProcessing,
        controller: source.selectAssign,
        hintText: BaseText.hiintSelect(field: ProspectAssignText.labelType),
        serverSide: (params) => selectApiProspectOwner(params),
        validators: [
          Validators.selectRequired(ProspectAssignText.labelType),
        ],
      ),
    );
  }

  Widget selectReport() {
    return FormGroup(
      label: Obx(() => Text(ProspectAssignText.labelCategory,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomSelectBox(
        searchable: true,
        disabled: source.isProcessing,
        controller: source.selectReport,
        hintText: BaseText.hiintSelect(field: ProspectAssignText.labelCategory),
        serverSide: (params) => selectApiProspectOwner(params),
        validators: [
          Validators.selectRequired(ProspectAssignText.labelCategory),
        ],
      ),
    );
  }

  Widget inputDesc() {
    return FormGroup(
      label: Text(ProspectAssignText.labelDesc),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputDesc,
        hintText: BaseText.hintText(field: ProspectAssignText.labelDesc),
        maxLines: 5,
        minLines: 3,
      ),
    );
  }
}
