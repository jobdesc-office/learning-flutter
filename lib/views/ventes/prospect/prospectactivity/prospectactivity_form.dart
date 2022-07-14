import 'package:boilerplate/views/skins/template.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../contracts/base/edit_view_contract.dart';
import '../../../../models/ventes/prospectactivity_model.dart';
import '../../../../presenters/ventes/prospectactivity_presenter.dart';
import '../../../../routes/route_list.dart';
import '../../../../widgets/breadcrumb.dart';
import '../../../../widgets/button/theme_button_cancel.dart';
import '../../../../widgets/button/theme_button_save.dart';
import '_form_source.dart';

class ProspectActivityFormView extends StatelessWidget
    implements EditViewContract {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final ProspectActivityPresenter presenter =
      Get.find<ProspectActivityPresenter>();
  final source = ProspectActivitySource().obs;
  final Function(Map<String, dynamic> body) onSave;

  late final ProspectDetailForm prospectForm;

  ProspectActivityFormView({required this.onSave, id}) {
    presenter.setprospectFetchDataContract = this;
    source.value.id.value = id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        title: 'Prospect Activity Form',
        breadcrumbs: [
          BreadcrumbWidget('Venteses'),
          BreadcrumbWidget('Prospect'),
          BreadcrumbWidget('Prospect Details', back: true),
          BreadcrumbWidget('Prospect Activity Form', active: true),
        ],
        activeRoutes: [RouteList.ventes.index, RouteList.ventesProspect.index],
        child: Obx(() {
          prospectForm = ProspectDetailForm(source.value);
          return Form(
            key: formState,
            child: Column(
              children: [
                BsRow(
                  children: [
                    BsCol(
                      margin: EdgeInsets.only(right: 5),
                      sizes: ColScreen(sm: Col.col_12),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey.shade300)),
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              prospectForm.selectTypes(),
                              prospectForm.selectCategory(),
                              prospectForm.inputExpected(context),
                              prospectForm.inputDesc(),
                              prospectForm.selectUser(context),
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
    if (formState.currentState!.validate())
      onSave(await source.toJson());
    else
      presenter.setProcessing(false);
  }

  void onClickCancelModal(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  void onSuccessFetchData(Response response) {
    presenter.setProcessing(false);

    source.update((val) {
      ProspectActivityModel prospect =
          ProspectActivityModel.fromJson(response.body);
      source.value.selectType.setSelected(BsSelectBoxOption(
          value: prospect.prospectactivitytype!.typeid,
          text: Text(prospect.prospectactivitytype!.typename.toString())));
      source.value.selectCat.setSelected(BsSelectBoxOption(
          value: prospect.prospectactivitycat!.typeid,
          text: Text(prospect.prospectactivitycat!.typename.toString())));
      source.value.inputDesc.text = prospect.prospectactivitydesc ?? '';
      source.value.selectedDateExpect.value =
          prospect.prospectactivitydate ?? '';
      map.linkCoordinate.value = prospect.prospectactivityloc ?? '';
    });
  }
}
