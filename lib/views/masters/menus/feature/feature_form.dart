import 'package:boilerplate/contracts/base/index_view_contract.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../contracts/base/edit_view_contract.dart';
import '../../../../models/security/feature_model.dart';
import '../../../../presenters/masters/feature_presenter.dart';
import '../../../../presenters/navigation_presenter.dart';
import '../../../../routes/route_list.dart';
import '../../../../styles/color_palattes.dart';
import '../../../../widgets/breadcrumb.dart';
import '../../../../widgets/button/theme_button_cancel.dart';
import '../../../../widgets/button/theme_button_save.dart';
import '../../../skins/template.dart';
import '_form_source.dart';

class FeatureFormView extends GetView implements EditViewContract {
  final Function(Map<String, dynamic> body) onSave;
  final source = FeatureSource().obs;
  final _navigation = Get.find<NavigationPresenter>();
  final presenter = Get.find<FeaturePresenter>();
  final GlobalKey<FormState> formState = GlobalKey<FormState>();

  late FeatureForm menuForm;

  FeatureFormView({required this.onSave}) {
    presenter.featureFetchDataContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        title: 'Feature Form',
        breadcrumbs: [
          BreadcrumbWidget('Masters'),
          BreadcrumbWidget('Menus'),
          BreadcrumbWidget('Menu Details', back: true),
          BreadcrumbWidget('Feature Form', active: true),
        ],
        activeRoutes: [RouteList.master.index, RouteList.masterMenu.index],
        child: Obx(() {
          menuForm = FeatureForm(source.value);
          return Container(
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
                  menuForm.inputSlug(),
                  menuForm.inputDesc(),
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
      FeatureModel menu = FeatureModel.fromJson(response.body);
      source.value.inputName.text = menu.feattitle ?? '';
      source.value.inputSlug.text = menu.featslug ?? '';
      source.value.inputDesc.text = menu.featuredesc ?? '';
    });
  }
}
