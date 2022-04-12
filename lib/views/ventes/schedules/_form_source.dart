import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:bs_flutter_inputtext/bs_flutter_inputtext.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../constants/base_text.dart';
import '../../../models/session_model.dart';
import '../../../utils/session_manager.dart';
import '../../../utils/validators.dart';
import '../../../utils/select_api.dart';
import '../../../widgets/form_group.dart';
import '../../../widgets/input/custom_input.dart';
import '../../../widgets/input/custom_input_number.dart';
import '../../../widgets/selectbox/custom_selectbox.dart';
import '_details_source.dart';
import '_map_source.dart';
import 'map.dart';
import '_text.dart';

class ScheduleSource extends GetxController {
  final map = Get.put(mapSource());
  bool isProcessing = false;

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
  BsSelectBoxController selectToward = BsSelectBoxController();
  BsSelectBoxController selectBp = BsSelectBoxController();

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
      'scheallday': allDay.value,
      'scheloc': map.coordinate.value,
      'scheprivate': private.value,
      'scheonline': online.value,
      'schetz': 'ID',
      'scheremind': inputRemind.text,
      'schedesc': inputDesc.text,
      'scheonlink': inputOnLink.text,
      'masterid': selectType.getSelectedAsString(),
      'createdby': session.userid,
      'updatedby': session.userid,
      'isactive': true,
    };
  }
}

class ScheduleForm {
  final c = Get.put(scheduleDetailsSource());
  final map = Get.put(mapSource());
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
              child: BsButton(
                style: BsButtonStyle(
                    color: Color.fromARGB(255, 165, 165, 165),
                    backgroundColor: Colors.white,
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
            label: Text(ScheduleText.labelEndDate),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: BsButton(
                  style: BsButtonStyle(
                      color: Color.fromARGB(255, 165, 165, 165),
                      backgroundColor: Colors.white,
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
          sizes: ColScreen(lg: Col.col_6),
          child: FormGroup(
            label: Text(ScheduleText.labelStartTime),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: BsButton(
                style: BsButtonStyle(
                    color: Color.fromARGB(255, 165, 165, 165),
                    backgroundColor: Colors.white,
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
          sizes: ColScreen(lg: Col.col_6),
          child: FormGroup(
            label: Text(ScheduleText.labelEndTime),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: BsButton(
                  style: BsButtonStyle(
                      color: Color.fromARGB(255, 165, 165, 165),
                      backgroundColor: Colors.white,
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
      ],
    );
  }

  Widget actDate(context) {
    return FormGroup(
      label: Text(ScheduleText.labelActDate),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: BsButton(
            style: BsButtonStyle(
                color: Color.fromARGB(255, 165, 165, 165),
                backgroundColor: Colors.white,
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
          sizes: ColScreen(lg: Col.col_6),
          child: FormGroup(
            label: Text(ScheduleText.labelType),
            child: CustomSelectBox(
              searchable: true,
              disabled: source.isProcessing,
              controller: source.selectType,
              hintText: BaseText.hiintSelect(),
              serverSide: (params) => selectApiTypeChildren(params),
              validators: [Validators.selectRequired(ScheduleText.labelType)],
            ),
          ),
        ),
        BsCol(
          margin: EdgeInsets.only(left: 10),
          sizes: ColScreen(lg: Col.col_6),
          child: FormGroup(
            label: Text(ScheduleText.labelBp),
            child: CustomSelectBox(
              searchable: true,
              disabled: source.isProcessing,
              controller: source.selectBp,
              hintText: BaseText.hiintSelect(),
              serverSide: (params) => selectApiPartner(params),
              validators: [Validators.selectRequired(ScheduleText.labelBp)],
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
            label: Text(ScheduleText.labelPlace),
            child: BsButton(
              style: BsButtonStyle(
                  color: Color.fromARGB(255, 165, 165, 165),
                  backgroundColor: Colors.white,
                  borderColor: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              width: MediaQuery.of(context).size.width,
              disabled: source.online.value ? true : false,
              onPressed: () => Get.to(GoogleMapsPage()),
              label: Obx(() => Text(map.coordinate.isEmpty
                  ? "Choose the Place"
                  : map.coordinate.value)),
            ),
          ),
        ),
        // BsCol(
        //   margin: EdgeInsets.only(left: 10),
        //   sizes: ColScreen(lg: Col.col_6),
        //   child: FormGroup(
        //     label: Text(ScheduleText.labelToward),
        //     child: CustomSelectBox(
        //       searchable: true,
        //       disabled: source.isProcessing,
        //       controller: source.selectToward,
        //       hintText: BaseText.hiintSelect(),
        //       serverSide: (params) => selectApiUser(params),
        //     ),
        //   ),
        // ),
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
            label: Text(ScheduleText.labelOnline),
            child: Obx(() => Checkbox(
                  value: source.online.value,
                  onChanged: (value) {
                    source.online.toggle();

                    map.coordinate.value = '';
                  },
                )),
          ),
        ),
        BsCol(
          margin: EdgeInsets.only(right: 10),
          sizes: ColScreen(lg: Col.col_2),
          child: FormGroup(
            label: Text(ScheduleText.labelAllDay),
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
            label: Text(ScheduleText.labelPrivate),
            child: Obx(() => Checkbox(
                  value: source.private.value,
                  onChanged: (value) => source.private.toggle(),
                )),
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
              validators: [Validators.selectRequired(ScheduleText.labelToward)],
            ),
          ),
        ),
      ],
    );
  }

  Widget inputOnLink() {
    return FormGroup(
      label: Text(ScheduleText.labelOnLink),
      child: CustomInput(
        disabled: source.online.value ? false : true,
        controller: source.inputOnLink,
        hintText: BaseText.hintText(),
      ),
    );
  }

  Widget inputDesc() {
    return FormGroup(
      label: Text(ScheduleText.labelDesc),
      child: CustomInput(
        disabled: source.isProcessing,
        controller: source.inputDesc,
        hintText: BaseText.hintText(),
      ),
    );
  }

  Widget inputRemind() {
    return FormGroup(
      label: Text(ScheduleText.labelRemind),
      child: CustomInputNumber(
        disabled: source.isProcessing,
        controller: source.inputRemind,
        hintText: BaseText.hintText(),
        validators: [Validators.maxLength(ScheduleText.labelRemind, 2)],
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
