part of '../../company.dart';

class _TabGeneral extends StatelessWidget implements EditViewContract, IndexViewContract {
  final _source = GeneralSource().obs;
  GeneralSource get source => _source.value;
  CPGeneralPresenter get presenter => Get.find<CPGeneralPresenter>();

  final typePresenter = Get.find<TypesChildrenPresenter>();

  _TabGeneral() {
    presenter.businessPartnerFetchDataContract = this;
    presenter.businessPartnerViewContract = this;
    typePresenter.typeChildrenViewContract = this;
    fetchData();
  }

  void fetchData() {
    int? bpid = GetStorage().read('mybpid');
    presenter.edit(bpid!);
  }

  @override
  Widget build(BuildContext context) {
    return BsRow(
      margin: EdgeInsets.all(20),
      children: [
        BsCol(
          child: BsRow(
            children: [
              BsCol(
                margin: EdgeInsets.only(top: 15),
                alignment: Alignment.centerLeft,
                sizes: ColScreen(sm: Col.col_2),
                child: Text('Name'),
              ),
              BsCol(
                sizes: ColScreen(sm: Col.col_10),
                child: CustomInput(controller: source.inputName),
              ),
            ],
          ),
        ),
        BsCol(
          margin: EdgeInsets.only(top: 10),
          child: BsRow(
            children: [
              BsCol(
                margin: EdgeInsets.only(top: 15),
                alignment: Alignment.centerLeft,
                sizes: ColScreen(sm: Col.col_2),
                child: Text('PIC'),
              ),
              BsCol(
                sizes: ColScreen(sm: Col.col_10),
                child: CustomInput(controller: source.inputPIC),
              ),
            ],
          ),
        ),
        BsCol(
          margin: EdgeInsets.only(top: 10),
          child: BsRow(
            children: [
              BsCol(
                margin: EdgeInsets.only(top: 15),
                alignment: Alignment.centerLeft,
                sizes: ColScreen(sm: Col.col_2),
                child: Text('Phone'),
              ),
              BsCol(
                sizes: ColScreen(sm: Col.col_10),
                child: CustomInput(controller: source.inputPhone),
              ),
            ],
          ),
        ),
        BsCol(
          margin: EdgeInsets.only(top: 10),
          child: BsRow(
            children: [
              BsCol(
                margin: EdgeInsets.only(top: 15),
                alignment: Alignment.centerLeft,
                sizes: ColScreen(sm: Col.col_2),
                child: Text('Email'),
              ),
              BsCol(
                sizes: ColScreen(sm: Col.col_10),
                child: CustomInput(controller: source.inputEmail),
              ),
            ],
          ),
        ),
        BsCol(
          margin: EdgeInsets.only(top: 10),
          child: BsRow(
            children: [
              BsCol(
                margin: EdgeInsets.only(top: 15),
                alignment: Alignment.centerLeft,
                sizes: ColScreen(sm: Col.col_2),
                child: Text('Allow daily activity anytime'),
              ),
              BsCol(
                alignment: Alignment.centerLeft,
                sizes: ColScreen(sm: Col.col_10),
                child: Obx(() {
                  return Cetekan(source.allowDayAct.value, onTap: (value) => source.allowDayAct.value = value);
                }),
              ),
            ],
          ),
        ),
        BsCol(
          margin: EdgeInsets.only(top: 10),
          child: BsRow(
            children: [
              BsCol(
                margin: EdgeInsets.only(top: 15),
                alignment: Alignment.centerLeft,
                sizes: ColScreen(sm: Col.col_2),
                child: Text('Allow prospect activity anytime'),
              ),
              BsCol(
                alignment: Alignment.centerLeft,
                sizes: ColScreen(sm: Col.col_10),
                child: Obx(() {
                  return Cetekan(source.allowProsAct.value, onTap: (value) => source.allowProsAct.value = value);
                }),
              ),
            ],
          ),
        ),
        BsCol(
          margin: EdgeInsets.only(top: 10),
          child: Obx(
            () => BsRow(
              children: [
                BsCol(
                  margin: EdgeInsets.only(top: 15),
                  alignment: Alignment.centerLeft,
                  sizes: ColScreen(sm: Col.col_2),
                  child: Text('Company Type'),
                ),
                if (source.show.value)
                  BsCol(
                    sizes: ColScreen(sm: Col.col_10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        selectSubdistrict(context),
                        if (permis
                            .where((element) => element.menunm == 'Settings')
                            .first
                            .children!
                            .where((element) => element.menunm == 'Company Setting')
                            .first
                            .features!
                            .where((element) => element.featslug == 'update')
                            .first
                            .permissions!
                            .hasaccess!)
                          Obx(() {
                            return BsCol(
                              margin: EdgeInsets.only(top: 10),
                              sizes: ColScreen(sm: Col.col_2),
                              child: ThemeButtonSave(
                                onPressed: () => onSave(context),
                                processing: presenter.isProcessing.value,
                                disabled: presenter.isProcessing.value,
                              ),
                            );
                          }),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void onSave(BuildContext context) async {
    presenter.setProcessing(true);
    Map<String, dynamic> data = await source.toJson();
    int? bpid = GetStorage().read('mybpid');
    presenter.update(context, data, bpid!);
  }

  Widget selectSubdistrict(context) {
    return FormGroup(
      child: CustomSelectBox(
        searchable: true,
        disabled: source.isProcessing,
        controller: source.choosedType,
        hintText: BaseText.hiintSelect(field: "Type"),
        serverSide: (params) => selectApiBpType(params),
        validators: [
          Validators.selectRequired("Type"),
        ],
        onChange: (val) async {
          if (val.getValueAsString() == 'add') {
            SessionModel session = await SessionManager.current();
            typePresenter.save(context, {
              'typename': val.getOtherValue()['name'],
              'typemasterid': val.getOtherValue()['masterid'],
              'createdby': session.userid,
              'updatedby': session.userid,
              'isactive': true,
            });
          }
        },
      ),
    );
  }

  @override
  void onSuccessFetchData(Response response) {
    presenter.setProcessing(false);
    BusinessPartnerModel businessPartner = BusinessPartnerModel.fromJson(response.body);
    _source.update((val) {
      source.allowDayAct.value = businessPartner.bpdayactanytime ?? false;
      source.allowProsAct.value = businessPartner.bpprosactanytime ?? false;
      source.inputName.text = businessPartner.bpname ?? "";
      source.inputPIC.text = businessPartner.bppicname ?? "";
      source.inputEmail.text = businessPartner.bpemail ?? "";
      source.inputPhone.text = businessPartner.bpphone ?? "";
      source.choosedType.setSelected(BsSelectBoxOption(value: businessPartner.bptype?.typeid, text: Text(businessPartner.bptype!.typename!)));
    });
    source.show.value = true;
  }

  @override
  void onCreateSuccess(Response response, {BuildContext? context}) {
    source.choosedType.clear();
    Snackbar().createSuccess(context!);
  }

  @override
  void onDeleteSuccess(Response response, {BuildContext? context}) {}

  @override
  void onEditSuccess(Response response, {BuildContext? context}) async {
    presenter.setProcessing(false);
    fetchData();
    Snackbar().editSuccess(context!);
  }

  @override
  void onErrorRequest(Response response) {}

  @override
  void onLoadDatatables(BuildContext context, Response response) {}
}

// ignore: must_be_immutable
class Cetekan extends StatelessWidget {
  Function(bool)? onTap;
  Cetekan(bool value, {this.onTap}) {
    isActive = Rx(value);
  }
  late Rx<bool> isActive;
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        isActive.toggle();
        onTap?.call(isActive.value);
      },
      child: Obx(() {
        return Icon(
          isActive.value ? Icons.toggle_on : Icons.toggle_off,
          size: 35,
          color: isActive.value ? ColorPallates.onDarkMode : ColorPallates.red,
        );
      }),
    );
  }
}
