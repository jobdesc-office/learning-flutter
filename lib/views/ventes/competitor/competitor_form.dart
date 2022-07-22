import 'package:boilerplate/views/skins/template.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/edit_view_contract.dart';
import '../../../models/masters/Competitor_model.dart';
import '../../../presenters/ventes/competitor_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/button/theme_button_cancel.dart';
import '../../../widgets/button/theme_button_save.dart';

import '../../../widgets/map/_map_source.dart';
import '_form_source.dart';

// ignore: must_be_immutable
class CompetitorFormView extends StatelessWidget implements EditViewContract {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final CompetitorPresenter presenter = Get.find<CompetitorPresenter>();
  final source = CompetitorSource().obs;
  final Function(FormData body) onSave;

  late CompetitorForm competitorForm;

  CompetitorFormView({required this.onSave}) {
    presenter.competitorFetchDataContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        title: 'Competitor Form',
        breadcrumbs: [
          BreadcrumbWidget('Venteses'),
          BreadcrumbWidget('Competitors', back: true),
          BreadcrumbWidget('Competitor Form', active: true),
        ],
        activeRoutes: [
          RouteList.ventes.index,
          RouteList.ventesCompetitor.index
        ],
        child: Obx(() {
          competitorForm = CompetitorForm(source.value);
          return Form(
            key: formState,
            child: BsRow(
              children: [
                BsCol(
                  sizes: ColScreen(sm: Col.col_5),
                  child: competitorForm.btnImage(),
                ),
                BsCol(
                  margin: EdgeInsets.only(left: 5),
                  sizes: ColScreen(sm: Col.col_7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      competitorForm.selectBp(),
                      competitorForm.inputName(),
                      competitorForm.inputProductName(),
                      competitorForm.selectTypes(),
                      // competitorForm.selectRef(),
                      competitorForm.inputDesciption(),
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
      onSave(FormData(await source.toJson()));
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
      CompetitorModel competitor = CompetitorModel.fromJson(response.body);
      if (competitor.comptbp != null)
        source.value.selectBp.setSelected(BsSelectBoxOption(
            value: competitor.comptbpid,
            text: Text(competitor.comptbp!.bpname!)));

      if (competitor.comptreftypeid != null)
        source.value.selectType.setSelected(BsSelectBoxOption(
            value: competitor.comptreftypeid,
            text: Text(competitor.comptreftype!.typename!)));

      if (competitor.comptpics != null) {
        source.value.isUpdate.value = true;
        source.value.isImage.value = false;
        List image = [];
        for (var item in competitor.comptpics!) {
          image.add(item.url);
        }
        source.value.imageupdate.value = image;
      }

      source.value.inputName.text = competitor.comptname ?? '';
      source.value.inputProductName.text = competitor.comptproductname ?? '';
      source.value.inputDesc.text = competitor.description ?? '';
    });
  }
}
