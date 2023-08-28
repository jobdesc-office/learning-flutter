part of '../../company.dart';

class _ProspectiveCustomerForm extends GetxController
    implements CustomerAddressContract, EditViewContract, IndexViewContract {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final controller = Get.put(ProspectiveCustomersFormController());
  ProspectiveCustomerPresenter presenter =
      Get.find<ProspectiveCustomerPresenter>();
  BpCustomerPresenter get bppresenter => Get.find<BpCustomerPresenter>();

  _ProspectiveCustomerForm() {
    presenter.customerAddresContract = this;
    presenter.customerAddressContract = this;
    presenter.customerFetchDataContract = this;
    presenter.customerViewContract = this;
  }

  var isEdit = false.obs;
  var isForm = false.obs;
  var show = true.obs;

  late ProspectiveCustomersFormSource source;

  Widget form(BuildContext context) {
    source = ProspectiveCustomersFormSource(controller);
    return Obx(() {
      return BsRow(
        children: [
          BsCol(
            sizes: ColScreen(
              sm: Col.col_9,
            ),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        source.checkBox(),
                        if (!controller.isRegistered.value)
                          BsRow(
                            children: [
                              BsCol(
                                margin: EdgeInsets.only(bottom: 10),
                                sizes: ColScreen(sm: Col.col_4),
                                child: BsRow(
                                  children: [
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
                                              source.inputPrefix(),
                                              source.inputName(),
                                              source.inputCode(),
                                              source.inputPhone(),
                                              source.selectTypes(context),
                                              source.inputReferal(),
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
                                        source.btnMap(context),
                                        Column(
                                          children: [
                                            source.inputProvince(),
                                            source.inputCity(),
                                            source.inputSubdistrict(),
                                            source.inputVillage(),
                                            source.inputPostal(),
                                            source.inputAddress(),
                                          ],
                                        ),
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
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: Colors.grey.shade300)),
                                      child: Container(
                                        margin: EdgeInsets.all(10),
                                        child: Column(
                                          children: [
                                            source.btnImage(),
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
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: Colors.grey.shade300)),
                                      child: Container(
                                        margin: EdgeInsets.all(10),
                                        child: Column(
                                          children: [
                                            source.selectCustomer(),
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
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color: Colors.grey.shade300)),
                                        child: Container(
                                          margin: EdgeInsets.all(10),
                                          child: Column(
                                            children: [
                                              source.btnImage(),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(10, 10, 0, 10),
                                        child: Obx(
                                          () => Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              ThemeButtonSave(
                                                disabled: presenter
                                                    .isProcessing.value,
                                                processing: presenter
                                                    .isProcessing.value,
                                                margin:
                                                    EdgeInsets.only(right: 5),
                                                onPressed: () =>
                                                    onClickSaveModal(context),
                                              ),
                                              ThemeButtonCancel(
                                                disabled: presenter
                                                    .isProcessing.value,
                                                margin:
                                                    EdgeInsets.only(right: 5),
                                                onPressed: () =>
                                                    onClickCancelModal(context),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (isEdit.value)
            BsCol(
              margin: EdgeInsets.only(left: 5),
              sizes: ColScreen(lg: Col.col_3),
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
                            child: FormGroupEdit(
                                label: Text('Created By',
                                    style: TextStyle(
                                        color: _navigation.darkTheme.value
                                            ? Colors.white
                                            : Colors.black)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(controller.createdby.value),
                                    Divider()
                                  ],
                                )),
                          ),
                          BsCol(
                            margin: EdgeInsets.only(top: 10),
                            child: FormGroupEdit(
                                label: Text('Created At',
                                    style: TextStyle(
                                        color: _navigation.darkTheme.value
                                            ? Colors.white
                                            : Colors.black)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(controller.createddate.value),
                                    Divider()
                                  ],
                                )),
                          ),
                          BsCol(
                            margin: EdgeInsets.only(top: 10),
                            child: FormGroupEdit(
                                label: Text('Last Updated By',
                                    style: TextStyle(
                                        color: _navigation.darkTheme.value
                                            ? Colors.white
                                            : Colors.black)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(controller.updatedby.value),
                                    Divider()
                                  ],
                                )),
                          ),
                          BsCol(
                            margin: EdgeInsets.only(top: 10),
                            child: FormGroupEdit(
                                label: Text('Last Updated At',
                                    style: TextStyle(
                                        color: _navigation.darkTheme.value
                                            ? Colors.white
                                            : Colors.black)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(controller.updateddate.value),
                                    Divider()
                                  ],
                                )),
                          ),
                          BsCol(
                            margin: EdgeInsets.only(top: 10),
                            child: FormGroupEdit(
                                label: Text('Is Active',
                                    style: TextStyle(
                                        color: _navigation.darkTheme.value
                                            ? Colors.white
                                            : Colors.black)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    if (controller.isactive.value)
                                      InkWell(
                                        child: Icon(
                                          Icons.toggle_on,
                                          size: 35,
                                          color: _navigation.darkTheme.value
                                              ? ColorPallates.onDarkMode
                                              : ColorPallates.onLightMode,
                                        ),
                                        onTap: controller.isactive.toggle,
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
                                        onTap: controller.isactive.toggle,
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
            ),
        ],
      );
    });
  }

  void onClickSaveModal(BuildContext context) async {
    presenter.setProcessing(true);
    if (isEdit.value) {
      presenter.update(context, await controller.toJson(), controller.id.value);
      isForm.value = false;
      isEdit.value = false;
      show.value = true;
    } else {
      if (formState.currentState!.validate()) {
        presenter.saveCustomer(context, FormData(await controller.toJson()));
      } else
        presenter.setProcessing(false);
    }
  }

  void onClickCancelModal(BuildContext context) {
    if (isEdit.value) {
      isEdit.value = false;
      isForm.toggle();
      show.toggle();
      controller.reset();
    } else {
      isForm.toggle();
      controller.reset();
    }
  }

  @override
  void onLoadAddressSuccess(Response response) {
    source = ProspectiveCustomersFormSource(controller);
    source.controller.isnGetLatLong.value = false;
    MapsLoc address = MapsLoc.fromJson(jsonDecode(response.body));
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
        controller.inputProvince.text = province;
        controller.inputCity.text = city;
        controller.inputSubdistrict.text = subdistrict;
        controller.inputVillage.text = village;
        controller.inputPostal.text = postalCode;
        controller.inputAddress.text = adres;
      }
    } catch (e) {
      Snackbar().unknowLocation();
    }
  }

  @override
  void onSuccessFetchData(Response response) {
    final map = Get.find<MapSource>();
    presenter.setProcessing(false);
    isEdit.value = true;
    isForm.value = true;

    CustomerModel customer = CustomerModel.fromJson(response.body);

    map.latitudelongitude.value =
        "${customer.cstmlatitude ?? ''},${customer.cstmlongitude ?? ''}";
    map.latitude.value = parseDouble(customer.cstmlatitude);
    map.longitude.value = parseDouble(customer.cstmlongitude);

    controller.id.value = customer.cstmid ?? 0;
    controller.inputPrefix.text = customer.cstmprefix ?? '';
    controller.inputName.text = customer.cstmname ?? '';
    controller.inputPhone.text = customer.cstmphone ?? '';
    controller.inputAddress.text = customer.cstmaddress ?? '';
    controller.selectType.setSelected(BsSelectBoxOption(
        value: customer.cstmtypeid,
        text: Text(customer.cstmtype?.typename ?? '')));
    controller.inputReferal.text = customer.referalcode ?? '';
    controller.inputProvince.text = customer.cstmprovince?.provname ?? '';
    controller.inputCity.text = customer.cstmcity?.cityname ?? '';
    controller.inputSubdistrict.text =
        customer.cstmsubdistrict?.subdistrictname ?? '';
    controller.inputVillage.text = customer.cstmvillage?.villagename ?? '';
    controller.inputPostal.text = customer.cstmpostalcode ?? '';

    controller.createdby.value = customer.custcreatedby?.userfullname ?? '';
    controller.createddate.value = customer.createddate ?? '';
    controller.updatedby.value = customer.custupdatedby?.userfullname ?? '';
    controller.updateddate.value = customer.updateddate ?? '';
    controller.isactive.value = customer.isactive ?? true;
  }

  @override
  void onCreateSuccess(Response response, {BuildContext? context}) {
    Snackbar().createSuccess(context!);
  }

  @override
  void onDeleteSuccess(Response response, {BuildContext? context}) {}

  @override
  void onEditSuccess(Response response, {BuildContext? context}) {}

  @override
  void onErrorRequest(Response response, {context}) {}

  @override
  void onLoadDatatables(BuildContext context, Response response) {}
}
