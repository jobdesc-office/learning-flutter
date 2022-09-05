import 'package:boilerplate/styles/color_palattes.dart';
import 'package:boilerplate/views/skins/template.dart';
import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/edit_view_contract.dart';
import '../../../contracts/base/index_view_contract.dart';
import '../../../models/ventes/schedule_model.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../presenters/ventes/schedule_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/button/theme_button_cancel.dart';
import '../../../widgets/button/theme_button_save.dart';
import '../../../widgets/form_group.dart';
import '../../../widgets/map/_map_source.dart';
import '../../../widgets/snackbar.dart';
import '_form_source.dart';
import '_text.dart';

// ignore: must_be_immutable
class ScheduleFormView extends StatelessWidget
    implements IndexViewContract, EditViewContract {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final map = Get.put(MapSource());
  final SchedulePresenter presenter = Get.find<SchedulePresenter>();
  final source = ScheduleSource().obs;
  final Function(Map<String, dynamic> body) onSave;
  final _navigation = Get.find<NavigationPresenter>();

  late ScheduleForm menuForm;

  ScheduleFormView({required this.onSave}) {
    presenter.scheduleFetchDataContract = this;
    presenter.scheduleViewContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        title: ScheduleText.title + ' Form',
        breadcrumbs: [
          BreadcrumbWidget('Venteses'),
          BreadcrumbWidget('Schedules', back: true),
          BreadcrumbWidget('Schedule Form', active: true),
        ],
        activeRoutes: [RouteList.master.index, RouteList.ventesSchedule.index],
        child: Obx(() {
          menuForm = ScheduleForm(source.value);
          return BsRow(
            children: [
              BsCol(
                sizes: ColScreen(
                  sm: Col.col_6,
                ),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: _navigation.darkTheme.value
                        ? ColorPallates.elseDarkColor
                        : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Form(
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
                        menuForm.checkBoxTypeForm(
                            onRemoveItem: onClickRemoveRoleItem),
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
                  ),
                ),
              ),
              BsCol(
                margin: EdgeInsets.only(left: 5),
                sizes: ColScreen(lg: Col.col_6),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: _navigation.darkTheme.value
                        ? ColorPallates.elseDarkColor
                        : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: BsRow(
                    children: [
                      BsCol(
                        child: BsRow(
                          children: [
                            BsCol(
                              child: FormGroup(
                                  label: Text('Created By',
                                      style: TextStyle(
                                          color: _navigation.darkTheme.value
                                              ? Colors.white
                                              : Colors.black)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(source.value.createdby.value),
                                      Divider()
                                    ],
                                  )),
                            ),
                            BsCol(
                              margin: EdgeInsets.only(top: 10),
                              child: FormGroup(
                                  label: Text('Created At',
                                      style: TextStyle(
                                          color: _navigation.darkTheme.value
                                              ? Colors.white
                                              : Colors.black)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(source.value.createddate.value),
                                      Divider()
                                    ],
                                  )),
                            ),
                            BsCol(
                              margin: EdgeInsets.only(top: 10),
                              child: FormGroup(
                                  label: Text('Last Updated By',
                                      style: TextStyle(
                                          color: _navigation.darkTheme.value
                                              ? Colors.white
                                              : Colors.black)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(source.value.updatedby.value),
                                      Divider()
                                    ],
                                  )),
                            ),
                            BsCol(
                              margin: EdgeInsets.only(top: 10),
                              child: FormGroup(
                                  label: Text('Last Updated At',
                                      style: TextStyle(
                                          color: _navigation.darkTheme.value
                                              ? Colors.white
                                              : Colors.black)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(source.value.updateddate.value),
                                      Divider()
                                    ],
                                  )),
                            ),
                            BsCol(
                              margin: EdgeInsets.only(top: 10),
                              child: FormGroup(
                                  label: Text('Activation',
                                      style: TextStyle(
                                          color: _navigation.darkTheme.value
                                              ? Colors.white
                                              : Colors.black)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (source.value.isactive.value)
                                        InkWell(
                                          child: Icon(
                                            Icons.toggle_on,
                                            size: 35,
                                            color: _navigation.darkTheme.value
                                                ? ColorPallates.onDarkMode
                                                : ColorPallates.onLightMode,
                                          ),
                                          onTap: () =>
                                              source.value.isactive.toggle(),
                                        )
                                      else
                                        InkWell(
                                          child: Icon(
                                            Icons.toggle_off,
                                            size: 35,
                                            color: _navigation.darkTheme.value
                                                ? ColorPallates.offDarkMode
                                                : ColorPallates.offLightMode,
                                          ),
                                          onTap: () =>
                                              source.value.isactive.toggle(),
                                        ),
                                      Divider()
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
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
    if (source.value.selectedDateStart.value == '') {
      Get.defaultDialog(title: 'Warning', middleText: 'Start Date is Required');
      return;
    }
    presenter.setProcessing(true);
    if (formState.currentState!.validate())
      onSave(await source.toJson());
    else
      presenter.setProcessing(false);
  }

  void onClickCancelModal(BuildContext context) {
    final map = Get.find<MapSource>();
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
      if (menu.scheremind != null) {
        source.value.inputRemind.text = menu.scheremind.toString();
      }

      source.value.isBpNotSelected.value = false;

      source.value.selectType.setSelected(BsSelectBoxOption(
          value: menu.schetype!.typeid,
          text: Text(menu.schetype!.typename.toString())));
      if (menu.schereftype != null) {
        source.value.selectRefType.setSelected(BsSelectBoxOption(
            value: menu.schereftype!.typeid,
            text: Text(menu.schereftype!.typename.toString())));
      }
      source.value.selectBp.setSelected(BsSelectBoxOption(
          value: menu.schebpid, text: Text(menu.schebp!.bpname.toString())));
      source.value.selectToward.setSelected(BsSelectBoxOption(
          value: menu.schetoward!.userid,
          text: Text(menu.schetoward!.userfullname.toString())));

      if (menu.schetz != null) {
        source.value.selectTimeZone.setSelected(
            BsSelectBoxOption(value: menu.schetz, text: Text(menu.schetz!)));
      }

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

      source.value.createdby.value = menu.schecreatedby?.userfullname ?? '';
      source.value.createddate.value = menu.createddate ?? '';
      source.value.updatedby.value = menu.scheupdatedby?.userfullname ?? '';
      source.value.updateddate.value = menu.updateddate ?? '';
      source.value.isactive.value = menu.isactive ?? true;
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
  void onErrorRequest(Response response) {}

  @override
  void onLoadDatatables(BuildContext context, Response response) {}
}
