import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/base_text.dart';
import '../../../models/session_model.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../utils/select_api.dart';
import '../../../utils/session_manager.dart';
import '../../../utils/validators.dart';
import '../../../widgets/input/custom_input.dart';
import '../../../widgets/selectbox/custom_selectbox.dart';
import '../../../widgets/form_group.dart';

import '_text.dart';

final _navigation = Get.find<NavigationPresenter>();

class CompetitorSource extends GetxController {
  bool isProcessing = false;
  var isnGetLatLong = true.obs;

  TextEditingController inputName = TextEditingController();
  TextEditingController inputProductName = TextEditingController();
  TextEditingController inputDesc = TextEditingController();

  BsSelectBoxController selectType = BsSelectBoxController();
  BsSelectBoxController selectBp = BsSelectBoxController();
  BsSelectBoxController selectRef = BsSelectBoxController();

  Future<Map<String, dynamic>> toJson() async {
    SessionModel session = await SessionManager.current();
    return {
      'comptbpid': selectBp.getSelectedAsString(),
      'comptreftypeid': selectType.getSelectedAsString(),
      'comptrefid': selectRef.getSelectedAsString(),
      'comptname': inputName.text,
      'comptproductname': inputProductName.text,
      'description': inputDesc.text,
      'createdby': session.userid,
      'updatedby': session.userid,
    };
  }
}

class CompetitorForm {
  final CompetitorSource source;

  CompetitorForm(this.source);

  Widget inputName() {
    return FormGroup(
      label: Obx(() => Text(CompetitorText.labelName,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputName,
        hintText: BaseText.hintText(field: CompetitorText.labelName),
        validators: [
          Validators.inputRequired(CompetitorText.labelName),
        ],
      ),
    );
  }

  Widget selectTypes() {
    return FormGroup(
      label: Obx(() => Text(CompetitorText.labelType,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomSelectBox(
        searchable: false,
        disabled: source.isProcessing,
        controller: source.selectType,
        hintText: BaseText.hiintSelect(field: CompetitorText.labelType),
        serverSide: (params) => selectApiCompetitorRefType(params),
      ),
    );
  }

  Widget selectBp() {
    return FormGroup(
      label: Obx(() => Text(CompetitorText.labelBp,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomSelectBox(
        searchable: true,
        disabled: source.isProcessing,
        controller: source.selectBp,
        hintText: BaseText.hiintSelect(field: CompetitorText.labelBp),
        serverSide: (params) => selectApiPartner(params),
      ),
    );
  }

  Widget selectRef() {
    return FormGroup(
      label: Obx(() => Text(CompetitorText.labelRef,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomSelectBox(
        searchable: false,
        disabled: source.isProcessing,
        controller: source.selectRef,
        hintText: BaseText.hiintSelect(field: CompetitorText.labelRef),
        serverSide: (params) => selectApiProspect(params),
        validators: [],
      ),
    );
  }

  Widget inputProductName() {
    return FormGroup(
      label: Obx(() => Text(CompetitorText.labelProductName,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputProductName,
        hintText: BaseText.hintText(field: CompetitorText.labelProductName),
        validators: [],
      ),
    );
  }

  Widget inputDesciption() {
    return FormGroup(
      label: Obx(() => Text(CompetitorText.labelDesc,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputDesc,
        hintText: BaseText.hintText(field: CompetitorText.labelDesc),
        validators: [],
        minLines: 2,
        maxLines: 5,
      ),
    );
  }
}
