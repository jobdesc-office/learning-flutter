import 'package:boilerplate/views/skins/template.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../contracts/base/edit_view_contract.dart';
import '../../../../models/ventes/prospectassign_model.dart';
import '../../../../presenters/ventes/prospectassign_presenter.dart';
import '../../../../routes/route_list.dart';
import '../../../../widgets/breadcrumb.dart';
import '../../../../widgets/button/theme_button_cancel.dart';
import '../../../../widgets/button/theme_button_save.dart';
import '_form_source.dart';

class ProspectAssignFormView extends StatelessWidget
    implements EditViewContract {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final ProspectAssignPresenter presenter = Get.find<ProspectAssignPresenter>();
  final source = ProspectAssignSource().obs;
  final Function(Map<String, dynamic> body) onSave;

  late ProspectAssignForm prospectForm;

  ProspectAssignFormView({required this.onSave, id}) {
    presenter.setProspectFetchDataContract = this;
    source.value.id.value = id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        title: 'Prospect Assign Form',
        breadcrumbs: [
          BreadcrumbWidget('Venteses'),
          BreadcrumbWidget('Prospect'),
          BreadcrumbWidget('Prospect Details', back: true),
          BreadcrumbWidget('Prospect Assign Form', active: true),
        ],
        activeRoutes: [RouteList.ventes.index, RouteList.ventesProspect.index],
        child: Obx(() {
          prospectForm = ProspectAssignForm(source.value);
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
                              prospectForm.selectAssign(),
                              prospectForm.selectReport(),
                              prospectForm.inputDesc(),
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
      ProspectAssignModel prospect =
          ProspectAssignModel.fromJson(response.body);
      source.value.selectAssign.setSelected(BsSelectBoxOption(
          value: prospect.prospectassignto,
          text: Text(prospect.prospectassign!.user!.userfullname.toString())));
      source.value.selectReport.setSelected(BsSelectBoxOption(
          value: prospect.prospectreportto,
          text: Text(prospect.prospectreport!.user!.userfullname.toString())));
      source.value.inputDesc.text = prospect.prospectassigndesc ?? '';
    });
  }
}
