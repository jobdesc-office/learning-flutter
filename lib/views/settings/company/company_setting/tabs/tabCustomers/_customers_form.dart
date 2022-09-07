part of '../../company.dart';

class _CustomersForm extends StatelessWidget {
  CPCustomerPresenter get presenter => Get.find<CPCustomerPresenter>();
  CustomerFormSource source;

  _CustomersForm(this.source);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return BsRow(
        children: [
          BsCol(
            sizes: ColScreen(
              sm: Col.col_6,
            ),
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: _navigation.darkTheme.value ? ColorPallates.elseDarkColor : Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BsRow(
                      children: [
                        BsCol(
                          margin: EdgeInsets.only(bottom: 10),
                          sizes: ColScreen(sm: Col.col_4),
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.grey.shade300)),
                            child: Container(
                              margin: EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  btnImage(),
                                ],
                              ),
                            ),
                          ),
                        ),
                        BsCol(
                          margin: EdgeInsets.only(left: 10, bottom: 10),
                          sizes: ColScreen(sm: Col.col_8),
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.grey.shade300)),
                            child: Container(
                              margin: EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  selectCustomer(),
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
                            onPressed: source.isEdit ? update : save,
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
          if (source.isEdit)
            BsCol(
              margin: EdgeInsets.only(left: 5),
              sizes: ColScreen(lg: Col.col_6),
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: _navigation.darkTheme.value ? ColorPallates.elseDarkColor : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: BsRow(
                  children: [
                    BsCol(
                      child: BsRow(
                        children: [
                          BsCol(
                            child: FormGroup(
                                label: Text('Created By', style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [Text(source.createdby.value), Divider()],
                                )),
                          ),
                          BsCol(
                            margin: EdgeInsets.only(top: 10),
                            child: FormGroup(
                                label: Text('Created At', style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [Text(source.createddate.value), Divider()],
                                )),
                          ),
                          BsCol(
                            margin: EdgeInsets.only(top: 10),
                            child: FormGroup(
                                label: Text('Last Updated By', style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [Text(source.updatedby.value), Divider()],
                                )),
                          ),
                          BsCol(
                            margin: EdgeInsets.only(top: 10),
                            child: FormGroup(
                                label: Text('Last Updated At', style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [Text(source.updateddate.value), Divider()],
                                )),
                          ),
                          BsCol(
                            margin: EdgeInsets.only(top: 10),
                            child: FormGroup(
                                label: Text('Is Active', style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (source.isactive.value)
                                      InkWell(
                                        child: Icon(
                                          Icons.toggle_on,
                                          size: 35,
                                          color: _navigation.darkTheme.value ? ColorPallates.onDarkMode : ColorPallates.onLightMode,
                                        ),
                                        onTap: source.isactive.toggle,
                                      )
                                    else
                                      InkWell(
                                        child: Icon(
                                          Icons.toggle_off,
                                          size: 35,
                                          color: _navigation.darkTheme.value ? ColorPallates.offDarkMode : ColorPallates.offLightMode,
                                        ),
                                        onTap: source.isactive.toggle,
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

  Widget selectCustomer() {
    return FormGroup(
      label: Obx(() => Text("Customer", style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomSelectBox(
        searchable: true,
        disabled: source.isProcessing,
        controller: source.selectCustomer,
        hintText: BaseText.hiintSelect(field: "Customer"),
        serverSide: (params) => selectApiCustomer(params),
        validators: [
          Validators.selectRequired("Customer"),
        ],
      ),
    );
  }

  Widget btnImage() {
    return FormGroup(
      child: Center(
        child: Obx(() => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (source.isImage.value) Image.memory(source.image.value),
                if (source.isEdit) Image.network(source.imageupdate.value),
                BsButton(
                  margin: EdgeInsets.only(top: 10),
                  onPressed: () async {
                    Uint8List? fromPicker = await ImagePickerWeb.getImageAsBytes();
                    if (fromPicker != null) {
                      source.image.value = fromPicker;
                      source.isImage.value = true;
                    }
                  },
                  label: Text(
                    "Image",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  void save() async {
    presenter.isProcessing.value = true;
    source.isProcessing = true;
    Map<String, dynamic> data = await source.toJson();
    FormData formData = FormData(data);
    presenter.save(Get.context!, formData);
  }

  void update() async {
    presenter.isProcessing.value = true;
    source.isProcessing = true;
    Map<String, dynamic> data = await source.toJson();
    FormData formData = FormData(data);
    presenter.update(Get.context!, formData, source.bpcstmid!);
  }
}
