import 'package:boilerplate/views/skins/template.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/edit_view_contract.dart';
import '../../../models/masters/province_model.dart';
import '../../../presenters/masters/province_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../widgets/button/theme_button_cancel.dart';
import '../../../widgets/button/theme_button_save.dart';

import '_form_source.dart';

class ProvinceFormView extends StatelessWidget implements EditViewContract {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final ProvincePresenter presenter = Get.find<ProvincePresenter>();
  final source = ProvinceSource().obs;
  final Function(Map<String, dynamic> body) onSave;

  late ProvinceForm provinceForm;

  ProvinceFormView({required this.onSave}) {
    presenter.provinceFetchDataContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        activeRoutes: [RouteList.master.index, RouteList.masterProvince.index],
        child: Obx(() {
          provinceForm = ProvinceForm(source.value);
          return Form(
            key: formState,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                provinceForm.inputName(),
                provinceForm.selectCountry(),
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
      ProvinceModel province = ProvinceModel.fromJson(response.body);
      source.value.inputName.text = province.provname;
      source.value.selectCountry.setSelected(BsSelectBoxOption(
          value: province.countryid, text: Text(province.countryname)));
    });
  }
}
