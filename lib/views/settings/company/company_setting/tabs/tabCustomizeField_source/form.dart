part of '../../company.dart';

class _FormCustomfield extends StatelessWidget implements EditViewContract {
  String configg, data;
  _FormCustomfield(this.configg, this.data) {
    presenter.customFielddFetchDataContract = this;
  }

  final presenter = Get.find<CustomFieldPresenter>();
  final _navigation = Get.find<NavigationPresenter>();
  final sources = CustomizeFieldSource().obs;

  @override
  Widget build(BuildContext context) {
    sources.value.config.value = this.configg;
    return Obx(() {
      return BsRow(
        children: [
          BsCol(
            sizes: ColScreen(
              sm: Col.col_6,
            ),
            child: Form(
              key: sources.value.formState,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      sources.value.inputNames(),
                      sources.value.selectTypes(),
                      sources.value.checkBoxForm(data),
                      if (sources.value.visible.value && data == 'Prospect')
                        sources.value.selectProspect(),
                      if (sources.value.visible.value && data == 'Activity')
                        sources.value.selectActivity(),
                      if (sources.value.isselectbox.value)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () => sources.update((val) {
                                sources.value.inputOptions
                                    .add(TextEditingController());
                              }),
                              child: Text(
                                'Add More Option',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                            sources.value.formDetail(
                                onRemoveItem: onClickRemoveRoleItem),
                          ],
                        ),
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
                          onPressed: () =>
                              sources.value.onClickSaveModal(context),
                        ),
                        ThemeButtonCancel(
                          disabled: presenter.isProcessing.value,
                          margin: EdgeInsets.only(right: 5),
                          onPressed: () =>
                              sources.value.onClickCancelModal(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (sources.value.isEdit.value)
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
                                    Text(sources.value.createdby.value),
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
                                    Text(sources.value.createddate.value),
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
                                    Text(sources.value.updatedby.value),
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
                                    Text(sources.value.updateddate.value),
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
                                    if (sources.value.isactive.value)
                                      InkWell(
                                        child: Icon(
                                          Icons.toggle_on,
                                          size: 35,
                                          color: _navigation.darkTheme.value
                                              ? ColorPallates.onDarkMode
                                              : ColorPallates.onLightMode,
                                        ),
                                        onTap: () =>
                                            sources.value.isactive.toggle(),
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
                                            sources.value.isactive.toggle(),
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

  void onClickRemoveRoleItem(int index) {
    sources.update((val) {
      sources.value.inputOptions.removeAt(index);
    });
  }

  @override
  void onSuccessFetchData(Response response) {
    sources.value.isEdit.value = true;
    presenter.setProcessing(false);

    CustomFieldModel customField = CustomFieldModel.fromJson(response.body);
    sources.value.id.value = customField.custfid ?? 0;
    sources.value.selectType.setSelected(BsSelectBoxOption(
        value: customField.custftype!.typeid,
        text: Text(customField.custftype!.typename.toString())));
    sources.value.newprospect.value = customField.alldata ?? false;
    sources.value.visible.value = customField.onlythisdata ?? false;
    sources.value.inputName.text = customField.custfname ?? '';
    if (customField.custfreftype?.typename == 'Prospect')
      _FormCustomfield(ConfigType.prospectCustomField, 'Prospect').data =
          'Prospect';
    else
      _FormCustomfield(ConfigType.activityCustomField, 'Activity').data =
          'Activity';

    if (customField.selectoption!.isNotEmpty) {
      sources.value.inputOptions.clear();
      sources.value.isselectbox.value = true;
      sources.value.inputOptions.addAll(customField.selectoption!
          .map((e) => TextEditingController(text: e.optvalue))
          .toList());
    }

    if (customField.onlythisdata == true) {
      sources.value.selectprospect.clear();
      if (customField.custfreftype?.typename == 'Prospect') {
        sources.value.selectprospect.setSelected(BsSelectBoxOption(
            value: customField.refprospect?.prospectid,
            text: Text(
                '${customField.refprospect?.prospectname ?? ''} || ${customField.refprospect?.prospectcust?.sbccstmname ?? ''}')));
      } else {
        sources.value.selectprospect.setSelected(BsSelectBoxOption(
            value: customField.refactivity?.dayactid,
            text: Text(
                '${customField.refactivity?.dayactloclabel ?? ''} || ${customField.refactivity?.dayactdate ?? ''}')));
      }
    }

    sources.value.createdby.value =
        customField.custfcreatedby?.userfullname ?? '';
    sources.value.createddate.value = customField.createddate ?? '';
    sources.value.updatedby.value =
        customField.custfupdatedby?.userfullname ?? '';
    sources.value.updateddate.value = customField.updateddate ?? '';
    sources.value.isactive.value = customField.isactive ?? true;
  }
}
