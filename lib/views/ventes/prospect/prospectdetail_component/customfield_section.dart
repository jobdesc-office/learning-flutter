import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../constants/base_text.dart';
import '../../../../presenters/navigation_presenter.dart';
import '../../../../presenters/ventes/customfield_presenter.dart';
import '../../../../presenters/ventes/prospect_presenter.dart';
import '../../../../presenters/ventes/prospectcustomfield_presenter.dart';
import '../../../../styles/color_palattes.dart';
import '../../../../widgets/button/button_delete_datatable.dart';
import '../../../../widgets/button/button_edit_datatable.dart';
import '../../../../widgets/button/theme_button_cancel.dart';
import '../../../../widgets/button/theme_button_save.dart';
import '../../../../widgets/confirm_dialog.dart';
import '../_detail_source.dart';
import '_stagePipeline.dart';
import '../customfield/_form_source.dart';
import '../prospectcustomfield/_form_source.dart';

BsCol prospectDetailCustomFieldSection(context) {
  final _navigation = Get.find<NavigationPresenter>();
  final presenter = Get.find<ProspectPresenter>();
  final source = Get.put(prospectDetailsSource());
  final currencyFormatter = NumberFormat('#,##0.00', 'ID');
  final customFieldPresenter = Get.find<CustomFieldPresenter>();
  final prospectCustomFieldPresenter = Get.find<ProspectCustomFieldPresenter>();
  late ProspectCustomFieldForm prospectCustomFieldForm;
  late CustomFieldForm customFieldForm;
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final GlobalKey<FormState> formStateCF = GlobalKey<FormState>();
  final cfForm = ProspectCustomFieldSource().obs;
  final cfieldForm = CustomFieldSource().obs;

  void onClickSaveModal(BuildContext context) async {
    source.isAdd.value = false;
    prospectCustomFieldPresenter.setProcessing(true);
    if (source.isUpdate.value) {
      if (formState.currentState!.validate()) {
        prospectCustomFieldPresenter.update(
            context, await cfForm.toJson(), source.cfid.value);
        source.isUpdate.value = false;
        source.cfid.value = 0;
      } else {
        prospectCustomFieldPresenter.setProcessing(false);
        source.isUpdate.value = false;
      }
    } else {
      if (formState.currentState!.validate())
        prospectCustomFieldPresenter.save(context, await cfForm.toJson());
      else
        prospectCustomFieldPresenter.setProcessing(false);
    }
  }

  void onClickCancelModal(BuildContext context) {
    source.isAdd.value = false;
    source.isUpdate.value = false;
    cfForm.value.inputValue.text = '';
    cfForm.value.selectCustomfield.clear();
  }

  void onClickSave(BuildContext context) async {
    source.isAddCF.value = false;
    customFieldPresenter.setProcessing(true);
    if (formStateCF.currentState!.validate())
      customFieldPresenter.save(context, await cfieldForm.toJson());
    else
      customFieldPresenter.setProcessing(false);
  }

  void onClickCancel(BuildContext context) {
    source.isAddCF.value = false;
    cfieldForm.value.inputName.text = '';
    cfieldForm.value.selectType.clear();
    cfieldForm.value.visible.value = false;
    cfieldForm.value.newprospect.value = false;
  }

  return BsCol(
    child: Obx(() => Container(
          decoration: BoxDecoration(
            color: _navigation.darkTheme.value
                ? ColorPallates.elseDarkColor
                : Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Detail'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        BsButton(
                            size: BsButtonSize.btnSm,
                            onPressed: () {
                              source.isAddCF.toggle();
                              source.isAdd.value = false;
                            },
                            label: Tooltip(
                              message: 'Add Custom Field',
                              child: Icon(
                                Icons.add,
                                size: 13,
                              ),
                            )),
                        BsButton(
                            margin: EdgeInsets.only(left: 5),
                            size: BsButtonSize.btnSm,
                            onPressed: () {
                              source.isAdd.toggle();
                              source.isAddCF.value = false;
                            },
                            label: Tooltip(
                              message: 'Write Custom Field',
                              child: Icon(
                                Icons.edit,
                                size: 13,
                              ),
                            )),
                        BsButton(
                            margin: EdgeInsets.only(left: 5),
                            size: BsButtonSize.btnSm,
                            onPressed: () => customFieldPresenter.popup(
                                  context,
                                ),
                            label: Tooltip(
                                message: 'View Available Custom Field',
                                child: Text('Customize Fields')))
                      ],
                    ),
                  ],
                ),
                if (source.isAddCF.value)
                  AnimatedContainer(
                    margin: EdgeInsets.only(top: 10),
                    duration: Duration(seconds: 3),
                    child: Obx(() {
                      customFieldForm = CustomFieldForm(cfieldForm.value);
                      return Form(
                        key: formStateCF,
                        child: Column(
                          children: [
                            BsRow(
                              children: [
                                BsCol(
                                  margin: EdgeInsets.only(right: 5),
                                  sizes: ColScreen(sm: Col.col_12),
                                  child: Text('Add Custom Field',
                                      style: TextStyle(
                                          color: _navigation.darkTheme.value
                                              ? Colors.white
                                              : Colors.black)),
                                ),
                                BsCol(
                                  margin: EdgeInsets.only(right: 5),
                                  sizes: ColScreen(sm: Col.col_12),
                                  child: Container(
                                    child: Container(
                                      margin: EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          customFieldForm.inputName(),
                                          customFieldForm.selectTypes(),
                                          customFieldForm.checkBoxForm()
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Obx(
                              () => Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ThemeButtonSave(
                                    disabled: prospectCustomFieldPresenter
                                        .isProcessing.value,
                                    processing: presenter.isProcessing.value,
                                    margin: EdgeInsets.only(right: 5),
                                    onPressed: () => onClickSave(context),
                                  ),
                                  ThemeButtonCancel(
                                    disabled: prospectCustomFieldPresenter
                                        .isProcessing.value,
                                    margin: EdgeInsets.only(right: 5),
                                    onPressed: () => onClickCancel(context),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                if (source.isAdd.value)
                  AnimatedContainer(
                    margin: EdgeInsets.only(top: 10),
                    duration: Duration(seconds: 3),
                    child: Obx(() {
                      prospectCustomFieldForm =
                          ProspectCustomFieldForm(cfForm.value);
                      return Form(
                        key: formState,
                        child: Column(
                          children: [
                            BsRow(
                              children: [
                                BsCol(
                                  margin: EdgeInsets.only(right: 5),
                                  sizes: ColScreen(sm: Col.col_12),
                                  child: Text('Write Custom Field',
                                      style: TextStyle(
                                          color: _navigation.darkTheme.value
                                              ? Colors.white
                                              : Colors.black)),
                                ),
                                BsCol(
                                  margin: EdgeInsets.only(right: 5),
                                  sizes: ColScreen(sm: Col.col_12),
                                  child: Container(
                                    child: Container(
                                      margin: EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          prospectCustomFieldForm.selectCf(),
                                          prospectCustomFieldForm.inputValue(),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Obx(
                              () => Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ThemeButtonSave(
                                    disabled: prospectCustomFieldPresenter
                                        .isProcessing.value,
                                    processing: presenter.isProcessing.value,
                                    margin: EdgeInsets.only(right: 5),
                                    onPressed: () => onClickSaveModal(context),
                                  ),
                                  ThemeButtonCancel(
                                    disabled: prospectCustomFieldPresenter
                                        .isProcessing.value,
                                    margin: EdgeInsets.only(right: 5),
                                    onPressed: () =>
                                        onClickCancelModal(context),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                if (!source.isAddCF.value)
                  AnimatedContainer(
                    margin: EdgeInsets.only(top: 10),
                    duration: Duration(seconds: 3),
                    child: Column(
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: source.customField.length,
                            itemBuilder: (context, index) {
                              var customField = source.customField[index];

                              return InkWell(
                                onLongPress: () {
                                  Get.defaultDialog(
                                      middleText: '',
                                      title: 'Setting',
                                      actions: [
                                        ButtonEditDatatables(onPressed: () {
                                          prospectCustomFieldPresenter.edit(
                                              context,
                                              customField.prospectcfid!);
                                          source.cfid.value =
                                              customField.prospectcfid!;
                                        }),
                                        ButtonDeleteDatatables(onPressed: () {
                                          prospectCustomFieldPresenter.delete(
                                              context,
                                              customField.prospectcfid!,
                                              '${customField.prospectcfvalue}');
                                        }),
                                      ]);
                                },
                                child: BsRow(
                                  margin: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: ColorPallates.primary,
                                  ),
                                  padding: EdgeInsets.all(5),
                                  children: [
                                    BsCol(
                                        alignment: Alignment.center,
                                        sizes: ColScreen(sm: Col.col_5),
                                        child: Text(
                                            customField.customfield!.custfname!,
                                            style: TextStyle(
                                                color: Colors.white))),
                                    BsCol(
                                        alignment: Alignment.center,
                                        sizes: ColScreen(sm: Col.col_2),
                                        child: Text(':',
                                            style: TextStyle(
                                                color: Colors.white))),
                                    BsCol(
                                        alignment: Alignment.center,
                                        sizes: ColScreen(sm: Col.col_5),
                                        child: Text(
                                            customField.prospectcfvalue!,
                                            style: TextStyle(
                                                color: Colors.white))),
                                  ],
                                ),
                              );
                            }),
                        // Y
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: source.rawcustomField.length,
                            itemBuilder: (context, index) {
                              var rawcustomField = source.rawcustomField[index];

                              return InkWell(
                                onTap: () {
                                  source.isAdd.value = true;
                                  cfForm.value.format.value =
                                      rawcustomField.custftype!.typename!;
                                  cfForm.value.selectCustomfield.setSelected(
                                      BsSelectBoxOption(
                                          value: rawcustomField.custfid,
                                          text:
                                              Text(rawcustomField.custfname!)));
                                },
                                child: BsRow(
                                  margin: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: ColorPallates.tertiary,
                                  ),
                                  padding: EdgeInsets.all(5),
                                  children: [
                                    BsCol(
                                        alignment: Alignment.center,
                                        sizes: ColScreen(sm: Col.col_5),
                                        child: Text(
                                          rawcustomField.custfname!,
                                          style: TextStyle(color: Colors.white),
                                        )),
                                    BsCol(
                                        alignment: Alignment.center,
                                        sizes: ColScreen(sm: Col.col_2),
                                        child: Text(':',
                                            style: TextStyle(
                                                color: Colors.white))),
                                    BsCol(
                                        alignment: Alignment.center,
                                        sizes: ColScreen(sm: Col.col_5),
                                        child: Text('-',
                                            style: TextStyle(
                                                color: Colors.white))),
                                  ],
                                ),
                              );
                            }),
                      ],
                    ),
                  )
              ],
            ),
          ),
        )),
  );
}
