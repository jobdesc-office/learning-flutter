import 'package:boilerplate/views/skins/template.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/edit_view_contract.dart';
import '../../../models/masters/city_model.dart';
import '../../../presenters/masters/city_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../widgets/button/theme_button_cancel.dart';
import '../../../widgets/button/theme_button_save.dart';

import '_form_source.dart';

class CityFormView extends StatelessWidget implements EditViewContract {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final CityPresenter presenter = Get.find<CityPresenter>();
  final source = CitySource().obs;
  final Function(Map<String, dynamic> body) onSave;

  late CityForm cityForm;

  CityFormView({required this.onSave}) {
    presenter.cityFetchDataContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        activeRoutes: [RouteList.master.index, RouteList.masterCity.index],
        child: Obx(() {
          cityForm = CityForm(source.value);
          return Form(
            key: formState,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                cityForm.inputName(),
                cityForm.selectCountries(),
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
      CityModel city = CityModel.fromJson(response.body);
      source.value.inputName.text = city.cityname;
      source.value.selectProvince.setSelected(
          BsSelectBoxOption(value: city.provid, text: Text(city.provname)));
    });
  }
}
