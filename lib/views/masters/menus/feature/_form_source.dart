import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/base_text.dart';
import '../../../../models/session_model.dart';
import '../../../../presenters/masters/menu_presenter.dart';
import '../../../../presenters/navigation_presenter.dart';
import '../../../../utils/session_manager.dart';
import '../../../../utils/validators.dart';
import '../../../../widgets/form_group.dart';
import '../../../../widgets/input/custom_input.dart';
import '_text.dart';

final _navigation = Get.find<NavigationPresenter>();
final presenter = Get.find<MenuPresenter>();

class FeatureSource {
  bool isProcessing = false;
  var id = 0.obs;

  TextEditingController inputName = TextEditingController();
  TextEditingController inputSlug = TextEditingController();
  TextEditingController inputDesc = TextEditingController();

  Future<List<Map<String, dynamic>>> jsonRole() async {
    List role = await presenter.role();
    return List.from(role);
  }

  Future<Map<String, dynamic>> toJson() async {
    SessionModel session = await SessionManager.current();
    return {
      'featmenuid': id.value,
      'feattitle': inputName.text,
      'featslug': inputSlug.text,
      'featuredesc': inputDesc.text,
      'createdby': session.userid,
      'updatedby': session.userid,
      'isactive': true,
      'roles': jsonEncode(await jsonRole()),
    };
  }
}

class FeatureForm {
  final FeatureSource source;

  FeatureForm(this.source);

  Widget inputName() {
    return FormGroup(
      label: Obx(() => Text(FeatureText.labelName,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputName,
        hintText: BaseText.hintText(field: FeatureText.labelName),
        validators: [
          Validators.inputRequired(FeatureText.labelName),
          Validators.maxLength(FeatureText.labelName, 100),
        ],
      ),
    );
  }

  Widget inputSlug() {
    return FormGroup(
      label: Obx(() => Text(FeatureText.labelSlug,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputSlug,
        hintText: BaseText.hintText(field: FeatureText.labelSlug),
        validators: [
          Validators.maxLength(FeatureText.labelSlug, 100),
        ],
      ),
    );
  }

  Widget inputDesc() {
    return FormGroup(
      label: Obx(() => Text(FeatureText.labelDesc,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputDesc,
        hintText: BaseText.hintText(field: FeatureText.labelDesc),
        validators: [
          Validators.maxLength(FeatureText.labelDesc, 100),
        ],
      ),
    );
  }
}
