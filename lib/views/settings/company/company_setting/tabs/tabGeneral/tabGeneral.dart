part of '../../company.dart';

class _TabGeneral extends StatelessWidget implements EditViewContract, IndexViewContract {
  final _source = GeneralSource().obs;
  GeneralSource get source => _source.value;
  CPGeneralPresenter get presenter => Get.find<CPGeneralPresenter>();

  _TabGeneral() {
    presenter.businessPartnerFetchDataContract = this;
    presenter.businessPartnerViewContract = this;
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
                sizes: ColScreen(sm: Col.col_4),
                child: Text('Name'),
              ),
              BsCol(
                sizes: ColScreen(sm: Col.col_7),
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
                sizes: ColScreen(sm: Col.col_4),
                child: Text('PIC'),
              ),
              BsCol(
                sizes: ColScreen(sm: Col.col_7),
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
                sizes: ColScreen(sm: Col.col_4),
                child: Text('Phone'),
              ),
              BsCol(
                sizes: ColScreen(sm: Col.col_7),
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
                sizes: ColScreen(sm: Col.col_4),
                child: Text('Email'),
              ),
              BsCol(
                sizes: ColScreen(sm: Col.col_7),
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
                sizes: ColScreen(sm: Col.col_4),
                child: Text('Type'),
              ),
              BsCol(
                sizes: ColScreen(sm: Col.col_7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    selectSubdistrict(),
                    Obx(() {
                      return BsCol(
                        margin: EdgeInsets.only(top: 10),
                        sizes: ColScreen(sm: Col.col_1),
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
      ],
    );
  }

  void onSave(BuildContext context) async {
    presenter.setProcessing(true);
    Map<String, dynamic> data = await source.toJson();
    int? bpid = GetStorage().read('mybpid');
    presenter.update(context, data, bpid!);
  }

  Widget selectSubdistrict() {
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
      ),
    );
  }

  @override
  void onSuccessFetchData(Response response) {
    presenter.setProcessing(false);
    BusinessPartnerModel businessPartner = BusinessPartnerModel.fromJson(response.body);
    _source.update((val) {
      source.inputName.text = businessPartner.bpname ?? "";
      source.inputPIC.text = businessPartner.bppicname ?? "";
      source.inputEmail.text = businessPartner.bpemail ?? "";
      source.inputPhone.text = businessPartner.bpphone ?? "";
    });
    source.choosedType.setSelected(BsSelectBoxOption(value: businessPartner.bptype?.typeid, text: Text(businessPartner.bptype!.typename!)));
  }

  @override
  void onCreateSuccess(Response response, {BuildContext? context}) {
    // TODO: implement onCreateSuccess
  }

  @override
  void onDeleteSuccess(Response response, {BuildContext? context}) {
    // TODO: implement onDeleteSuccess
  }

  @override
  void onEditSuccess(Response response, {BuildContext? context}) async {
    presenter.setProcessing(false);
    fetchData();
    Snackbar().editSuccess();
  }

  @override
  void onErrorRequest(Response response) {
    // TODO: implement onErrorRequest
  }

  @override
  void onLoadDatatables(BuildContext context, Response response) {
    // TODO: implement onLoadDatatables
  }
}
