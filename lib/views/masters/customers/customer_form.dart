import 'package:boilerplate/views/skins/template.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/edit_view_contract.dart';
import '../../../contracts/master/customerAddress_contract.dart';
import '../../../models/masters/customer_model.dart';
import '../../../models/masters/maps_model.dart';
import '../../../presenters/masters/customer_presenter.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../styles/color_palattes.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/button/theme_button_cancel.dart';
import '../../../widgets/button/theme_button_save.dart';

import '../../../widgets/form_group.dart';
import '../../../widgets/map/_map_source.dart';
import '../../../widgets/snackbar.dart';
import '_form_source.dart';

// ignore: must_be_immutable
class CustomerFormView extends StatelessWidget
    implements EditViewContract, CustomerAddressContract {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final CustomerPresenter presenter = Get.find<CustomerPresenter>();
  final source = CustomerSource().obs;
  final Function(Map<String, dynamic> body) onSave;
  final _navigation = Get.find<NavigationPresenter>();

  late CustomerForm customerForm;

  CustomerFormView({required this.onSave}) {
    presenter.customerFetchDataContract = this;
    presenter.customerAddresContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        title: 'Customer Form',
        breadcrumbs: [
          BreadcrumbWidget('Masters'),
          BreadcrumbWidget('Customers', back: true),
          BreadcrumbWidget('Customer Form', active: true),
        ],
        activeRoutes: [RouteList.master.index, RouteList.masterCustomer.index],
        child: Obx(() {
          customerForm = CustomerForm(source.value);
          return BsRow(
            children: [
              BsCol(
                sizes: ColScreen(sm: Col.col_6),
                child: Container(
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
                        BsRow(
                          children: [
                            BsCol(
                              margin: EdgeInsets.only(bottom: 10),
                              sizes: ColScreen(sm: Col.col_6),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: Colors.grey.shade300)),
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      customerForm.inputPrefix(),
                                      customerForm.inputName(),
                                      customerForm.inputPhone(),
                                      customerForm.selectTypes(),
                                      customerForm.inputReferal(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            BsCol(
                              margin: EdgeInsets.only(left: 10, bottom: 10),
                              sizes: ColScreen(sm: Col.col_6),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: Colors.grey.shade300)),
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      customerForm.btnMap(context),
                                      customerForm.inputProvince(),
                                      customerForm.inputCity(),
                                      customerForm.inputSubdistrict(),
                                      customerForm.inputVillage(),
                                      customerForm.inputPostal(),
                                      customerForm.inputAddress(),
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
                  ),
                ),
              ),
              BsCol(
                margin: EdgeInsets.only(left: 5),
                sizes: ColScreen(lg: Col.col_6),
                child: Container(
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
                                          color: _navigation.darkTheme.value
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
                                          color: _navigation.darkTheme.value
                                              ? Colors.white
                                              : Colors.black)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(source.value.createddate.value),
                                      Divider()
                                    ],
                                  )),
                            ),
                            BsCol(
                              margin: EdgeInsets.only(top: 10),
                              child: FormGroup(
                                  label: Text('Last Updated By',
                                      style: TextStyle(
                                          color: _navigation.darkTheme.value
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
                                          color: _navigation.darkTheme.value
                                              ? Colors.white
                                              : Colors.black)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(source.value.updateddate.value),
                                      Divider()
                                    ],
                                  )),
                            ),
                            BsCol(
                              margin: EdgeInsets.only(top: 10),
                              child: FormGroup(
                                  label: Text('Activation',
                                      style: TextStyle(
                                          color: _navigation.darkTheme.value
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
                                            color: _navigation.darkTheme.value
                                                ? ColorPallates.onDarkMode
                                                : ColorPallates.onLightMode,
                                          ),
                                          onTap: () =>
                                              source.value.isactive.toggle(),
                                        )
                                      else
                                        InkWell(
                                          child: Icon(
                                            Icons.toggle_off,
                                            size: 35,
                                            color: _navigation.darkTheme.value
                                                ? ColorPallates.offDarkMode
                                                : ColorPallates.offLightMode,
                                          ),
                                          onTap: () =>
                                              source.value.isactive.toggle(),
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
                ),
              )
            ],
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
    final map = Get.find<MapSource>();
    map.reset();
    Navigator.pop(context);
  }

  @override
  void onSuccessFetchData(Response response) {
    presenter.setProcessing(false);

    source.update((val) {
      CustomerModel customer = CustomerModel.fromJson(response.body);
      source.value.inputPrefix.text = customer.cstmprefix ?? '';
      source.value.inputName.text = customer.cstmname ?? '';
      source.value.inputPhone.text = customer.cstmphone ?? '';
      source.value.inputAddress.text = customer.cstmaddress ?? '';
      source.value.selectType.setSelected(BsSelectBoxOption(
          value: customer.cstmtypeid,
          text: Text(customer.cstmtype?.typename ?? '')));
      source.value.inputReferal.text = customer.referalcode ?? '';
      source.value.inputProvince.text = customer.cstmprovince?.provname ?? '';
      source.value.inputCity.text = customer.cstmcity?.cityname ?? '';
      source.value.inputSubdistrict.text =
          customer.cstmsubdistrict?.subdistrictname ?? '';
      source.value.inputVillage.text = customer.cstmvillage?.villagename ?? '';
      source.value.inputPostal.text = customer.cstmpostalcode ?? '';

      source.value.createdby.value = customer.custcreatedby?.userfullname ?? '';
      source.value.createddate.value = customer.createddate ?? '';
      source.value.updatedby.value = customer.custupdatedby?.userfullname ?? '';
      source.value.updateddate.value = customer.updateddate ?? '';
      source.value.isactive.value = customer.isactive ?? true;
    });
  }

  @override
  void onLoadAddressSuccess(Response response) {
    customerForm.source.isnGetLatLong.value = false;
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
