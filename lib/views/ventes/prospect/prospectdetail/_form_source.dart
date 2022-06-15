import 'dart:typed_data';
import 'dart:io';

import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

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

class ProspectDetailSource extends GetxController {
  bool isProcessing = false;

  var selectedDateExpect = ''.obs;
  var id = 0.obs;

  BsSelectBoxController selectType = BsSelectBoxController();
  BsSelectBoxController selectCat = BsSelectBoxController();

  TextEditingController inputDesc = TextEditingController();

  Future<Map<String, dynamic>> toJson() async {
    SessionModel session = await SessionManager.current();
    return {
      'prospectdtprospectid': id.value,
      'prospectdtcatid': selectCat.getSelectedAsString(),
      'prospectdttypeid': selectType.getSelectedAsString(),
      'prospectdtdate': selectedDateExpect.value,
      'prospectdtdesc': inputDesc.text,
      'createdby': session.userid,
      'updatedby': session.userid,
    };
  }
}

class ProspectDetailForm {
  final ProspectDetailSource source;

  ProspectDetailForm(this.source);

  Widget selectTypes() {
    return FormGroup(
      label: Obx(() => Text(ProspectDetailText.labelType,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomSelectBox(
        searchable: false,
        disabled: source.isProcessing,
        controller: source.selectType,
        hintText: BaseText.hiintSelect(field: ProspectDetailText.labelType),
        serverSide: (params) => selectApiProspectType(params),
        validators: [
          Validators.selectRequired(ProspectDetailText.labelType),
        ],
      ),
    );
  }

  Widget selectCategory() {
    return FormGroup(
      label: Obx(() => Text(ProspectDetailText.labelCategory,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomSelectBox(
        searchable: true,
        disabled: source.isProcessing,
        controller: source.selectCat,
        hintText: BaseText.hiintSelect(field: ProspectDetailText.labelCategory),
        serverSide: (params) => selectApiProspectCategory(params),
        validators: [
          Validators.selectRequired(ProspectDetailText.labelCategory),
        ],
      ),
    );
  }

  Widget inputExpected(context) {
    return FormGroup(
      label: Obx(() => Text(ProspectDetailText.labelExpected,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: BsButton(
          style: BsButtonStyle(
              color: Color.fromARGB(255, 165, 165, 165),
              backgroundColor: _navigation.darkTheme.value
                  ? ColorPallates.elseDarkColor
                  : Colors.white,
              borderColor: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(5))),
          width: MediaQuery.of(context).size.width,
          onPressed: () {
            _selectExpectDates(context);
          },
          label: Obx(() => Text(source.selectedDateExpect.isEmpty
              ? "Choose the Expected Date"
              : '${source.selectedDateExpect}')),
        ),
      ),
    );
  }

  Widget inputDesc() {
    return FormGroup(
      label: Text(ProspectDetailText.labelDesc),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputDesc,
        hintText: BaseText.hintText(field: ProspectDetailText.labelDesc),
        maxLines: 5,
        minLines: 3,
      ),
    );
  }

  _selectExpectDates(BuildContext context) async {
    final DateTime? selectedExpected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (selectedExpected != null &&
        selectedExpected != source.selectedDateExpect) {
      source.selectedDateExpect.value =
          '${selectedExpected.year}-${selectedExpected.month}-${selectedExpected.day}';
    }
  }
}
