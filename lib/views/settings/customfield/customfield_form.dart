import 'package:boilerplate/views/skins/template.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/edit_view_contract.dart';
import '../../../models/ventes/customfield_model.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../presenters/settings/customfield_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../styles/color_palattes.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/button/theme_button_cancel.dart';
import '../../../widgets/button/theme_button_save.dart';

import '../../../widgets/form_group.dart';
import '_form_source.dart';

// ignore: must_be_immutable
class CustomFieldFormView extends StatelessWidget implements EditViewContract {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final CustomFieldPresenter presenter = Get.find<CustomFieldPresenter>();
  final source = CustomFieldSource().obs;
  final Function(dynamic body) onSave;
  final _navigation = Get.find<NavigationPresenter>();

  var isEdit = false.obs;

  late CustomFieldForm customFieldForm;

  CustomFieldFormView({required this.onSave}) {
    presenter.customFieldFetchDataContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        title: 'Custom Field Form',
        breadcrumbs: [
          BreadcrumbWidget('Ventes'),
          BreadcrumbWidget('Prospects'),
          BreadcrumbWidget('Custom Fields', back: true),
          BreadcrumbWidget('Custom Field Form', active: true),
        ],
        activeRoutes: [
          RouteList.master.index,
          RouteList.settingsCustomField.index
        ],
        child: Obx(() {
          customFieldForm = CustomFieldForm(source.value);
          return BsRow(
            children: [
              BsCol(
                sizes: ColScreen(
                  sm: Col.col_6,
                ),
                child: Form(
                  key: formState,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          customFieldForm.inputName(),
                          customFieldForm.selectBp(),
                          customFieldForm.selectTypes(),
                          customFieldForm.checkBoxForm()
                        ],
                      ),
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
              if (isEdit.value)
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
                                    label: Text('Is Active',
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

  void onClickSaveModal(BuildContext context) async {
    presenter.setProcessing(true);
    if (formState.currentState!.validate()) {
      onSave(await source.toJson());
    } else
      presenter.setProcessing(false);
  }

  void onClickCancelModal(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  void onSuccessFetchData(Response response) {
    presenter.setProcessing(false);
    isEdit.value = true;

    source.update((val) {
      CustomFieldModel customField = CustomFieldModel.fromJson(response.body);
      source.value.selectType.setSelected(BsSelectBoxOption(
          value: customField.custftype!.typeid,
          text: Text(customField.custftype!.typename.toString())));
      source.value.selectBp.setSelected(BsSelectBoxOption(
          value: customField.businesspartner!.bpid,
          text: Text(customField.businesspartner!.bpname.toString())));
      source.value.newprospect.value = customField.onlythisprospect ?? false;
      source.value.visible.value = customField.allprospect ?? false;
      source.value.inputName.text = customField.custfname ?? '';

      source.value.createdby.value =
          customField.custfcreatedby?.userfullname ?? '';
      source.value.createddate.value = customField.createddate ?? '';
      source.value.updatedby.value =
          customField.custfupdatedby?.userfullname ?? '';
      source.value.updateddate.value = customField.updateddate ?? '';
      source.value.isactive.value = customField.isactive ?? true;
    });
  }
}
