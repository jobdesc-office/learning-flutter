import 'package:boilerplate/models/masters/type_model.dart';
import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/base_text.dart';
import '../../../../models/session_model.dart';
import '../../../../presenters/masters/typechildren_presenter.dart';
import '../../../../presenters/navigation_presenter.dart';
import '../../../../styles/color_palattes.dart';
import '../../../../utils/select_api.dart';
import '../../../../utils/session_manager.dart';
import '../../../../utils/validators.dart';
import '../../../../widgets/form_group.dart';
import '../../../../widgets/input/custom_input.dart';
import '../../../../widgets/map/_map_source.dart';
import '../../../../widgets/map/map.dart';
import '../../../../widgets/selectbox/custom_selectbox.dart';
import '_text.dart';

final _navigation = Get.find<NavigationPresenter>();
final map = Get.put(mapSource());
final typepresenter = Get.put(TypesChildrenPresenter());

class ProspectActivitySource extends GetxController {
  bool isProcessing = false;

  var selectedDateExpect = ''.obs;
  var id = 0.obs;
  var isOnSite = true.obs;

  BsSelectBoxController selectType = BsSelectBoxController();
  BsSelectBoxController selectCat = BsSelectBoxController();

  TextEditingController inputDesc = TextEditingController();

  Future<Map<String, dynamic>> toJson() async {
    SessionModel session = await SessionManager.current();
    return {
      'prospectactivityprospectid': id.value,
      'prospectactivitycatid': selectCat.getSelectedAsString(),
      'prospectactivitytypeid': selectType.getSelectedAsString(),
      'prospectactivitydate': selectedDateExpect.value,
      'prospectactivitydesc': inputDesc.text,
      'prospectactivityloc': map.linkCoordinate.value,
      'prospectactivitylatitude': map.latitude.value,
      'prospectactivitylongitude': map.longitude.value,
      'createdby': session.userid,
      'updatedby': session.userid,
    };
  }
}

class ProspectDetailForm {
  final ProspectActivitySource source;

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
      child: Obx(() => CustomSelectBox(
            onChange: (value) {
              var text = TypeModel.fromJson(value.getOtherValue());
              if (text.typename == 'On Site') {
                source.isOnSite.value = false;
              } else {
                source.isOnSite.value = true;
              }
            },
            searchable: true,
            disabled: source.isProcessing,
            controller: source.selectCat,
            hintText:
                BaseText.hiintSelect(field: ProspectDetailText.labelCategory),
            serverSide: (params) => selectApiProspectCategory(params),
            validators: [
              Validators.selectRequired(ProspectDetailText.labelCategory),
            ],
          )),
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

  Widget selectUser(context) {
    return BsRow(
      children: [
        BsCol(
          margin: EdgeInsets.only(right: 10),
          sizes: ColScreen(lg: Col.col_12),
          child: FormGroup(
            label: Obx(() => Text(ProspectDetailText.labelPlace,
                style: TextStyle(
                    color: _navigation.darkTheme.value
                        ? Colors.white
                        : Colors.black))),
            child: Obx(() => BsButton(
                  disabled: source.isOnSite.value,
                  style: BsButtonStyle(
                      color: Color.fromARGB(255, 165, 165, 165),
                      backgroundColor: _navigation.darkTheme.value
                          ? ColorPallates.elseDarkColor
                          : Colors.white,
                      borderColor: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  width: MediaQuery.of(context).size.width,
                  onPressed: () => Get.to(GoogleMapsPage()),
                  label: Text(map.linkCoordinate.isEmpty
                      ? "Choose the Place"
                      : map.linkCoordinate.value),
                )),
          ),
        )
      ],
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
