import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../constants/base_text.dart';
import '../../../models/session_model.dart';
import '../../../utils/session_manager.dart';
import '../../../utils/validators.dart';
import '../../../utils/select_api.dart';
import '../../../widgets/form_group.dart';
import '../../../widgets/input/custom_input.dart';
import '../../../widgets/selectbox/custom_selectbox.dart';
import '../../masters/menus/_menu_type.dart';
import '_text.dart';

class ScheduleSource extends GetxController {
  bool isProcessing = false;

  var selectedDateStart = ''.obs;
  var selectedDateEnd = ''.obs;
  var selectedDateAct = ''.obs;
  var selectedTimeStart = ''.obs;
  var selectedTimeEnd = ''.obs;

  TextEditingController inputName = TextEditingController();
  TextEditingController inputIcon = TextEditingController();
  TextEditingController inputRoute = TextEditingController();
  TextEditingController inputColor = TextEditingController();
  TextEditingController inputSequence = TextEditingController();

  BsSelectBoxController selectType = BsSelectBoxController();
  BsSelectBoxController selectToward = BsSelectBoxController();
  BsSelectBoxController selectBp = BsSelectBoxController();

  Future<Map<String, dynamic>> toJson() async {
    SessionModel session = await SessionManager.current();
    return {
      'menunm': inputName.text,
      'masterid': selectType.getSelectedAsString(),
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

class ScheduleForm extends GetxController {
  final ScheduleSource source;

  ScheduleForm(this.source);

  Widget inputName() {
    return FormGroup(
      label: Text(ScheduleText.labelName),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputName,
        hintText: BaseText.hintText(),
        validators: [
          Validators.inputRequired(ScheduleText.labelName),
          Validators.maxLength(ScheduleText.labelName, 100),
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
            label: Text(ScheduleText.labelStartDate),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  _selectStartDates(context);
                },
                child: Obx(() => Text(source.selectedDateStart.isEmpty
                    ? "Choose Start Date"
                    : '${source.selectedDateStart}')),
              ),
            ),
          ),
        ),
        BsCol(
          margin: EdgeInsets.only(left: 10),
          sizes: ColScreen(lg: Col.col_6),
          child: FormGroup(
            label: Text(ScheduleText.labelEndDate),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                  onPressed: () {
                    _selectEndDates(context);
                  },
                  child: Obx(() => Text(source.selectedDateEnd.isEmpty
                      ? "Choose End Date"
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
          sizes: ColScreen(lg: Col.col_6),
          child: FormGroup(
            label: Text(ScheduleText.labelStartTime),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  _selectStartTimes(context);
                },
                child: Obx(() => Text(source.selectedTimeStart.isEmpty
                    ? "Choose Start Time"
                    : '${source.selectedTimeStart}')),
              ),
            ),
          ),
        ),
        BsCol(
          margin: EdgeInsets.only(left: 10),
          sizes: ColScreen(lg: Col.col_6),
          child: FormGroup(
            label: Text(ScheduleText.labelEndTime),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                  onPressed: () {
                    _selectEndTimes(context);
                  },
                  child: Obx(() => Text(source.selectedTimeEnd.isEmpty
                      ? "Choose End Time"
                      : '${source.selectedTimeEnd}'))),
            ),
          ),
        ),
      ],
    );
  }

  Widget actDate(context) {
    return FormGroup(
      label: Text(ScheduleText.labelActDate),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
            onPressed: () {
              _selectActDates(context);
            },
            child: Obx(() => Text(source.selectedDateAct.isEmpty
                ? "Choose Actual Date"
                : '${source.selectedDateAct}'))),
      ),
    );
  }

  Widget selectType() {
    return BsRow(
      children: [
        BsCol(
          margin: EdgeInsets.only(right: 10),
          sizes: ColScreen(lg: Col.col_6),
          child: FormGroup(
            label: Text(ScheduleText.labelType),
            child: CustomSelectBox(
              searchable: true,
              disabled: source.isProcessing,
              controller: source.selectType,
              hintText: BaseText.hiintSelect(),
              serverSide: (params) => selectApiTypeChildren(params),
            ),
          ),
        ),
        BsCol(
          margin: EdgeInsets.only(left: 10),
          sizes: ColScreen(lg: Col.col_6),
          child: FormGroup(
            label: Text(ScheduleText.labelToward),
            child: CustomSelectBox(
              searchable: true,
              disabled: source.isProcessing,
              controller: source.selectToward,
              hintText: BaseText.hiintSelect(),
              serverSide: (params) => selectApiUser(params),
            ),
          ),
        ),
      ],
    );
  }

  // Widget inputColor() {
  //   return FormGroup(
  //     label: Text(ScheduleText.labelColor),
  //     child: CustomInput(
  //       disabled: source.isProcessing,
  //       controller: source.inputColor,
  //       hintText: BaseText.hintText(),
  //       validators: [],
  //     ),
  //   );
  // }

  // Widget inputSequence() {
  //   return FormGroup(
  //     label: Text(ScheduleText.labelSequence),
  //     child: CustomInputNumber(
  //       disabled: source.isProcessing,
  //       controller: source.inputSequence,
  //       hintText: BaseText.hintText(),
  //       validators: [
  //         Validators.maxLength(ScheduleText.labelSequence, 100),
  //       ],
  //     ),
  //   );
  // }

  _selectStartDates(BuildContext context) async {
    final DateTime? selectedStart = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (selectedStart != null && selectedStart != source.selectedDateStart) {
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
    if (selectedEnd != null && selectedEnd != source.selectedDateEnd) {
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
    if (selectedAct != null && selectedAct != source.selectedDateEnd) {
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
    if (timeOfDayStart != null && timeOfDayStart != source.selectedTimeStart) {
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
    if (timeOfDayEnd != null && timeOfDayEnd != source.selectedTimeEnd) {
      source.selectedTimeEnd.value =
          '${timeOfDayEnd.hour}:${timeOfDayEnd.minute}';
    }
  }
}
