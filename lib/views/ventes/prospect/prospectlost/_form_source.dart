import 'package:boilerplate/constants/config_types.dart';
import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/base_text.dart';
import '../../../../models/masters/type_model.dart';
import '../../../../models/session_model.dart';
import '../../../../presenters/navigation_presenter.dart';
import '../../../../presenters/ventes/prospect_presenter.dart';
import '../../../../services/masters/type_service.dart';
import '../../../../styles/color_palattes.dart';
import '../../../../utils/select_api.dart';
import '../../../../utils/session_manager.dart';
import '../../../../utils/validators.dart';
import '../../../../widgets/form_group.dart';
import '../../../../widgets/input/custom_input.dart';
import '../../../../widgets/selectbox/custom_selectbox.dart';
import '_text.dart';

final _navigation = Get.find<NavigationPresenter>();

class ProspectLostSource extends GetxController {
  bool isProcessing = false;

  var selectedDateExpect = ''.obs;
  var id = 0.obs;

  BsSelectBoxController selectReason = BsSelectBoxController();
  final _prospectPresenter = Get.put(ProspectPresenter());

  TextEditingController inputDesc = TextEditingController();

  Future<Map<String, dynamic>> toJson() async {
    SessionModel session = await SessionManager.current();
    int data = await _prospectPresenter.lostStatus();
    TypeModel stage = await _prospectPresenter.completePipeline();

    return {
      'prospectstatusid': data,
      'prospectstageid': stage.typeid,
      'prospectlostreasonid': selectReason.getSelectedAsString(),
      'prospectlostdesc': inputDesc.text,
      'createdby': session.userid,
      'updatedby': session.userid,
    };
  }
}

class ProspectLostForm {
  final ProspectLostSource source;

  ProspectLostForm(this.source);
  Widget selectReport() {
    return FormGroup(
      label: Obx(() => Text(ProspectLostText.labelCategory,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomSelectBox(
        searchable: true,
        disabled: source.isProcessing,
        controller: source.selectReason,
        hintText: BaseText.hiintSelect(field: ProspectLostText.labelCategory),
        serverSide: (params) => selectApiProspectLostType(params),
        validators: [
          Validators.selectRequired(ProspectLostText.labelCategory),
        ],
      ),
    );
  }

  Widget inputDesc() {
    return FormGroup(
      label: Text(ProspectLostText.labelDesc,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black)),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputDesc,
        hintText: BaseText.hintText(field: ProspectLostText.labelDesc),
        maxLines: 5,
        minLines: 3,
      ),
    );
  }
}
