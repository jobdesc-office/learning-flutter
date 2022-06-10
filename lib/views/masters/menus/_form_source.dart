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
import '../../../widgets/input/custom_input_number.dart';
import '../../../widgets/selectbox/custom_selectbox.dart';
import '../../../widgets/form_group.dart';

import '_menu_type.dart';
import '_text.dart';

final _navigation = Get.find<NavigationPresenter>();

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
      'menuicon': inputIcon.text,
      'menuroute': inputRoute.text,
      'menucolor': inputColor.text,
      'menuseq': inputSequence.text,
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
      label: Obx(() => Text(MenuText.labelMenuType,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: MenuTypeOptions(
        controller: source.menuTypeController,
      ),
    );
  }

  Widget inputName() {
    return FormGroup(
      label: Obx(() => Text(MenuText.labelName,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputName,
        hintText: BaseText.hintText(field: MenuText.labelName),
        validators: [
          Validators.inputRequired(MenuText.labelName),
          Validators.maxLength(MenuText.labelName, 100),
        ],
      ),
    );
  }

  Widget selectParent() {
    return FormGroup(
      label: Obx(() => Text(MenuText.labelParent,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomSelectBox(
        searchable: true,
        disabled: source.isProcessing,
        controller: source.selectParent,
        hintText: BaseText.hiintSelect(field: MenuText.labelParent),
        serverSide: (params) => selectApiMenu(params),
      ),
    );
  }

  Widget inputIcon() {
    return FormGroup(
      label: Obx(() => Text(MenuText.labelIcon,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputIcon,
        hintText: BaseText.hintText(field: MenuText.labelIcon),
        validators: [
          Validators.maxLength(MenuText.labelIcon, 100),
        ],
      ),
    );
  }

  Widget inputRoute() {
    return FormGroup(
      label: Obx(() => Text(MenuText.labelRoute,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputRoute,
        hintText: BaseText.hintText(field: MenuText.labelRoute),
        validators: [
          // Validators.inputRequired(MenuText.labelRoute),
          Validators.maxLength(MenuText.labelRoute, 100),
        ],
      ),
    );
  }

  Widget inputColor() {
    return FormGroup(
      label: Obx(() => Text(MenuText.labelColor,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputColor,
        hintText: BaseText.hintText(field: MenuText.labelColor),
        validators: [
          Validators.maxLength(MenuText.labelColor, 100),
        ],
      ),
    );
  }

  Widget inputSequence() {
    return FormGroup(
      label: Obx(() => Text(MenuText.labelSequence,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInputNumber(
        disabled: source.isProcessing,
        controller: source.inputSequence,
        hintText: BaseText.hintText(field: MenuText.labelSequence),
        validators: [
          Validators.maxLength(MenuText.labelSequence, 100),
        ],
      ),
    );
  }
}
