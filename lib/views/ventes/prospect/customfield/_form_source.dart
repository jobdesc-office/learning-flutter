import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/base_text.dart';
import '../../../../models/session_model.dart';
import '../../../../presenters/navigation_presenter.dart';
import '../../../../presenters/ventes/customfield_presenter.dart';
import '../../../../utils/select_api.dart';
import '../../../../utils/session_manager.dart';
import '../../../../utils/validators.dart';
import '../../../../widgets/form_group.dart';
import '../../../../widgets/input/custom_input.dart';
import '../../../../widgets/selectbox/custom_selectbox.dart';
import '../_detail_source.dart';
import '_text.dart';

final _navigation = Get.find<NavigationPresenter>();

class CustomFieldSource extends GetxController {
  final source = Get.put(ProspectDetailsSource());

  bool isProcessing = false;
  var id = 0.obs;

  var visible = false.obs;
  var newprospect = false.obs;

  BsSelectBoxController selectType = BsSelectBoxController();
  BsSelectBoxController selectBp = BsSelectBoxController();

  TextEditingController inputName = TextEditingController();

  Future<Map<String, dynamic>> toJson() async {
    SessionModel session = await SessionManager.current();
    return {
      'custfbpid': source.prospectbpid.value,
      'custftypeid': selectType.getSelectedAsString(),
      'custfname': inputName.text,
      'isvisiblesidebar': visible.value,
      'onlyinnewprospect': newprospect.value,
      'lastprospectid': source.prospectid.value,
      'createdby': session.userid,
      'updatedby': session.userid,
    };
  }
}

class CustomFieldForm {
  final CustomFieldSource source;
  final CustomFieldPresenter presenter = Get.find<CustomFieldPresenter>();

  CustomFieldForm(this.source);

  Widget selectTypes() {
    return FormGroup(
      label: Obx(() => Text(CustomFieldText.labelType,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomSelectBox(
        searchable: false,
        disabled: source.isProcessing,
        controller: source.selectType,
        hintText: BaseText.hiintSelect(field: CustomFieldText.labelType),
        serverSide: (params) => selectApiCustomFieldTypes(params),
        validators: [
          Validators.selectRequired(CustomFieldText.labelType),
        ],
      ),
    );
  }

  Widget inputName() {
    return FormGroup(
      label: Obx(() => Text(CustomFieldText.labelName,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputName,
        hintText: BaseText.hiintSelect(field: CustomFieldText.labelName),
        validators: [
          Validators.inputRequired(CustomFieldText.labelName),
        ],
      ),
    );
  }

  Widget checkBoxForm() {
    return BsRow(
      children: [
        BsCol(
          margin: EdgeInsets.only(right: 10),
          sizes: ColScreen(lg: Col.col_6),
          child: FormGroup(
            label: Obx(() => Center(
                  child: Text(CustomFieldText.isVisible,
                      style: TextStyle(
                          color: _navigation.darkTheme.value
                              ? Colors.white
                              : Colors.black)),
                )),
            child: Obx(() => Center(
                  child: Checkbox(
                    value: source.visible.value,
                    onChanged: (value) => source.visible.toggle(),
                  ),
                )),
          ),
        ),
        BsCol(
          margin: EdgeInsets.only(right: 10),
          sizes: ColScreen(lg: Col.col_6),
          child: FormGroup(
            label: Obx(() => Center(
                  child: Text(CustomFieldText.labelNewPropect,
                      style: TextStyle(
                          color: _navigation.darkTheme.value
                              ? Colors.white
                              : Colors.black)),
                )),
            child: Obx(() => Center(
                  child: Checkbox(
                    value: source.newprospect.value,
                    onChanged: (value) => source.newprospect.toggle(),
                  ),
                )),
          ),
        ),
      ],
    );
  }
}
