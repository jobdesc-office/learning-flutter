import 'dart:convert';

import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/base_text.dart';
import '../../../models/masters/type_model.dart';
import '../../../models/session_model.dart';
import '../../../presenters/auth_presenter.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../styles/color_palattes.dart';
import '../../../utils/session_manager.dart';
import '../../../utils/validators.dart';
import '../../../utils/select_api.dart';
import '../../../widgets/button/button_role_user.dart';
import '../../../widgets/form_group.dart';
import '../../../widgets/input/custom_input.dart';
import '../../../widgets/input/custom_input_number.dart';
import '../../../widgets/map/_map_source.dart';
import '../../../widgets/map/map.dart';
import '../../../widgets/selectbox/custom_selectbox.dart';
import '_text.dart';

final _navigation = Get.find<NavigationPresenter>();

class ScheduleSource extends GetxController {
  final map = Get.put(MapSource());

  final _auth = Get.put(AuthPresenter());

  var refType = ''.obs;
  var refTypeIsNotChoosed = true.obs;

  bool isProcessing = false;

  var isBpNotSelected = true.obs;

  var selectedDateStart = ''.obs;
  var selectedDateEnd = ''.obs;
  var selectedDateAct = ''.obs;
  var selectedTimeStart = ''.obs;
  var selectedTimeEnd = ''.obs;
  var online = false.obs;
  var allDay = false.obs;
  var private = false.obs;

  TextEditingController inputName = TextEditingController();
  TextEditingController inputOnLink = TextEditingController();
  TextEditingController inputDesc = TextEditingController();
  TextEditingController inputRemind = TextEditingController();

  BsSelectBoxController selectType = BsSelectBoxController();
  BsSelectBoxController selectRefType = BsSelectBoxController();
  BsSelectBoxController selectRef = BsSelectBoxController();
  BsSelectBoxController selectToward = BsSelectBoxController();
  BsSelectBoxController selectBp = BsSelectBoxController();
  BsSelectBoxController selectTimeZone = BsSelectBoxController();
  // BsSelectBoxController selectPermission = BsSelectBoxController(options: [
  //   BsSelectBoxOption(value: '{1}', text: Text('Read Only')),
  //   BsSelectBoxOption(value: '{2}', text: Text('Add Member')),
  //   BsSelectBoxOption(value: '{3}', text: Text('Share Link')),
  //   BsSelectBoxOption(value: '{2,3}', text: Text('Add Member & Share Link'))
  // ]);

  List<BsSelectBoxController> selectsMember =
      List<BsSelectBoxController>.empty(growable: true);
  List<BsSelectBoxController> selectsPermission =
      List<BsSelectBoxController>.empty(growable: true);

  List<Map<String, dynamic>> jsonMember() {
    return List<Map<String, dynamic>>.from(selectsMember.map((controller) {
      int index = selectsMember.indexOf(controller);
      return {
        'scheuserid': selectsMember[index].getSelectedAsString(),
        'schebpid': _auth.bpActiveId.value,
        'schepermisid': selectsPermission[index].getSelectedAsString()
      };
    }));
  }

  Future<Map<String, dynamic>> toJson() async {
    SessionModel session = await SessionManager.current();
    return {
      'schenm': inputName.text,
      'schestartdate': selectedDateStart.value,
      'scheenddate': selectedDateEnd.value,
      'schestarttime': selectedTimeStart.value,
      'scheendtime': selectedTimeEnd.value,
      'schetypeid': selectType.getSelectedAsString(),
      'scheactdate': selectedDateAct.value,
      'schetowardid': selectToward.getSelectedAsString(),
      'schebpid': selectBp.getSelectedAsString(),
      'schereftypeid': selectRefType.getSelectedAsString(),
      'scherefid': selectRef.getSelectedAsString(),
      'scheallday': allDay.value,
      'scheloc': map.linkCoordinate.value,
      'scheprivate': private.value,
      'scheonline': online.value,
      'schetz': selectTimeZone.getSelectedAsString(),
      'scheremind': inputRemind.text,
      'schedesc': inputDesc.text,
      'scheonlink': inputOnLink.text,
      'createdby': session.userid,
      'updatedby': session.userid,
      'isactive': true,
      'members': jsonEncode(jsonMember())
    };
  }
}

class ScheduleForm {
  final map = Get.put(MapSource());
  final _auth = Get.put(AuthPresenter());
  final ScheduleSource source;

  ScheduleForm(this.source);

  Widget checkBoxTypeForm({required ValueChanged<int> onRemoveItem}) {
    return FormGroup(
      child: Column(
        children: source.selectsMember.map((controller) {
          int index = source.selectsMember.indexOf(controller);
          var selectMember = source.selectsMember[index];
          var selectPermission = source.selectsPermission[index];
          return BsRow(
            children: [
              BsCol(
                margin: EdgeInsets.only(right: 10),
                sizes: ColScreen(lg: Col.col_5),
                child: FormGroup(
                  label: Obx(() => Text(
                      ScheduleText.labelGuest + ' ${index + 1}',
                      style: TextStyle(
                          color: _navigation.darkTheme.value
                              ? Colors.white
                              : Colors.black))),
                  child: CustomSelectBox(
                    searchable: true,
                    disabled: source.isBpNotSelected.value,
                    controller: selectMember,
                    hintText: BaseText.hiintSelect(
                        field: ScheduleText.labelGuest + ' ${index + 1}'),
                    serverSide: (params) => selectApiProspectOwner(params),
                  ),
                ),
              ),
              BsCol(
                margin: EdgeInsets.only(right: 10),
                sizes: ColScreen(lg: Col.col_5),
                child: FormGroup(
                  label: Obx(() => Text(
                      ScheduleText.labelPermission + ' ${index + 1}',
                      style: TextStyle(
                          color: _navigation.darkTheme.value
                              ? Colors.white
                              : Colors.black))),
                  child: CustomSelectBox(
                    searchable: false,
                    disabled: source.isBpNotSelected.value,
                    controller: selectPermission,
                    hintText: BaseText.hiintSelect(
                        field: ScheduleText.labelPermission + ' ${index + 1}'),
                  ),
                ),
              ),
              BsCol(
                margin: EdgeInsets.only(left: 5, top: 3),
                sizes: ColScreen(lg: Col.col_1),
                child: FormGroup(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Center(
                          child: ButtonMultipleCancel(
                              margin: EdgeInsets.only(left: 10),
                              onPressed: () => onRemoveItem(index)),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget inputName() {
    return FormGroup(
      label: Obx(() => Text(ScheduleText.labelName,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputName,
        hintText: BaseText.hintText(field: ScheduleText.labelName),
        validators: [
          Validators.inputRequired(ScheduleText.labelName),
          Validators.maxLength(ScheduleText.labelName, 50),
        ],
      ),
    );
  }

  Widget inputDate(context) {
    return BsRow(
      children: [
        BsCol(
          margin: EdgeInsets.only(right: 10),
          sizes: ColScreen(lg: Col.col_6),
          child: FormGroup(
            label: Obx(() => Text(ScheduleText.labelStartDate,
                style: TextStyle(
                    color: _navigation.darkTheme.value
                        ? Colors.white
                        : Colors.black))),
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
                  _selectStartDates(context);
                },
                label: Obx(() => Text(source.selectedDateStart.isEmpty
                    ? "Choose the Start Date"
                    : '${source.selectedDateStart}')),
              ),
            ),
          ),
        ),
        BsCol(
          margin: EdgeInsets.only(left: 10),
          sizes: ColScreen(lg: Col.col_6),
          child: FormGroup(
            label: Obx(() => Text(ScheduleText.labelEndDate,
                style: TextStyle(
                    color: _navigation.darkTheme.value
                        ? Colors.white
                        : Colors.black))),
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
                    _selectEndDates(context);
                  },
                  label: Obx(() => Text(source.selectedDateEnd.isEmpty
                      ? "Choose the End Date"
                      : '${source.selectedDateEnd}'))),
            ),
          ),
        ),
      ],
    );
  }

  Widget inputTime(context) {
    return BsRow(
      children: [
        BsCol(
          margin: EdgeInsets.only(right: 10),
          sizes: ColScreen(lg: Col.col_4),
          child: FormGroup(
            label: Obx(() => Text(ScheduleText.labelStartTime,
                style: TextStyle(
                    color: _navigation.darkTheme.value
                        ? Colors.white
                        : Colors.black))),
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
                disabled: source.allDay.value ? true : false,
                onPressed: () {
                  _selectStartTimes(context);
                },
                label: Obx(() => Text(source.selectedTimeStart.isEmpty
                    ? "Choose the Start Time"
                    : '${source.selectedTimeStart}')),
              ),
            ),
          ),
        ),
        BsCol(
          margin: EdgeInsets.only(left: 10),
          sizes: ColScreen(lg: Col.col_4),
          child: FormGroup(
            label: Obx(() => Text(ScheduleText.labelEndTime,
                style: TextStyle(
                    color: _navigation.darkTheme.value
                        ? Colors.white
                        : Colors.black))),
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
                  disabled: source.allDay.value ? true : false,
                  onPressed: () {
                    _selectEndTimes(context);
                  },
                  label: Obx(() => Text(source.selectedTimeEnd.isEmpty
                      ? "Choose the End Time"
                      : '${source.selectedTimeEnd}'))),
            ),
          ),
        ),
        BsCol(
          margin: EdgeInsets.only(left: 10),
          sizes: ColScreen(lg: Col.col_4),
          child: FormGroup(
            label: Obx(() => Text(ScheduleText.labelTimeZone,
                style: TextStyle(
                    color: _navigation.darkTheme.value
                        ? Colors.white
                        : Colors.black))),
            child: CustomSelectBox(
              searchable: false,
              disabled: source.isProcessing,
              controller: source.selectTimeZone,
              hintText: BaseText.hiintSelect(field: ScheduleText.labelTimeZone),
              serverSide: (params) => selectTimeZone(params),
            ),
          ),
        )
      ],
    );
  }

  Widget actDate(context) {
    return FormGroup(
      label: Obx(() => Text(ScheduleText.labelActDate,
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
              _selectActDates(context);
            },
            label: Obx(() => Text(source.selectedDateAct.isEmpty
                ? "Choose the Actual Date"
                : '${source.selectedDateAct}'))),
      ),
    );
  }

  Widget selectType() {
    return BsRow(
      children: [
        BsCol(
          margin: EdgeInsets.only(right: 10),
          sizes: ColScreen(lg: Col.col_4),
          child: FormGroup(
            label: Obx(() => Text(ScheduleText.labelType,
                style: TextStyle(
                    color: _navigation.darkTheme.value
                        ? Colors.white
                        : Colors.black))),
            child: CustomSelectBox(
              searchable: false,
              disabled: source.isProcessing,
              controller: source.selectType,
              hintText: BaseText.hiintSelect(field: ScheduleText.labelType),
              serverSide: (params) => selectApiTypeSchedule(params),
            ),
          ),
        ),
        BsCol(
          margin: EdgeInsets.only(right: 10),
          sizes: ColScreen(lg: Col.col_4),
          child: FormGroup(
            label: Obx(() => Text(ScheduleText.labelRefType,
                style: TextStyle(
                    color: _navigation.darkTheme.value
                        ? Colors.white
                        : Colors.black))),
            child: Obx(() => CustomSelectBox(
                  searchable: false,
                  disabled: source.isProcessing,
                  controller: source.selectRefType,
                  hintText:
                      BaseText.hiintSelect(field: ScheduleText.labelRefType),
                  serverSide: (params) => selectApiScheduleRefTypes(params),
                  onChange: (value) {
                    var text = TypeModel.fromJson(value.getOtherValue());
                    source.refType.value = text.typename;
                    source.refTypeIsNotChoosed.value = false;
                  },
                )),
          ),
        ),
        BsCol(
          margin: EdgeInsets.only(right: 10),
          sizes: ColScreen(lg: Col.col_4),
          child: FormGroup(
            label: Obx(() => Text(ScheduleText.labelRef,
                style: TextStyle(
                    color: _navigation.darkTheme.value
                        ? Colors.white
                        : Colors.black))),
            child: CustomSelectBox(
              searchable: false,
              disabled: source.refTypeIsNotChoosed.value,
              controller: source.selectRef,
              hintText: BaseText.hiintSelect(field: ScheduleText.labelRef),
              serverSide: (params) {
                if (source.refType.value == 'Prospect Activity')
                  return selectApiProspect(params);
                else
                  return selectApiTypeSchedule(params);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget selectUser(context) {
    return BsRow(
      children: [
        BsCol(
          margin: EdgeInsets.only(right: 10),
          sizes: ColScreen(lg: Col.col_12),
          child: FormGroup(
            label: Obx(() => Text(ScheduleText.labelPlace,
                style: TextStyle(
                    color: _navigation.darkTheme.value
                        ? Colors.white
                        : Colors.black))),
            child: BsButton(
              style: BsButtonStyle(
                  color: Color.fromARGB(255, 165, 165, 165),
                  backgroundColor: _navigation.darkTheme.value
                      ? ColorPallates.elseDarkColor
                      : Colors.white,
                  borderColor: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              width: MediaQuery.of(context).size.width,
              disabled: source.online.value ? true : false,
              onPressed: () => Get.to(GoogleMapsPage()),
              label: Obx(() => Text(map.latitudelongitude.isEmpty
                  ? "Choose the Place"
                  : map.latitudelongitude.value)),
            ),
          ),
        )
      ],
    );
  }

  Widget checkBoxForm() {
    return BsRow(
      children: [
        BsCol(
          margin: EdgeInsets.only(right: 10),
          sizes: ColScreen(lg: Col.col_2),
          child: FormGroup(
            label: Obx(() => Text(ScheduleText.labelOnline,
                style: TextStyle(
                    color: _navigation.darkTheme.value
                        ? Colors.white
                        : Colors.black))),
            child: Obx(() => Checkbox(
                  value: source.online.value,
                  onChanged: (value) {
                    source.online.toggle();

                    map.linkCoordinate.value = '';
                  },
                )),
          ),
        ),
        BsCol(
          margin: EdgeInsets.only(right: 10),
          sizes: ColScreen(lg: Col.col_2),
          child: FormGroup(
            label: Obx(() => Text(ScheduleText.labelAllDay,
                style: TextStyle(
                    color: _navigation.darkTheme.value
                        ? Colors.white
                        : Colors.black))),
            child: Obx(() => Checkbox(
                  value: source.allDay.value,
                  onChanged: (value) {
                    if (source.allDay.isTrue) {
                      source.allDay.toggle();
                      source.selectedTimeStart.value = '';
                      source.selectedTimeEnd.value = '';
                    } else {
                      source.allDay.toggle();
                      source.inputOnLink.text = '';
                    }
                  },
                )),
          ),
        ),
        BsCol(
          margin: EdgeInsets.only(right: 10),
          sizes: ColScreen(lg: Col.col_2),
          child: FormGroup(
            label: Obx(() => Text(ScheduleText.labelPrivate,
                style: TextStyle(
                    color: _navigation.darkTheme.value
                        ? Colors.white
                        : Colors.black))),
            child: Obx(() => Checkbox(
                  value: source.private.value,
                  onChanged: (value) => source.private.toggle(),
                )),
          ),
        ),
        BsCol(
          margin: EdgeInsets.only(left: 10),
          sizes: ColScreen(lg: Col.col_3),
          child: FormGroup(
            label: Obx(() => Text(ScheduleText.labelBp,
                style: TextStyle(
                    color: _navigation.darkTheme.value
                        ? Colors.white
                        : Colors.black))),
            child: CustomSelectBox(
              searchable: true,
              disabled: source.isProcessing,
              controller: source.selectBp,
              hintText: BaseText.hiintSelect(field: ScheduleText.labelBp),
              serverSide: (params) => selectApiPartner(params),
              onChange: (value) {
                if (value.getValue() != null) {
                  source.isBpNotSelected.value = false;
                  _auth.bpActiveId.value = value.getValue();
                }
              },
            ),
          ),
        ),
        BsCol(
          margin: EdgeInsets.only(left: 10),
          sizes: ColScreen(lg: Col.col_3),
          child: FormGroup(
            label: Obx(() => Text(ScheduleText.labelToward,
                style: TextStyle(
                    color: _navigation.darkTheme.value
                        ? Colors.white
                        : Colors.black))),
            child: CustomSelectBox(
              searchable: true,
              disabled: source.isBpNotSelected.value,
              controller: source.selectToward,
              hintText: BaseText.hiintSelect(field: ScheduleText.labelToward),
              serverSide: (params) => selectApiProspectOwner(params),
            ),
          ),
        ),
      ],
    );
  }

  Widget inputOnLink() {
    return FormGroup(
      label: Obx(() => Text(ScheduleText.labelOnLink,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.online.value ? false : true,
        controller: source.inputOnLink,
        hintText: BaseText.hintText(field: ScheduleText.labelOnLink),
      ),
    );
  }

  Widget inputDesc() {
    return FormGroup(
      label: Obx(() => Text(ScheduleText.labelDesc,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputDesc,
        hintText: BaseText.hintText(field: ScheduleText.labelDesc),
      ),
    );
  }

  Widget inputRemind() {
    return FormGroup(
      label: Obx(() => Text(ScheduleText.labelRemind,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInputNumber(
        disabled: source.isProcessing,
        controller: source.inputRemind,
        hintText: BaseText.hintText(field: ScheduleText.labelRemind),
      ),
    );
  }

  _selectStartDates(BuildContext context) async {
    final DateTime? selectedStart = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (selectedStart != null) {
      source.selectedDateStart.value =
          '${selectedStart.year}-${selectedStart.month}-${selectedStart.day}';
    }
  }

  _selectEndDates(BuildContext context) async {
    final DateTime? selectedEnd = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (selectedEnd != null) {
      source.selectedDateEnd.value =
          '${selectedEnd.year}-${selectedEnd.month}-${selectedEnd.day}';
    }
  }

  _selectActDates(BuildContext context) async {
    final DateTime? selectedAct = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (selectedAct != null) {
      source.selectedDateAct.value =
          '${selectedAct.year}-${selectedAct.month}-${selectedAct.day}';
    }
  }

  _selectStartTimes(BuildContext context) async {
    final TimeOfDay? timeOfDayStart = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDayStart != null) {
      source.selectedTimeStart.value =
          '${timeOfDayStart.hour}:${timeOfDayStart.minute}';
    }
  }

  _selectEndTimes(BuildContext context) async {
    final TimeOfDay? timeOfDayEnd = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDayEnd != null) {
      source.selectedTimeEnd.value =
          '${timeOfDayEnd.hour}:${timeOfDayEnd.minute}';
    }
  }
}
