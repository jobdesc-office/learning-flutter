import 'package:boilerplate/views/skins/template.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/edit_view_contract.dart';
import '../../../models/masters/subdistrict_model.dart';
import '../../../presenters/masters/subdistrict_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/button/theme_button_cancel.dart';
import '../../../widgets/button/theme_button_save.dart';

import '_form_source.dart';

class SubdistrictFormView extends StatelessWidget implements EditViewContract {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final SubdistrictPresenter presenter = Get.find<SubdistrictPresenter>();
  final source = SubdistrictSource().obs;
  final Function(Map<String, dynamic> body) onSave;

  late SubdistrictForm subdistrictForm;

  SubdistrictFormView({required this.onSave}) {
    presenter.subdistrictFetchDataContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        title: 'Subdistrict Form',
        breadcrumbs: [
          BreadcrumbWidget('Insight', route: RouteList.home.index),
          BreadcrumbWidget('Masters'),
          BreadcrumbWidget('Subdistricts', back: true),
          BreadcrumbWidget('Subdistrict Form', active: true),
        ],
        activeRoutes: [
          RouteList.master.index,
          RouteList.masterSubdistrict.index
        ],
        child: Obx(() {
          subdistrictForm = SubdistrictForm(source.value);
          return Form(
            key: formState,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                subdistrictForm.inputName(),
                subdistrictForm.selectCity(),
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
      SubdistrictModel subdistrict = SubdistrictModel.fromJson(response.body);
      source.value.inputName.text = subdistrict.subdistrictname;
      source.value.choosedCity.setSelected(BsSelectBoxOption(
          value: subdistrict.cityid, text: Text(subdistrict.cityname)));
    });
  }
}
