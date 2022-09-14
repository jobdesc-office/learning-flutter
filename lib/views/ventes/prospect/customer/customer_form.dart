import 'package:boilerplate/views/skins/template.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../contracts/master/customerAddress_contract.dart';
import '../../../../models/masters/maps_model.dart';
import '../../../../presenters/masters/customer_presenter.dart';
import '../../../../presenters/navigation_presenter.dart';
import '../../../../presenters/ventes/prospect_presenter.dart';

import '../../../../routes/route_list.dart';
import '../../../../styles/color_palattes.dart';
import '../../../../widgets/breadcrumb.dart';
import '../../../../widgets/button/theme_button_cancel.dart';
import '../../../../widgets/button/theme_button_save.dart';
import '../../../../widgets/snackbar.dart';
import '_form_source.dart';

// ignore: must_be_immutable
class PCustomerFormFormView extends StatelessWidget
    implements CustomerAddressContract {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final ProspectPresenter presenter = Get.find<ProspectPresenter>();
  final CustomerPresenter cpresenter = Get.find<CustomerPresenter>();
  final source = PCustomerSource().obs;
  final _navigation = Get.find<NavigationPresenter>();

  late PCustomerForm pCustomerForm;

  var isEdit = false.obs;
  var isForm = false.obs;

  PCustomerFormFormView() {
    cpresenter.customerAddresContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        title: 'Customer Form',
        breadcrumbs: [
          BreadcrumbWidget('Venteses'),
          BreadcrumbWidget('Prospects'),
          BreadcrumbWidget('Prospect Form', back: true),
          BreadcrumbWidget('Customer Form', active: true),
        ],
        activeRoutes: [RouteList.master.index, RouteList.ventesProspect.index],
        child: Obx(() {
          pCustomerForm = PCustomerForm(source.value);
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
                      pCustomerForm.checkBox(),
                      if (!source.value.isRegistered.value)
                        BsRow(
                          children: [
                            BsCol(
                              margin: EdgeInsets.only(bottom: 10),
                              sizes: ColScreen(sm: Col.col_4),
                              child: BsRow(
                                children: [
                                  BsCol(
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: Colors.grey.shade300)),
                                      child: Container(
                                        margin: EdgeInsets.all(10),
                                        child: Column(
                                          children: [
                                            pCustomerForm
                                                .selectBpCustomerTypes(),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  BsCol(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: Colors.grey.shade300)),
                                      child: Container(
                                        margin: EdgeInsets.all(10),
                                        child: Column(
                                          children: [
                                            pCustomerForm.inputPrefix(),
                                            pCustomerForm.inputName(),
                                            pCustomerForm.inputPhone(),
                                            pCustomerForm.selectTypes(),
                                            pCustomerForm.inputReferal(),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            BsCol(
                              margin: EdgeInsets.only(left: 10, bottom: 10),
                              sizes: ColScreen(sm: Col.col_4),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: Colors.grey.shade300)),
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      pCustomerForm.btnMap(context),
                                      pCustomerForm.inputProvince(),
                                      pCustomerForm.inputCity(),
                                      pCustomerForm.inputSubdistrict(),
                                      pCustomerForm.inputVillage(),
                                      pCustomerForm.inputPostal(),
                                      pCustomerForm.inputAddress(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            BsCol(
                              margin: EdgeInsets.only(left: 10, bottom: 10),
                              sizes: ColScreen(sm: Col.col_4),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: Colors.grey.shade300)),
                                    child: Container(
                                      margin: EdgeInsets.all(10),
                                      child: Column(
                                        children: [
                                          pCustomerForm.btnImage(),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: Colors.grey.shade300)),
                                    child: Container(
                                      margin: EdgeInsets.all(10),
                                      child: Column(
                                        children: [
                                          pCustomerForm.inputContactName(),
                                          // pCustomerForm.selectCustomer(),
                                          pCustomerForm.selectContactType(),
                                          pCustomerForm.inputValue(),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Obx(
                                    () => Container(
                                      margin: EdgeInsets.only(top: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          ThemeButtonSave(
                                            disabled:
                                                presenter.isProcessing.value,
                                            processing:
                                                presenter.isProcessing.value,
                                            margin: EdgeInsets.only(right: 5),
                                            onPressed: () =>
                                                onClickSaveModal(context),
                                          ),
                                          ThemeButtonCancel(
                                            disabled:
                                                presenter.isProcessing.value,
                                            margin: EdgeInsets.only(right: 5),
                                            onPressed: () =>
                                                onClickCancelModal(context),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      else
                        BsRow(
                          children: [
                            BsCol(
                              margin: EdgeInsets.only(left: 10, bottom: 10),
                              sizes: ColScreen(sm: Col.col_4),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: Colors.grey.shade300)),
                                    child: Container(
                                      margin: EdgeInsets.all(10),
                                      child: Column(
                                        children: [
                                          pCustomerForm.selectCustomer(),
                                          pCustomerForm.selectBpCustomerTypes(),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: Colors.grey.shade300)),
                                    child: Container(
                                      margin: EdgeInsets.all(10),
                                      child: Column(
                                        children: [
                                          pCustomerForm.btnImage(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            BsCol(
                              margin: EdgeInsets.only(left: 10, bottom: 10),
                              sizes: ColScreen(sm: Col.col_8),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: Colors.grey.shade300)),
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      pCustomerForm.inputContactName(),
                                      pCustomerForm.selectContactType(),
                                      pCustomerForm.inputValue(),
                                      Obx(
                                        () => Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            ThemeButtonSave(
                                              disabled:
                                                  presenter.isProcessing.value,
                                              processing:
                                                  presenter.isProcessing.value,
                                              margin: EdgeInsets.only(right: 5),
                                              onPressed: () =>
                                                  onClickSaveModal(context),
                                            ),
                                            ThemeButtonCancel(
                                              disabled:
                                                  presenter.isProcessing.value,
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
                              ),
                            )
                          ],
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
      presenter.saveCustomer(context, FormData(await source.value.toJson()));
    } else
      presenter.setProcessing(false);
  }

  void onClickCancelModal(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  void onLoadAddressSuccess(Response response) {
    pCustomerForm.source.isnGetLatLong.value = false;
    MapsLoc address = MapsLoc.fromJson(response.body);
    List<AddressComponents>? addresses =
        address.adresses?.first.addressComponents;

    try {
      if (addresses!
                  .firstWhere((element) =>
                      element.types!.contains('administrative_area_level_1'))
                  .longName !=
              null &&
          addresses
                  .firstWhere((element) =>
                      element.types!.contains('administrative_area_level_2'))
                  .longName !=
              null &&
          addresses
                  .firstWhere((element) =>
                      element.types!.contains('administrative_area_level_3'))
                  .longName !=
              null &&
          addresses
                  .firstWhere(
                      (element) => element.types!.contains('postal_code'))
                  .longName !=
              null &&
          address.adresses!.first.formattedAddress != null) {
        String province = addresses
                .firstWhere((element) =>
                    element.types!.contains('administrative_area_level_1'))
                .longName ??
            "";

        String cityy = addresses
                .firstWhere((element) =>
                    element.types!.contains('administrative_area_level_2'))
                .longName ??
            "";
        // replace word Kota, Kab, or Kabupaten with Empty String
        String city =
            cityy.replaceAll(RegExp(r'Kota |Kabupaten |Kab |Regency '), '');

        String subdistrictt = addresses
                .firstWhere((element) =>
                    element.types!.contains('administrative_area_level_3'))
                .longName ??
            "";

        String subdistrict =
            subdistrictt.replaceAll(RegExp(r'Kecamatan |Kec '), '');

        String village = addresses
                .firstWhere((element) =>
                    element.types!.contains('administrative_area_level_4'))
                .longName ??
            "";

        String postalCode = addresses
                .firstWhere((element) => element.types!.contains('postal_code'))
                .longName ??
            "";

        String adres = address.adresses!.first.formattedAddress ?? "";

        source.value.inputProvince.text = province;
        source.value.inputCity.text = city;
        source.value.inputSubdistrict.text = subdistrict;
        source.value.inputVillage.text = village;
        source.value.inputPostal.text = postalCode;
        source.value.inputAddress.text = adres;
      }
    } catch (e) {
      Snackbar().unknowLocation();
    }
  }
}
