import 'package:boilerplate/styles/color_palattes.dart';
import 'package:boilerplate/views/skins/template.dart';
import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/edit_view_contract.dart';
import '../../../contracts/base/index_view_contract.dart';
import '../../../models/ventes/schedule_model.dart';
import '../../../presenters/ventes/schedule_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../widgets/button/theme_button_cancel.dart';
import '../../../widgets/button/theme_button_save.dart';
import '../../../widgets/map/_map_source.dart';
import '../../../widgets/snackbar.dart';
import '_form_source.dart';
import '_text.dart';

class ScheduleFormView extends StatelessWidget
    implements IndexViewContract, EditViewContract {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final map = Get.put(mapSource());
  final SchedulePresenter presenter = Get.find<SchedulePresenter>();
  final source = ScheduleSource().obs;
  final Function(Map<String, dynamic> body) onSave;

  late ScheduleForm menuForm;

  ScheduleFormView({required this.onSave}) {
    presenter.scheduleFetchDataContract = this;
    presenter.scheduleViewContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        activeRoutes: [RouteList.master.index, RouteList.ventesSchedule.index],
        child: Obx(() {
          menuForm = ScheduleForm(source.value);
          return Form(
            key: formState,
            child: Column(
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
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: BsButton(
                        style: BsButtonStyle(
                          backgroundColor: ColorPallates.secondary,
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        size: BsButtonSize(
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                          fontSize: 12,
                          iconSize: 14,
                        ),
                        label: Text('Add ' + ScheduleText.labelGuest),
                        onPressed: onClickAddRole,
                        // disabled: c.role >= 3 ? true : false,
                      ),
                    )
                  ],
                ),
                menuForm.checkBoxTypeForm(onRemoveItem: onClickRemoveRoleItem),
                Obx(
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
              ],
            ),
          );
        }),
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
    if (formState.currentState!.validate())
      onSave(await source.toJson());
    else
      presenter.setProcessing(false);
  }

  void onClickCancelModal(BuildContext context) {
    final map = Get.find<mapSource>();
    map.reset();
    Navigator.pop(context);
  }

  @override
  void onSuccessFetchData(Response response) {
    presenter.setProcessing(false);

    source.update((val) {
      ScheduleModel menu = ScheduleModel.fromJson(response.body);
      source.value.inputName.text = menu.schenm ?? '';
      source.value.inputOnLink.text = menu.scheonlink ?? '';
      source.value.inputDesc.text = menu.schedesc ?? '';
      source.value.inputRemind.text = menu.scheremind.toString();

      source.value.selectType.setSelected(BsSelectBoxOption(
          value: menu.schetype!.typeid,
          text: Text(menu.schetype!.typename.toString())));
      source.value.selectToward.setSelected(BsSelectBoxOption(
          value: menu.schebp!.bpid,
          text: Text(menu.schebp!.bpname.toString())));
      source.value.selectTimeZone.setSelected(
          BsSelectBoxOption(value: menu.schetz, text: Text(menu.schetz!)));

      // source.value.selectsMember.add(BsSelectBoxController());
      // source.value.selectsPermission.add(BsSelectBoxController(options: [
      //   BsSelectBoxOption(value: '{1}', text: Text('Read Only')),
      //   BsSelectBoxOption(value: '{2}', text: Text('Add Member')),
      //   BsSelectBoxOption(value: '{3}', text: Text('Share Link')),
      //   BsSelectBoxOption(value: '{2,3}', text: Text('Add Member & Share Link'))
      // ]));
      String x;
      for (var item in menu.scheguest!) {
        switch (item.schepermisid) {
          case '{1}':
            x = 'Read Only';
            break;
          case '{2}':
            x = 'Add Member';
            break;
          case '{3}':
            x = 'Share Link';
            break;
          default:
            x = 'Add Member & Share Link';
            break;
        }
        source.value.selectsMember.add(BsSelectBoxController(selected: [
          BsSelectBoxOption(
              value: item.scheuser!.userid,
              text: Text(item.scheuser!.userfullname!))
        ]));
        source.value.selectsPermission.add(BsSelectBoxController(selected: [
          BsSelectBoxOption(value: item.schepermisid, text: Text(x))
        ], options: [
          BsSelectBoxOption(value: '{1}', text: Text('Read Only')),
          BsSelectBoxOption(value: '{2}', text: Text('Add Member')),
          BsSelectBoxOption(value: '{3}', text: Text('Share Link')),
          BsSelectBoxOption(
              value: '{2,3}', text: Text('Add Member & Share Link'))
        ]));
      }

      source.value.selectedDateStart.value = menu.schestartdate ?? '';
      source.value.selectedDateEnd.value = menu.scheenddate ?? '';
      source.value.selectedDateAct.value = menu.scheactdate ?? '';
      source.value.selectedTimeStart.value = menu.schestarttime ?? '';
      source.value.selectedTimeEnd.value = menu.scheendtime ?? '';
      source.value.inputOnLink.text = menu.scheonlink ?? '';
      source.value.online.value = menu.scheonline ?? false;
      source.value.allDay.value = menu.scheallday ?? false;
      source.value.private.value = menu.scheprivate ?? false;
      map.linkCoordinate.value = menu.scheloc ?? '';
    });
  }

  @override
  void onCreateSuccess(Response response, {BuildContext? context}) {
    presenter.setProcessing(false);
    Snackbar().createSuccess();
    Navigator.pop(context!);
    Navigator.pop(context);
  }

  @override
  void onDeleteSuccess(Response response, {BuildContext? context}) {
    presenter.setProcessing(false);
    Snackbar().deleteSuccess();
    Navigator.pop(context!);
    Navigator.pop(context);
  }

  @override
  void onEditSuccess(Response response, {BuildContext? context}) {
    presenter.setProcessing(false);
    Snackbar().editSuccess();
    Navigator.pop(context!);
    Navigator.pop(context);
  }

  @override
  void onErrorRequest(Response response) {
    // TODO: implement onErrorRequest
  }

  @override
  void onLoadDatatables(BuildContext context, Response response) {
    // TODO: implement onLoadDatatables
  }
}
