import 'dart:convert';

import 'package:boilerplate/models/masters/type_model.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/base_text.dart';
import '../../../../constants/config_types.dart';
import '../../../../models/session_model.dart';
import '../../../../presenters/navigation_presenter.dart';
import '../../../../presenters/settings/customfield_presenter.dart';
import '../../../../services/masters/type_service.dart';
import '../../../../utils/select_api.dart';
import '../../../../utils/session_manager.dart';
import '../../../../utils/validators.dart';
import '../../../../widgets/button/button_role_user.dart';
import '../../../../widgets/form_group.dart';
import '../../../../widgets/input/custom_input.dart';
import '../../../../widgets/selectbox/custom_selectbox.dart';
import '../_detail_source.dart';
import '_text.dart';

final _navigation = Get.find<NavigationPresenter>();
final _type = Get.put(TypeService());

class CustomFieldSource extends GetxController {
  final source = Get.put(ProspectDetailsSource());

  bool isProcessing = false;
  var id = 0.obs;

  var allprospect = false.obs;
  var onlythisdata = true.obs;

  var isselectbox = false.obs;

  BsSelectBoxController selectType = BsSelectBoxController();
  BsSelectBoxController selectBp = BsSelectBoxController();

  TextEditingController inputName = TextEditingController();

  var inputOptions = List<TextEditingController>.filled(
          1, TextEditingController(),
          growable: true)
      .obs;

  List<Map<String, dynamic>> jsonOption() {
    return List<Map<String, dynamic>>.from(inputOptions.map((controller) {
      int index = inputOptions.indexOf(controller);
      return {'optvalue': inputOptions[index].text};
    }));
  }

  Future<Map<String, dynamic>> toJson() async {
    SessionModel session = await SessionManager.current();
    Response res = await _type.byCodeMaster(ConfigType.prospectCustomField);
    int id = TypeModel.fromJson(res.body.first).typeid ?? 0;

    return {
      'custfbpid': source.prospectbpid.value,
      'custftypeid': selectType.getSelectedAsString(),
      'custfreftypeid': id,
      'custfname': inputName.text,
      'alldata': allprospect.value,
      'onlythisdata': onlythisdata.value,
      'thisdataid': source.prospectid.value,
      'createdby': session.userid,
      'updatedby': session.userid,
      'option': isselectbox.value ? jsonEncode(jsonOption()) : null
    };
  }
}

class CustomFieldForm {
  final CustomFieldSource source;
  final CustomFieldPresenter presenter = Get.find<CustomFieldPresenter>();

  CustomFieldForm(this.source);

  Widget selectTypes() {
    return Obx(() => FormGroup(
          label: Text(CustomFieldText.labelType,
              style: TextStyle(
                  color: _navigation.darkTheme.value
                      ? Colors.white
                      : Colors.black)),
          child: CustomSelectBox(
            searchable: false,
            disabled: source.isProcessing,
            controller: source.selectType,
            hintText: BaseText.hiintSelect(field: CustomFieldText.labelType),
            serverSide: (params) => selectApiCustomFieldTypes(params),
            validators: [
              Validators.selectRequired(CustomFieldText.labelType),
            ],
            onChange: (value) {
              if (value.getOtherValue()['typename'] == 'Selectbox')
                source.isselectbox.value = true;
              else
                source.isselectbox.value = false;
            },
          ),
        ));
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
                    value: source.onlythisdata.value,
                    onChanged: (value) {
                      source.onlythisdata.value = value!;
                      if (source.onlythisdata.value == true)
                        source.allprospect.value = !value;
                    },
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
                    value: source.allprospect.value,
                    onChanged: (value) {
                      source.allprospect.value = value!;
                      if (source.onlythisdata.value == true)
                        source.onlythisdata.value = !value;
                    },
                  ),
                )),
          ),
        ),
      ],
    );
  }

  Widget formDetail({required ValueChanged<int> onRemoveItem}) {
    return FormGroup(
      child: Obx(() => Column(
            children: source.inputOptions.value.map((controller) {
              int index = source.inputOptions.value.indexOf(controller);
              var inputOption = source.inputOptions.value[index];
              return BsRow(
                children: [
                  BsCol(
                    margin: EdgeInsets.only(right: 5),
                    sizes: ColScreen(lg: Col.col_11),
                    child: FormGroup(
                      child: CustomInput(
                        hintText:
                            BaseText.hintText(field: 'Option ${index + 1}'),
                        controller: inputOption,
                        validators: [
                          Validators.inputRequired('Option ${index + 1}')
                        ],
                      ),
                    ),
                  ),
                  BsCol(
                    sizes: ColScreen(sm: Col.col_1),
                    child: ButtonMultipleCancel(
                        disabled: source.inputOptions.length > 1 ? false : true,
                        margin: EdgeInsets.only(top: 10),
                        onPressed: () => onRemoveItem(index)),
                  )
                ],
              );
            }).toList(),
          )),
    );
  }
}
