import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/base_text.dart';
import '../../../../models/session_model.dart';
import '../../../../presenters/navigation_presenter.dart';
import '../../../../utils/session_manager.dart';
import '../../../../utils/validators.dart';
import '../../../../widgets/form_group.dart';
import '../../../../widgets/input/custom_input.dart';
import '../_details_source.dart';
import '_text.dart';

final _navigation = Get.find<NavigationPresenter>();
final source = Get.put(MenuDetailsSource());

class FeatureSource {
  bool isProcessing = false;

  TextEditingController inputName = TextEditingController();
  TextEditingController inputSlug = TextEditingController();
  TextEditingController inputDesc = TextEditingController();

  Future<Map<String, dynamic>> toJson() async {
    SessionModel session = await SessionManager.current();
    return {
      'featmenuid': source.id.value,
      'feattitle': inputName.text,
      'featslug': inputSlug.text,
      'featuredesc': inputDesc.text,
      'createdby': session.userid,
      'updatedby': session.userid,
      'isactive': true,
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
