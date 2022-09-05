part of '../company.dart';

final _navigation = Get.find<NavigationPresenter>();

class _TabGeneral extends StatelessWidget implements EditViewContract {
  final _source = GeneralSource().obs;
  GeneralSource get source => _source.value;
  GeneralPresenter get presenter => Get.find<GeneralPresenter>();

  _TabGeneral() {
    presenter.businessPartnerFetchDataContract = this;
    fetchData();
  }

  void fetchData() async {
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
          margin: EdgeInsets.only(top: 20),
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
          margin: EdgeInsets.only(top: 20),
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
          margin: EdgeInsets.only(top: 20),
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
          margin: EdgeInsets.only(top: 20),
          child: BsRow(
            children: [
              BsCol(
                sizes: ColScreen(sm: Col.col_4),
                child: Text('Type'),
              ),
              BsCol(
                sizes: ColScreen(sm: Col.col_7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    selectSubdistrict(),
                    BsCol(
                      margin: EdgeInsets.only(top: 10),
                      sizes: ColScreen(sm: Col.col_1),
                      child: BsButton(
                        label: Text("Save Change"),
                        onPressed: () {},
                        prefixIcon: Icons.edit,
                        size: BsButtonSize.btnIconSm,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
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
    _source.update((val) {
      BusinessPartnerModel businessPartner = BusinessPartnerModel.fromJson(response.body);
      source.inputName.text = businessPartner.bpname ?? "";
      source.inputPIC.text = businessPartner.bppicname ?? "";
      source.inputEmail.text = businessPartner.bpemail ?? "";
      source.inputPhone.text = businessPartner.bpphone ?? "";
      source.choosedType.setSelected(BsSelectBoxOption(value: businessPartner.bptype?.typeid, text: Text(businessPartner.bptype!.typename!)));
    });
  }
}
