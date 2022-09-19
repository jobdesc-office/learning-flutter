part of '../../company.dart';

class _ContactForm extends StatelessWidget implements IndexViewContract {
  CPContactPresenter presenter = Get.find();
  final sbtpresenter = Get.find<StBpTypeActivityCategoryPresenter>();
  ContactFormSource source;

  _ContactForm(this.source) {
    sbtpresenter.stBpTypeActivityCategoryViewContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    inputName(),
                    selectCustomer(),
                    selectType(context),
                    inputValue(),
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ThemeButtonSave(
                            disabled: presenter.isProcessing.value,
                            processing: presenter.isProcessing.value,
                            margin: EdgeInsets.only(right: 5),
                            onPressed: source.isEdit.value ? update : save,
                          ),
                          ThemeButtonCancel(
                            disabled: presenter.isProcessing.value,
                            margin: EdgeInsets.only(right: 5),
                            onPressed: source.clear,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (source.isEdit.value)
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(source.createdby.value),
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
                                    Text(source.createddate.value),
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
                                    Text(source.updatedby.value),
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
                                    Text(source.updateddate.value),
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
                                    if (source.isactive.value)
                                      InkWell(
                                        child: Icon(
                                          Icons.toggle_on,
                                          size: 35,
                                          color: _navigation.darkTheme.value
                                              ? ColorPallates.onDarkMode
                                              : ColorPallates.onLightMode,
                                        ),
                                        onTap: () => source.isactive.toggle(),
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
                                        onTap: () => source.isactive.toggle(),
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
    });
  }

  void save() async {
    Map<String, dynamic> data = await source.toJson();
    presenter.save(Get.context!, data);
  }

  void update() async {
    Map<String, dynamic> data = await source.toJson();
    presenter.update(Get.context!, data, source.contactid!);
  }

  Widget inputName() {
    return FormGroup(
      label: Obx(() => Text(ContactText.labelName,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        disabled: presenter.isProcessing.value,
        controller: source.inputName,
        hintText: BaseText.hintText(field: ContactText.labelName),
        validators: [
          Validators.inputRequired(ContactText.labelName),
          Validators.maxLength(ContactText.labelName, 255)
        ],
      ),
    );
  }

  Widget selectCustomer() {
    return FormGroup(
      label: Obx(() => Text(ContactText.labelCustomer,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomSelectBox(
        searchable: true,
        disabled: presenter.isProcessing.value,
        controller: source.selectCustomer,
        hintText: BaseText.hiintSelect(field: ContactText.labelCustomer),
        serverSide: (params) => selectApiCustomer(params),
        validators: [
          Validators.selectRequired(ContactText.labelCustomer),
        ],
      ),
    );
  }

  Widget selectType(context) {
    return FormGroup(
      label: Obx(() => Text(ContactText.labelType,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomSelectBox(
        disabled: presenter.isProcessing.value,
        controller: source.selectType,
        hintText: BaseText.hiintSelect(field: ContactText.labelType),
        serverSide: (params) => selectApiContactTypes(params),
        validators: [
          Validators.selectRequired(ContactText.labelType),
        ],
        onChange: (value) async {
          if (value.getValueAsString() == 'add') {
            SessionModel session = await SessionManager.current();
            sbtpresenter.save(context, {
              'sbtbpid': box.read('mybpid'),
              'sbtname': value.getOtherValue()['master'],
              'sbttypemasterid': value.getOtherValue()['masterid'],
              'sbttypename': value.getOtherValue()['name'],
              'createdby': session.userid,
              'updatedby': session.userid,
              'isactive': true,
            });
            source.selectType.clear();
          }
        },
      ),
    );
  }

  Widget inputValue() {
    return FormGroup(
      label: Obx(() => Text(ContactText.labelValue,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        minLines: 3,
        maxLines: 5,
        disabled: presenter.isProcessing.value,
        controller: source.inputValue,
        hintText: BaseText.hintText(field: ContactText.labelValue),
      ),
    );
  }

  @override
  void onCreateSuccess(Response response, {BuildContext? context}) {
    Snackbar().createSuccess(context!);
  }

  @override
  void onDeleteSuccess(Response response, {BuildContext? context}) {
    // TODO: implement onDeleteSuccess
  }

  @override
  void onEditSuccess(Response response, {BuildContext? context}) {
    // TODO: implement onEditSuccess
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
