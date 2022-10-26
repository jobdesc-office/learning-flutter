import 'package:boilerplate/views/skins/template.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/edit_view_contract.dart';
import '../../../models/masters/Competitor_model.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../presenters/ventes/competitor_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../styles/color_palattes.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/button/theme_button_cancel.dart';
import '../../../widgets/button/theme_button_save.dart';

import '../../../widgets/form_group.dart';
import '../../../widgets/map/_map_source.dart';
import '_form_source.dart';

// ignore: must_be_immutable
class CompetitorFormView extends StatelessWidget implements EditViewContract {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final CompetitorPresenter presenter = Get.find<CompetitorPresenter>();
  final source = CompetitorSource().obs;
  final Function(FormData body) onSave;
  final _navigation = Get.find<NavigationPresenter>();

  var isEdit = false.obs;

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
          BreadcrumbWidget('Ventes'),
          BreadcrumbWidget('Competitors', back: true),
          BreadcrumbWidget('Competitor Form', active: true),
        ],
        activeRoutes: [
          RouteList.ventes.index,
          RouteList.ventesCompetitor.index
        ],
        child: Obx(() {
          competitorForm = CompetitorForm(source.value);
          return BsRow(
            children: [
              BsCol(
                sizes: ColScreen(
                  sm: Col.col_6,
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: _navigation.darkTheme.value
                        ? ColorPallates.elseDarkColor
                        : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Form(
                    key: formState,
                    child: BsRow(
                      children: [
                        BsCol(
                          sizes: ColScreen(sm: Col.col_5),
                          child: competitorForm.btnImage(context),
                        ),
                        BsCol(
                          margin: EdgeInsets.only(left: 5),
                          sizes: ColScreen(sm: Col.col_7),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                                      onPressed: () =>
                                          onClickSaveModal(context),
                                    ),
                                    ThemeButtonCancel(
                                      disabled: presenter.isProcessing.value,
                                      margin: EdgeInsets.only(right: 5),
                                      onPressed: () =>
                                          onClickCancelModal(context),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (isEdit.value)
                BsCol(
                  margin: EdgeInsets.only(left: 5),
                  sizes: ColScreen(lg: Col.col_6),
                  child: Obx(() => Container(
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
                                                color:
                                                    _navigation.darkTheme.value
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
                                                color:
                                                    _navigation.darkTheme.value
                                                        ? Colors.white
                                                        : Colors.black)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                source.value.createddate.value),
                                            Divider()
                                          ],
                                        )),
                                  ),
                                  BsCol(
                                    margin: EdgeInsets.only(top: 10),
                                    child: FormGroup(
                                        label: Text('Last Updated By',
                                            style: TextStyle(
                                                color:
                                                    _navigation.darkTheme.value
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
                                                color:
                                                    _navigation.darkTheme.value
                                                        ? Colors.white
                                                        : Colors.black)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                source.value.updateddate.value),
                                            Divider()
                                          ],
                                        )),
                                  ),
                                  BsCol(
                                    margin: EdgeInsets.only(top: 10),
                                    child: FormGroup(
                                        label: Text('Is Active',
                                            style: TextStyle(
                                                color:
                                                    _navigation.darkTheme.value
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
                                                  color: _navigation
                                                          .darkTheme.value
                                                      ? ColorPallates.onDarkMode
                                                      : ColorPallates
                                                          .onLightMode,
                                                ),
                                                onTap: () => source
                                                    .value.isactive
                                                    .toggle(),
                                              )
                                            else
                                              InkWell(
                                                child: Icon(
                                                  Icons.toggle_off,
                                                  size: 35,
                                                  color: _navigation
                                                          .darkTheme.value
                                                      ? ColorPallates
                                                          .offDarkMode
                                                      : ColorPallates
                                                          .offLightMode,
                                                ),
                                                onTap: () => source
                                                    .value.isactive
                                                    .toggle(),
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
                      )),
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
      Map<String, dynamic> images = {
        'transtypeid': source.value.transtypeid.value,
        'refid': source.value.refid.value
      };
      presenter.deleteImages(context, images);
      onSave(FormData(await source.toJson()));
    } else
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
    isEdit.value = true;

    source.update((val) {
      CompetitorModel competitor = CompetitorModel.fromJson(response.body);

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

      source.value.isUpdateImage.value = true;

      source.value.inputName.text = competitor.comptname ?? '';
      source.value.inputProductName.text = competitor.comptproductname ?? '';
      source.value.inputDesc.text = competitor.description ?? '';

      if (competitor.comptpics != []) {
        source.value.transtypeid.value =
            competitor.comptpics!.first.transtypeid!;
        source.value.refid.value = competitor.comptpics!.first.refid!;
      }

      source.value.createdby.value =
          competitor.comptcreatedby?.userfullname ?? '';
      source.value.createddate.value = competitor.createddate ?? '';
      source.value.updatedby.value =
          competitor.comptupdatedby?.userfullname ?? '';
      source.value.updateddate.value = competitor.updateddate ?? '';
      source.value.isactive.value = competitor.isactive ?? true;
    });
  }
}
