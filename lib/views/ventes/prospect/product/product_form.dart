import 'package:boilerplate/views/skins/template.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../presenters/masters/customer_presenter.dart';
import '../../../../presenters/navigation_presenter.dart';
import '../../../../presenters/ventes/prospect_detail_presenter.dart';
import '../../../../presenters/ventes/prospect_presenter.dart';

import '../../../../routes/route_list.dart';
import '../../../../styles/color_palattes.dart';
import '../../../../widgets/breadcrumb.dart';
import '../../../../widgets/button/theme_button_cancel.dart';
import '../../../../widgets/button/theme_button_save.dart';
import '_form_source.dart';

// ignore: must_be_immutable
class PProductFormFormView extends StatelessWidget {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final ProspectDetailPresenter presenter = Get.find<ProspectDetailPresenter>();
  final CustomerPresenter cpresenter = Get.find<CustomerPresenter>();
  final source = PProductSource().obs;
  final _navigation = Get.find<NavigationPresenter>();

  late PProductForm pProductForm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        title: 'Product Form',
        breadcrumbs: [
          BreadcrumbWidget('Ventes'),
          BreadcrumbWidget('Prospects'),
          BreadcrumbWidget('Prospect Form', back: true),
          BreadcrumbWidget('Product Form', active: true),
        ],
        activeRoutes: [RouteList.master.index, RouteList.ventesProspect.index],
        child: Obx(() {
          pProductForm = PProductForm(source.value);
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      pProductForm.inputName(),
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
    if (formState.currentState!.validate()) {
      presenter.saveProduct(context, await source.value.toJson());
    } else
      presenter.setProcessing(false);
  }

  void onClickCancelModal(BuildContext context) {
    Navigator.pop(context);
  }
}
