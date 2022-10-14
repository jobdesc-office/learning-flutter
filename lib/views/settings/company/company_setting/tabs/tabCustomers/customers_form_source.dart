part of '../../company.dart';

class _CustomerFormSource extends GetxController
    implements CustomerAddressContract, EditViewContract, IndexViewContract {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final source = PCustomersSource().obs;
  CustomerPresenter presenter = Get.find<CustomerPresenter>();
  BpCustomerPresenter get bppresenter => Get.find<BpCustomerPresenter>();

  _CustomerFormSource() {
    presenter.customerAddresContract = this;
    presenter.customerAddressContract = this;
    presenter.customerFetchDataContract = this;
  }

  var isEdit = false.obs;
  var isForm = false.obs;

  late PCustomersForm pCustomerForm;

  Widget form(BuildContext context) {
    pCustomerForm = PCustomersForm(source.value);
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
                                              pCustomerForm
                                                  .selectTypes(context),
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
                                        Column(
                                          children: [
                                            pCustomerForm.inputProvince(),
                                            pCustomerForm.inputCity(),
                                            pCustomerForm.inputSubdistrict(),
                                            pCustomerForm.inputVillage(),
                                            pCustomerForm.inputPostal(),
                                            pCustomerForm.inputAddress(),
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
                                            pCustomerForm.btnImage(),
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
                                            pCustomerForm.selectCustomer(),
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
                                              pCustomerForm.btnImage(),
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
                            child: FormGroup(
                                label: Text('Created By',
                                    style: TextStyle(
                                        color: _navigation.darkTheme.value
                                            ? Colors.white
                                            : Colors.black)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(source.value.updateddate.value),
                                    Divider()
                                  ],
                                )),
                          ),
                          BsCol(
                            margin: EdgeInsets.only(top: 10),
                            child: FormGroup(
                                label: Text('Is Active',
                                    style: TextStyle(
                                        color: _navigation.darkTheme.value
                                            ? Colors.white
                                            : Colors.black)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                        onTap: source.value.isactive.toggle,
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
                                        onTap: source.value.isactive.toggle,
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
      presenter.update(
          context, await source.value.toJson(), source.value.id.value);
    } else {
      if (formState.currentState!.validate()) {
        presenter.saveCustomer(context, FormData(await source.value.toJson()));
      } else
        presenter.setProcessing(false);
    }
  }

  void onClickCancelModal(BuildContext context) {
    if (isEdit.value) {
      isEdit.value = false;
      isForm.toggle();
      sources.value.reset();
    } else {
      isForm.toggle();
      sources.value.reset();
    }
  }

  @override
  void onLoadAddressSuccess(Response response) {
    pCustomerForm = PCustomersForm(source.value);
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
        source.update((val) {
          source.value.inputProvince.text = province;
          source.value.inputCity.text = city;
          source.value.inputSubdistrict.text = subdistrict;
          source.value.inputVillage.text = village;
          source.value.inputPostal.text = postalCode;
          source.value.inputAddress.text = adres;
        });
      }
    } catch (e) {
      Snackbar().unknowLocation();
    }
  }

  @override
  void onSuccessFetchData(Response response) {
    presenter.setProcessing(false);
    isEdit.value = true;
    isForm.value = true;

    source.update((val) {
      CustomerModel customer = CustomerModel.fromJson(response.body);
      source.value.id.value = customer.cstmid ?? 0;
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
  void onCreateSuccess(Response response, {BuildContext? context}) {
    Snackbar().createSuccess(context!);
  }

  @override
  void onDeleteSuccess(Response response, {BuildContext? context}) {}

  @override
  void onEditSuccess(Response response, {BuildContext? context}) {}

  @override
  void onErrorRequest(Response response) {}

  @override
  void onLoadDatatables(BuildContext context, Response response) {}
}
