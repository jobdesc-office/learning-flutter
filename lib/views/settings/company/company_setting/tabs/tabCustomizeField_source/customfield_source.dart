part of '../../company.dart';

class CustomizeFieldSource extends GetxController implements EditViewContract {
  CustomizeFieldSource() {
    presenter.customFieldFetchDataContract = this;
  }
  final _type = Get.put(TypeService());
  var id = 0.obs;

  var visible = false.obs;
  var newprospect = false.obs;

  var createdby = ''.obs;
  var createddate = ''.obs;
  var updatedby = ''.obs;
  var updateddate = ''.obs;
  var isactive = true.obs;

  reset() {
    id.value = 0;
    visible.value = false;
    newprospect.value = false;

    createdby.value = '';
    createddate.value = '';
    updatedby.value = '';
    updateddate.value = '';
    isactive.value = false;

    selectType.clear();
    selectprospect.clear();

    inputName.text = '';
  }

  BsSelectBoxController selectType = BsSelectBoxController();
  BsSelectBoxController selectprospect = BsSelectBoxController();

  TextEditingController inputName = TextEditingController();

  Future<Map<String, dynamic>> toJson() async {
    SessionModel session = await SessionManager.current();
    Response res = await _type.byCodeMaster(ConfigType.prospectCustomField);
    int id = TypeModel.fromJson(res.body.first).typeid ?? 0;
    return {
      'custfbpid': box.read('mybpid').toString(),
      'custftypeid': selectType.getSelectedAsString(),
      'custfname': inputName.text,
      'custfreftypeid': id,
      'alldata': newprospect.value,
      'onlythisdata': visible.value,
      'thisdataid': selectprospect.getSelectedAsString(),
      'createdby': session.userid,
      'updatedby': session.userid,
      'isactive': isactive.value,
    };
  }

  var isEdit = false.obs;
  var isForm = false.obs;
  final presenter = Get.find<CustomFieldPresenter>();
  final datatable = CustomFieldDataTableSource();
  final _navigation = Get.find<NavigationPresenter>();
  final source = CustomFieldSource().obs;

  final GlobalKey<FormState> formState = GlobalKey<FormState>();

  Widget form(BuildContext context) {
    return Obx(() {
      return BsRow(
        children: [
          BsCol(
            sizes: ColScreen(
              sm: Col.col_6,
            ),
            child: Form(
              key: formState,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      inputNames(),
                      selectTypes(),
                      checkBoxForm(),
                      if (visible.value) selectProspect()
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
          if (isEdit.value)
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
                                  children: [Text(createdby.value), Divider()],
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
                                    Text(createddate.value),
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
                                  children: [Text(updatedby.value), Divider()],
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
                                    Text(updateddate.value),
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
                                    if (isactive.value)
                                      InkWell(
                                        child: Icon(
                                          Icons.toggle_on,
                                          size: 35,
                                          color: _navigation.darkTheme.value
                                              ? ColorPallates.onDarkMode
                                              : ColorPallates.onLightMode,
                                        ),
                                        onTap: () => isactive.toggle(),
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
                                        onTap: () => isactive.toggle(),
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

  void onClickSaveModal(BuildContext context) async {
    presenter.setProcessing(true);
    if (formState.currentState!.validate()) {
      if (isEdit.value) {
        presenter.update(context, await toJson(), id.value);
      } else {
        if (formState.currentState!.validate()) {
          presenter.save(context, await toJson());
        } else
          presenter.setProcessing(false);
      }
    } else
      presenter.setProcessing(false);
  }

  void onClickCancelModal(BuildContext context) {
    if (isEdit.value) {
      isEdit.value = false;
      isForm.toggle();
      reset();
    } else {
      isForm.toggle();
      reset();
    }
  }

  Widget selectTypes() {
    return FormGroup(
      label: Obx(() => Text(CustomFieldText.labelType,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomSelectBox(
        searchable: false,
        controller: selectType,
        hintText: BaseText.hiintSelect(field: CustomFieldText.labelType),
        serverSide: (params) => selectApiCustomFieldTypes(params),
        validators: [
          Validators.selectRequired(CustomFieldText.labelType),
        ],
      ),
    );
  }

  Widget selectProspect() {
    return FormGroup(
      label: Obx(() => Text(CustomFieldText.labelBp,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomSelectBox(
        controller: selectprospect,
        hintText: BaseText.hiintSelect(field: CustomFieldText.labelBp),
        serverSide: (params) => selectApiProspect(params),
        validators: [
          Validators.selectRequired(CustomFieldText.labelBp),
        ],
      ),
    );
  }

  Widget inputNames() {
    return FormGroup(
      label: Obx(() => Text(CustomFieldText.labelName,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        controller: inputName,
        hintText: BaseText.hiintSelect(field: CustomFieldText.labelName),
        validators: [
          Validators.inputRequired(CustomFieldText.labelName),
        ],
      ),
    );
  }

  Widget checkBoxForm() {
    return BsRow(
      children: [
        BsCol(
          margin: EdgeInsets.only(right: 10),
          sizes: ColScreen(lg: Col.col_2),
          child: FormGroup(
            label: Obx(() => Center(
                  child: Text(CustomFieldText.isVisible,
                      style: TextStyle(
                          color: _navigation.darkTheme.value
                              ? Colors.white
                              : Colors.black)),
                )),
            child: Obx(() => Center(
                  child: Checkbox(
                    value: visible.value,
                    onChanged: (value) {
                      newprospect.value = !value!;

                      visible.value = value;
                    },
                  ),
                )),
          ),
        ),
        BsCol(
          margin: EdgeInsets.only(right: 10),
          sizes: ColScreen(lg: Col.col_2),
          child: FormGroup(
            label: Obx(() => Center(
                  child: Text(CustomFieldText.labelNewPropect,
                      style: TextStyle(
                          color: _navigation.darkTheme.value
                              ? Colors.white
                              : Colors.black)),
                )),
            child: Obx(() => Center(
                  child: Checkbox(
                    value: newprospect.value,
                    onChanged: (value) {
                      visible.value = !value!;

                      newprospect.value = value;
                    },
                  ),
                )),
          ),
        ),
      ],
    );
  }

  @override
  void onSuccessFetchData(Response response) {
    presenter.setProcessing(false);
    isEdit.value = true;
    isForm.value = true;

    source.update((val) {
      CustomFieldModel customField = CustomFieldModel.fromJson(response.body);
      id.value = customField.custfid ?? 0;
      selectType.setSelected(BsSelectBoxOption(
          value: customField.custftype!.typeid,
          text: Text(customField.custftype!.typename.toString())));
      selectprospect.setSelected(BsSelectBoxOption(
          value: customField.businesspartner!.bpid,
          text: Text(customField.businesspartner!.bpname.toString())));
      newprospect.value = customField.allprospect ?? false;
      visible.value = customField.onlythisprospect ?? false;
      inputName.text = customField.custfname ?? '';

      createdby.value = customField.custfcreatedby?.userfullname ?? '';
      createddate.value = customField.createddate ?? '';
      updatedby.value = customField.custfupdatedby?.userfullname ?? '';
      updateddate.value = customField.updateddate ?? '';
      isactive.value = customField.isactive ?? true;
    });
  }
}
