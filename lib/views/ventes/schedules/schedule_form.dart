import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:bs_flutter_modal/bs_flutter_modal.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/edit_view_contract.dart';
import '../../../models/Ventes/schedule_model.dart';
import '../../../presenters/Ventes/schedule_presenter.dart';
import '../../../widgets/button/button_role_user.dart';
import '../../../widgets/button/theme_button_cancel.dart';
import '../../../widgets/button/theme_button_save.dart';
import '../../masters/menus/_menu_type.dart';
import '_form_source.dart';
import '_map_source.dart';
import '_text.dart';

class ScheduleFormView extends StatelessWidget implements EditViewContract {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final map = Get.put(mapSource());
  final SchedulePresenter presenter = Get.find<SchedulePresenter>();
  final source = ScheduleSource().obs;
  final Function(Map<String, dynamic> body) onSave;

  late ScheduleForm menuForm;

  ScheduleFormView({required this.onSave}) {
    presenter.scheduleFetchDataContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formState,
      child: BsModal(
        context: context,
        dialog: BsModalDialog(
          size: BsModalSize.lg,
          child: BsModalContent(children: [
            BsModalContainer(
              title: Text(ScheduleText.title),
              closeButton: true,
            ),
            BsModalContainer(
              child: Obx(() {
                menuForm = ScheduleForm(source.value);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    menuForm.inputName(),
                    menuForm.checkBoxForm(),
                    menuForm.inputDate(context),
                    menuForm.inputTime(context),
                    menuForm.actDate(context),
                    menuForm.selectType(),
                    menuForm.selectUser(context),
                    menuForm.inputOnLink(),
                    menuForm.inputDesc(),
                    menuForm.inputRemind(),
                    Row(
                      children: [
                        BsButton(
                          style: BsButtonStyle(
                            backgroundColor: Colors.green.shade300,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          size: BsButtonSize(
                            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                            fontSize: 12,
                            iconSize: 14,
                          ),
                          label: Text('Add Member'),
                          onPressed: onClickAddRole,
                          // disabled: c.role >= 3 ? true : false,
                        )
                      ],
                    ),
                    menuForm.checkBoxTypeForm(
                        onRemoveItem: onClickRemoveRoleItem)
                  ],
                );
              }),
            ),
            BsModalContainer(
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ThemeButtonSave(
                      disabled: presenter.isProcessing.value,
                      processing: presenter.isProcessing.value,
                      margin: EdgeInsets.only(right: 5),
                      onPressed: () => onClickSaveModal(context),
                    ),
                    ThemeButtonCancel(
                      disabled: presenter.isProcessing.value,
                      margin: EdgeInsets.only(right: 5),
                      onPressed: () => onClickCancelModal(context),
                    ),
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }

  void onClickAddRole() {
    source.update((val) {
      source.value.selectsMember.add(BsSelectBoxController());
      source.value.selectsPermission.add(BsSelectBoxController(options: [
        BsSelectBoxOption(value: '{1}', text: Text('Read Only')),
        BsSelectBoxOption(value: '{2}', text: Text('Add Member')),
        BsSelectBoxOption(value: '{3}', text: Text('Share Link')),
        BsSelectBoxOption(value: '{2,3}', text: Text('Add Member & Share Link'))
      ]));
    });
  }

  void onClickRemoveRoleItem(int index) {
    source.update((val) {
      source.value.selectsMember.removeAt(index);
      source.value.selectsPermission.removeAt(index);
    });
  }

  void onClickSaveModal(BuildContext context) async {
    presenter.setProcessing(true);
    if (formState.currentState!.validate()) onSave(await source.toJson());
  }

  void onClickCancelModal(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  void onSuccessFetchData(Response response) {
    presenter.setProcessing(false);

    source.update((val) {
      ScheduleModel menu = ScheduleModel.fromJson(response.body);
      source.value.inputName.text = menu.schenm;
      source.value.inputOnLink.text = menu.link;
      source.value.inputDesc.text = menu.schedesc;
      source.value.inputRemind.text = menu.remind;

      source.value.selectType.setSelected(
          BsSelectBoxOption(value: menu.typeid, text: Text(menu.typename)));
      source.value.selectToward.setSelected(
          BsSelectBoxOption(value: menu.userid, text: Text(menu.userfullname)));
      source.value.selectBp.setSelected(
          BsSelectBoxOption(value: menu.bpid, text: Text(menu.bpname)));

      source.value.selectedDateStart.value = menu.schestartdate;
      source.value.selectedDateEnd.value = menu.scheenddate;
      source.value.selectedDateAct.value = menu.scheactdate;
      source.value.selectedTimeStart.value = menu.schestarttime;
      source.value.selectedTimeEnd.value = menu.scheendtime;
      source.value.inputOnLink.text = menu.link;
      source.value.online.value = menu.online;
      source.value.allDay.value = menu.allday;
      source.value.private.value = menu.private;
      map.coordinate.value = menu.loc;
    });
  }
}
