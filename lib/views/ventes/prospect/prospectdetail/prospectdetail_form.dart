import 'package:boilerplate/views/skins/template.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../contracts/base/edit_view_contract.dart';
import '../../../../models/masters/type_model.dart';
import '../../../../models/ventes/prospectdetail_model.dart';
import '../../../../presenters/ventes/prospect_presenter.dart';
import '../../../../presenters/ventes/prospectdetail_presenter.dart';
import '../../../../routes/route_list.dart';
import '../../../../widgets/button/theme_button_cancel.dart';
import '../../../../widgets/button/theme_button_save.dart';
import '_form_source.dart';

class ProspectDetailFormView extends StatelessWidget
    implements EditViewContract {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final ProspectDetailPresenter presenter = Get.find<ProspectDetailPresenter>();
  final source = ProspectDetailSource().obs;
  final Function(Map<String, dynamic> body) onSave;

  late ProspectDetailForm prospectForm;

  ProspectDetailFormView({required this.onSave, id}) {
    presenter.setProspectFetchDataContract = this;
    source.value.id.value = id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
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
      ProspectDetailModel prospect =
          ProspectDetailModel.fromJson(response.body);
      source.value.selectType.setSelected(BsSelectBoxOption(
          value: prospect.prospectdttype!.typeid,
          text: Text(prospect.prospectdttype!.typename.toString())));
      source.value.selectCat.setSelected(BsSelectBoxOption(
          value: prospect.prospectdtcat!.typeid,
          text: Text(prospect.prospectdtcat!.typename.toString())));
      source.value.inputDesc.text = prospect.prospectdtdesc ?? '';
      source.value.selectedDateExpect.value = prospect.prospectdtdate ?? '';
      map.linkCoordinate.value = prospect.prospectdtloc ?? '';
    });
  }
}
