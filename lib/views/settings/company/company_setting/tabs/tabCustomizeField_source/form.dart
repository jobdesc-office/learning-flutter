part of '../../company.dart';

class _FormCustomfield extends StatelessWidget implements EditViewContract {
  String configg, data;
  _FormCustomfield(this.configg, this.data);

  final presenter = Get.find<CustomFieldPresenter>();
  final _navigation = Get.find<NavigationPresenter>();
  final sources = Get.put(CustomizeFieldSource());

  @override
  Widget build(BuildContext context) {
    sources.config.value = this.configg;
    return Obx(() {
      return BsRow(
        children: [
          BsCol(
            sizes: ColScreen(
              sm: Col.col_6,
            ),
            child: Form(
              key: sources.formState,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      sources.inputNames(),
                      sources.selectTypes(),
                      sources.checkBoxForm(data),
                      if (sources.visible.value && data == 'Prospect')
                        sources.selectProspect(),
                      if (sources.visible.value && data == 'Activity')
                        sources.selectActivity()
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
                          onPressed: () => sources.onClickSaveModal(context),
                        ),
                        ThemeButtonCancel(
                          disabled: presenter.isProcessing.value,
                          margin: EdgeInsets.only(right: 5),
                          onPressed: () => sources.onClickCancelModal(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (sources.isEdit.value)
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
                                    Text(sources.createdby.value),
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
                                    Text(sources.createddate.value),
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
                                    Text(sources.updatedby.value),
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
                                    Text(sources.updateddate.value),
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
                                    if (sources.isactive.value)
                                      InkWell(
                                        child: Icon(
                                          Icons.toggle_on,
                                          size: 35,
                                          color: _navigation.darkTheme.value
                                              ? ColorPallates.onDarkMode
                                              : ColorPallates.onLightMode,
                                        ),
                                        onTap: () => sources.isactive.toggle(),
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
                                        onTap: () => sources.isactive.toggle(),
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

  @override
  void onSuccessFetchData(Response response) {
    presenter.setProcessing(false);

    CustomFieldModel customField = CustomFieldModel.fromJson(response.body);
    sources.id.value = customField.custfid ?? 0;
    sources.selectType.setSelected(BsSelectBoxOption(
        value: customField.custftype!.typeid,
        text: Text(customField.custftype!.typename.toString())));
    sources.newprospect.value = customField.alldata ?? false;
    sources.visible.value = customField.onlythisdata ?? false;
    sources.inputName.text = customField.custfname ?? '';
    if (customField.custfreftype?.typename == 'Prospect')
      data = 'Prospect';
    else
      data = 'Activity';

    if (customField.onlythisdata == true) {
      sources.selectprospect.clear();
      if (customField.custfreftype?.typename == 'Prospect') {
        sources.selectprospect.setSelected(BsSelectBoxOption(
            value: customField.refprospect?.prospectid,
            text: Text(
                '${customField.refprospect?.prospectname ?? ''} || ${customField.refprospect?.prospectcust?.sbccstmname ?? ''}')));
      } else {
        sources.selectprospect.setSelected(BsSelectBoxOption(
            value: customField.refactivity?.dayactid,
            text: Text(
                '${customField.refactivity?.dayactloclabel ?? ''} || ${customField.refactivity?.dayactdate ?? ''}')));
      }
    }

    sources.createdby.value = customField.custfcreatedby?.userfullname ?? '';
    sources.createddate.value = customField.createddate ?? '';
    sources.updatedby.value = customField.custfupdatedby?.userfullname ?? '';
    sources.updateddate.value = customField.updateddate ?? '';
    sources.isactive.value = customField.isactive ?? true;
    sources.isEdit.value = true;
    sources.isForm.value = true;
  }
}
