import 'package:boilerplate/views/skins/template.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/edit_view_contract.dart';
import '../../../models/ventes/customfield_model.dart';
import '../../../presenters/ventes/customfield_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/button/theme_button_cancel.dart';
import '../../../widgets/button/theme_button_save.dart';

import '_form_source.dart';

// ignore: must_be_immutable
class CustomFieldFormView extends StatelessWidget implements EditViewContract {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final CustomFieldPresenter presenter = Get.find<CustomFieldPresenter>();
  final source = CustomFieldSource().obs;
  final Function(dynamic body) onSave;

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
          BreadcrumbWidget('Venteses'),
          BreadcrumbWidget('Prospects'),
          BreadcrumbWidget('Custom Fields', back: true),
          BreadcrumbWidget('Custom Field Form', active: true),
        ],
        activeRoutes: [
          RouteList.master.index,
          RouteList.ventesCustomField.index
        ],
        child: Obx(() {
          customFieldForm = CustomFieldForm(source.value);
          return Form(
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

    source.update((val) {
      CustomFieldModel customField = CustomFieldModel.fromJson(response.body);
      source.value.selectType.setSelected(BsSelectBoxOption(
          value: customField.custftype!.typeid,
          text: Text(customField.custftype!.typename.toString())));
      source.value.selectBp.setSelected(BsSelectBoxOption(
          value: customField.businesspartner!.bpid,
          text: Text(customField.businesspartner!.bpname.toString())));
      source.value.newprospect.value = customField.onlyinnewprospect ?? false;
      source.value.visible.value = customField.isvisiblesidebar ?? false;
      source.value.inputName.text = customField.custfname ?? '';
    });
  }
}
