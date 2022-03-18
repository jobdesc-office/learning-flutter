import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';

import '../../../constants/base_text.dart';
import '../../../helpers/function.dart';
import '../../../models/session_model.dart';
import '../../../utils/select_api.dart';
import '../../../utils/session_manager.dart';
import '../../../utils/validators.dart';
import '../../../widgets/input/custom_input.dart';
import '../../../widgets/input/custom_input_number.dart';
import '../../../widgets/selectbox/custom_selectbox.dart';
import '../../../widgets/form_group.dart';

import '_menu_type.dart';
import '_text.dart';

class MenuSource {
  bool isProcessing = false;

  MenuTypeOptionsController menuTypeController = MenuTypeOptionsController();

  TextEditingController inputName = TextEditingController();
  TextEditingController inputIcon = TextEditingController();
  TextEditingController inputRoute = TextEditingController();
  TextEditingController inputColor = TextEditingController();
  TextEditingController inputSequence = TextEditingController();

  BsSelectBoxController selectParent = BsSelectBoxController();

  Future<Map<String, dynamic>> toJson() async {
    SessionModel session = await SessionManager.current();
    return {
      'menutypeid': menuTypeController.getSelectedToString(),
      'menunm': inputName.text,
      'masterid': selectParent.getSelectedAsString(),
      'icon': inputIcon.text,
      'route': inputRoute.text,
      'color': inputColor.text,
      'seq': inputSequence.text,
      'createdby': session.userid,
      'updatedby': session.userid,
      'isactive': true,
    };
  }
}

class MenuForm {
  final MenuSource source;

  MenuForm(this.source);

  Widget menuType() {
    return FormGroup(
      label: Text(MenuText.labelMenuType),
      child: MenuTypeOptions(
        controller: source.menuTypeController,
      ),
    );
  }

  Widget inputName() {
    return FormGroup(
      label: Text(MenuText.labelName),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputName,
        hintText: BaseText.hintText(),
        validators: [
          Validators.inputRequired(MenuText.labelName),
          Validators.maxLength(MenuText.labelName, 100),
        ],
      ),
    );
  }

  Widget selectParent() {
    return FormGroup(
      label: Text(MenuText.labelParent),
      child: CustomSelectBox(
        searchable: true,
        disabled: source.isProcessing,
        controller: source.selectParent,
        hintText: BaseText.hiintSelect(),
        serverSide: (params) => selectMenu(params),
      ),
    );
  }

  Widget inputIcon() {
    return FormGroup(
      label: Text(MenuText.labelIcon),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputIcon,
        hintText: BaseText.hintText(),
      ),
    );
  }

  Widget inputRoute() {
    return FormGroup(
      label: Text(MenuText.labelRoute),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputRoute,
        hintText: BaseText.hintText(),
        validators: [
          Validators.inputRequired(MenuText.labelRoute),
          Validators.maxLength(MenuText.labelRoute, 100),
        ],
      ),
    );
  }

  Widget inputColor() {
    return FormGroup(
      label: Text(MenuText.labelColor),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputColor,
        hintText: BaseText.hintText(),
        validators: [],
      ),
    );
  }

  Widget inputSequence() {
    return FormGroup(
      label: Text(MenuText.labelSequence),
      child: CustomInputNumber(
        disabled: source.isProcessing,
        controller: source.inputSequence,
        hintText: BaseText.hintText(),
        validators: [
          Validators.maxLength(MenuText.labelSequence, 100),
        ],
      ),
    );
  }
}
